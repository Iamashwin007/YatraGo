package com.yatrago.booking.dao;

import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

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

    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM bookings WHERE status != 'cancelled'";
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
}
