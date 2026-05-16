package com.yatrago.booking.dao;

import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// DAO for reading booking statistics shown on the admin dashboard.
// All methods are read-only (SELECT only) — booking creation is handled by other servlets.
public class BookingDAO {

    // Counts every row in the bookings table, including cancelled ones.
    // The dashboard shows this as the "all-time total" so the admin can see overall volume.
    public int getTotalBookingsCount() {
        String sql = "SELECT COUNT(*) FROM bookings";
        // try-with-resources automatically closes the connection when the block ends,
        // so we never accidentally leave a database connection open.
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            // The cursor starts before the first row, so rs.next() must be called to move to it.
            // COUNT(*) always returns exactly one row, so one if (rs.next()) is enough.
            if (rs.next()) return rs.getInt(1); // column 1 is the COUNT result
        } catch (Exception e) {
            System.out.println("Error getting total bookings count: " + e.getMessage());
        }
        // Safe default: if the query fails or the table is empty, return 0 instead of crashing.
        return 0;
    }

    // Adds up total_amount for every booking that has NOT been cancelled.
    // Cancelled bookings are excluded because the money was never collected (or was refunded).
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM bookings WHERE status != 'cancelled'";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double revenue = rs.getDouble(1);
                // When there are no matching rows, SQL SUM returns NULL, not 0.
                // JDBC reads NULL as 0.0, but wasNull() lets us detect this and return 0.0 explicitly.
                if (rs.wasNull()) return 0.0;
                return revenue;
            }
        } catch (Exception e) {
            System.out.println("Error getting total revenue: " + e.getMessage());
        }
        return 0.0;
    }

    // Counts only bookings with status = 'confirmed'.
    // Shown separately on the dashboard so the admin can see how many bookings are currently active,
    // as opposed to the all-time total which includes cancelled and pending ones.
    public int getConfirmedBookingsCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'confirmed'";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Error getting confirmed bookings count: " + e.getMessage());
        }
        return 0;
    }

    // Returns one row per route: the route label and how many bookings it has, busiest first.
    // We use List<String[]> (not a model class) because the JSP only needs to display two strings per row.
    public List<String[]> getBookingsPerRoute() {
        List<String[]> results = new ArrayList<>();
        // CONCAT builds a human-readable label like "Kathmandu to Pokhara" from the two separate columns.
        // The bookings table only stores schedule_id, so we need a JOIN chain to get the route name:
        // bookings → schedules (to find which route) → routes (to get origin and destination).
        // GROUP BY collapses the many booking rows into one row per route so COUNT gives a single total.
        // ORDER BY booking_count DESC puts the most popular route at the top of the dashboard table.
        String sql = "SELECT CONCAT(r.origin, ' to ', r.destination) AS route_label, COUNT(b.id) AS booking_count " +
                     "FROM bookings b " +
                     "JOIN schedules s ON b.schedule_id = s.id " +
                     "JOIN routes r ON s.route_id = r.id " +
                     "GROUP BY r.id, r.origin, r.destination " +
                     "ORDER BY booking_count DESC";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            // This query returns multiple rows (one per route), so we loop with while, not if.
            while (rs.next()) {
                results.add(new String[]{
                    rs.getString("route_label"),
                    rs.getString("booking_count")
                });
            }
        } catch (Exception e) {
            System.out.println("Error getting bookings per route: " + e.getMessage());
        }
        // Return the list even if it is empty — the JSP forEach loop handles an empty list safely.
        // Returning null instead would cause a NullPointerException in the JSP.
        return results;
    }
}
