package com.yatrago.booking.dao;

import com.yatrago.booking.model.BookingModel;
import com.yatrago.booking.model.BookingSeatModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // ══════════════════════════════════════════════════════════════════════
    //  ADMIN DASHBOARD — read-only aggregate queries
    // ══════════════════════════════════════════════════════════════════════

    // Counts every row in the bookings table, including cancelled ones.
    public int getTotalBookingsCount() {
        String sql = "SELECT COUNT(*) FROM bookings";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Error getting total bookings count: " + e.getMessage());
        }
        return 0;
    }

    // Adds up total_fare for every booking that has NOT been cancelled.
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_fare) FROM bookings WHERE booking_status != 'cancelled'";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double revenue = rs.getDouble(1);
                if (rs.wasNull()) return 0.0;
                return revenue;
            }
        } catch (Exception e) {
            System.out.println("Error getting total revenue: " + e.getMessage());
        }
        return 0.0;
    }

    // Counts only bookings with booking_status = 'confirmed'.
    public int getConfirmedBookingsCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE booking_status = 'confirmed'";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Error getting confirmed bookings count: " + e.getMessage());
        }
        return 0;
    }

    // Returns one row per route: route label and booking count, busiest first.
    public List<String[]> getBookingsPerRoute() {
        List<String[]> results = new ArrayList<>();
        String sql = "SELECT CONCAT(r.origin, ' to ', r.destination) AS route_label, COUNT(b.id) AS booking_count " +
                "FROM bookings b " +
                "JOIN schedules s ON b.schedule_id = s.id " +
                "JOIN routes r ON s.route_id = r.id " +
                "GROUP BY r.id, r.origin, r.destination " +
                "ORDER BY booking_count DESC";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                results.add(new String[]{
                        rs.getString("route_label"),
                        rs.getString("booking_count")
                });
            }
        } catch (Exception e) {
            System.out.println("Error getting bookings per route: " + e.getMessage());
        }
        return results;
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD — createBooking
    //  Inserts one booking row + all its seat rows in one transaction.
    //  Returns false on any failure — never true unless DB committed.
    // ══════════════════════════════════════════════════════════════════════
    public boolean createBooking(BookingModel booking, ArrayList<BookingSeatModel> seats) {

        String bookingSql =
                "INSERT INTO bookings (user_id, schedule_id, booking_reference, " +
                        "total_fare, passenger_count, booking_status) VALUES (?, ?, ?, ?, ?, ?)";

        String seatSql =
                "INSERT INTO booking_seats (booking_id, seat_number, passenger_name, passenger_age) " +
                        "VALUES (?, ?, ?, ?)";

        try (Connection con = DbConnection.getConnection()) {

            if (con == null) return false;

            con.setAutoCommit(false);

            try (PreparedStatement bookingPs =
                         con.prepareStatement(bookingSql, Statement.RETURN_GENERATED_KEYS)) {

                bookingPs.setInt(1,        booking.getUserId());
                bookingPs.setInt(2,        booking.getScheduleId());
                bookingPs.setString(3,     booking.getBookingReference());
                bookingPs.setBigDecimal(4, booking.getTotalFare());
                bookingPs.setInt(5,        booking.getPassengerCount());
                bookingPs.setString(6,
                        booking.getBookingStatus() == null ? "confirmed" : booking.getBookingStatus());

                int rows = bookingPs.executeUpdate();
                if (rows == 0) { con.rollback(); return false; }

                try (ResultSet keys = bookingPs.getGeneratedKeys()) {
                    if (keys.next()) {
                        int generatedId = keys.getInt(1);
                        booking.setId(generatedId);
                        for (BookingSeatModel seat : seats) {
                            seat.setBookingId(generatedId);
                        }
                    } else {
                        con.rollback();
                        return false;
                    }
                }
            }

            try (PreparedStatement seatPs = con.prepareStatement(seatSql)) {
                for (BookingSeatModel seat : seats) {
                    seatPs.setInt(1, seat.getBookingId());
                    seatPs.setInt(2, seat.getSeatNumber());
                    seatPs.setString(3, seat.getPassengerName());
                    if (seat.getPassengerAge() != null) {
                        seatPs.setInt(4, seat.getPassengerAge());
                    } else {
                        seatPs.setNull(4, java.sql.Types.INTEGER);
                    }
                    seatPs.addBatch();
                }
                seatPs.executeBatch();
            }

            con.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error creating booking: " + e.getMessage());
            return false;
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD — getBookingsByUser
    //  Returns all bookings for a user with route + bus info via JOINs.
    // ══════════════════════════════════════════════════════════════════════
    public ArrayList<BookingModel> getBookingsByUser(int userId) {

        ArrayList<BookingModel> bookings = new ArrayList<>();

        String sql =
                "SELECT b.id, b.user_id, b.schedule_id, b.booking_reference, " +
                        "       b.total_fare, b.passenger_count, b.booking_status, " +
                        "       b.created_at, b.updated_at, " +
                        "       s.departure_time, s.arrival_time, s.available_seats, s.fare AS schedule_fare, " +
                        "       r.origin, r.destination, " +
                        "       bu.bus_number, bu.operator_name, bu.bus_type " +
                        "FROM bookings b " +
                        "JOIN schedules s ON b.schedule_id = s.id " +
                        "JOIN routes r    ON s.route_id    = r.id " +
                        "JOIN buses bu    ON s.bus_id       = bu.id " +
                        "WHERE b.user_id = ? " +
                        "ORDER BY b.created_at DESC";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return bookings;

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookings.add(mapBookingRow(rs));
            }

        } catch (Exception e) {
            System.out.println("Error fetching bookings for user: " + e.getMessage());
        }

        return bookings;
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD — getBookingById
    //  Returns one booking WITH its seats list attached.
    //  Used by the e-ticket JSP. Returns null if not found.
    // ══════════════════════════════════════════════════════════════════════
    public BookingModel getBookingById(int bookingId) {

        String bookingSql =
                "SELECT b.id, b.user_id, b.schedule_id, b.booking_reference, " +
                        "       b.total_fare, b.passenger_count, b.booking_status, " +
                        "       b.created_at, b.updated_at, " +
                        "       s.departure_time, s.arrival_time, s.available_seats, s.fare AS schedule_fare, " +
                        "       r.origin, r.destination, " +
                        "       bu.bus_number, bu.operator_name, bu.bus_type " +
                        "FROM bookings b " +
                        "JOIN schedules s ON b.schedule_id = s.id " +
                        "JOIN routes r    ON s.route_id    = r.id " +
                        "JOIN buses bu    ON s.bus_id       = bu.id " +
                        "WHERE b.id = ?";

        String seatsSql =
                "SELECT id, booking_id, seat_number, passenger_name, passenger_age, created_at " +
                        "FROM booking_seats WHERE booking_id = ? ORDER BY seat_number";

        try (Connection con = DbConnection.getConnection()) {

            if (con == null) return null;

            BookingModel booking = null;

            try (PreparedStatement ps = con.prepareStatement(bookingSql)) {
                ps.setInt(1, bookingId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    booking = mapBookingRow(rs);
                }
            }

            if (booking == null) return null;

            ArrayList<BookingSeatModel> seats = new ArrayList<>();
            try (PreparedStatement seatPs = con.prepareStatement(seatsSql)) {
                seatPs.setInt(1, bookingId);
                ResultSet srs = seatPs.executeQuery();
                while (srs.next()) {
                    BookingSeatModel seat = new BookingSeatModel();
                    seat.setId(srs.getInt("id"));
                    seat.setBookingId(srs.getInt("booking_id"));
                    seat.setSeatNumber(srs.getInt("seat_number"));
                    seat.setPassengerName(srs.getString("passenger_name"));
                    seat.setPassengerAge((Integer) srs.getObject("passenger_age"));
                    seat.setCreatedAt(srs.getTimestamp("created_at"));
                    seats.add(seat);
                }
            }

            booking.setSeats(seats);
            return booking;

        } catch (Exception e) {
            System.out.println("Error fetching booking by id: " + e.getMessage());
            return null;
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD — cancelBooking
    //  Sets status = 'cancelled' AND restores seats to the schedule.
    //  Both updates happen in ONE transaction.
    // ══════════════════════════════════════════════════════════════════════
    public boolean cancelBooking(int bookingId) {

        int passengerCount;
        int scheduleId;

        String fetchSql =
                "SELECT passenger_count, schedule_id FROM bookings " +
                        "WHERE id = ? AND booking_status != 'cancelled'";

        try (Connection fetchCon = DbConnection.getConnection();
             PreparedStatement fetchPs = fetchCon.prepareStatement(fetchSql)) {

            if (fetchCon == null) return false;

            fetchPs.setInt(1, bookingId);
            ResultSet rs = fetchPs.executeQuery();

            if (!rs.next()) {
                System.out.println("cancelBooking: booking " + bookingId + " not found or already cancelled.");
                return false;
            }

            passengerCount = rs.getInt("passenger_count");
            scheduleId     = rs.getInt("schedule_id");

        } catch (Exception e) {
            System.out.println("Error reading booking for cancel: " + e.getMessage());
            return false;
        }

        String cancelSql =
                "UPDATE bookings SET booking_status = 'cancelled', updated_at = NOW() " +
                        "WHERE id = ? AND booking_status != 'cancelled'";

        String restoreSql =
                "UPDATE schedules SET available_seats = available_seats + ? WHERE id = ?";

        try (Connection con = DbConnection.getConnection()) {

            if (con == null) return false;

            con.setAutoCommit(false);

            try (PreparedStatement cancelPs = con.prepareStatement(cancelSql)) {
                cancelPs.setInt(1, bookingId);
                int updated = cancelPs.executeUpdate();
                if (updated == 0) {
                    con.rollback();
                    return false;
                }
            }

            try (PreparedStatement restorePs = con.prepareStatement(restoreSql)) {
                restorePs.setInt(1, passengerCount);
                restorePs.setInt(2, scheduleId);
                restorePs.executeUpdate();
            }

            con.commit();
            return true;

        } catch (Exception e) {
            System.out.println("Error cancelling booking: " + e.getMessage());
            return false;
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    //  PRIVATE HELPER — mapBookingRow
    // ══════════════════════════════════════════════════════════════════════
    private BookingModel mapBookingRow(ResultSet rs) throws Exception {
        BookingModel b = new BookingModel();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setScheduleId(rs.getInt("schedule_id"));
        b.setBookingReference(rs.getString("booking_reference"));
        b.setTotalFare(rs.getBigDecimal("total_fare"));
        b.setPassengerCount(rs.getInt("passenger_count"));
        b.setBookingStatus(rs.getString("booking_status"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        b.setUpdatedAt(rs.getTimestamp("updated_at"));
        b.setDepartureTime(rs.getTimestamp("departure_time"));
        b.setArrivalTime(rs.getTimestamp("arrival_time"));
        b.setAvailableSeats(rs.getInt("available_seats"));
        b.setScheduleFare(rs.getBigDecimal("schedule_fare"));
        b.setOrigin(rs.getString("origin"));
        b.setDestination(rs.getString("destination"));
        b.setBusNumber(rs.getString("bus_number"));
        b.setOperatorName(rs.getString("operator_name"));
        b.setBusType(rs.getString("bus_type"));
        return b;
    }
}
