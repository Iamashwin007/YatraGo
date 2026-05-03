package com.yatrago.route.dao;

import com.yatrago.route.model.RouteModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RouteDAO {

    public boolean isRouteExist(String origin, String destination) {
        String sql = "SELECT id FROM routes WHERE origin = ? AND destination = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, origin);
            ps.setString(2, destination);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println("Error checking route existence: " + e.getMessage());
            return false;
        }
    }

    public boolean addRoute(RouteModel route) {
        String sql = "INSERT INTO routes (origin, destination, distance_km, duration_hours, base_fare, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, route.getOrigin());
            ps.setString(2, route.getDestination());
            ps.setBigDecimal(3, route.getDistanceKm());
            ps.setBigDecimal(4, route.getDurationHours());
            ps.setBigDecimal(5, route.getBaseFare());
            ps.setString(6, route.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error adding route: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<RouteModel> getAllRoutes() {
        ArrayList<RouteModel> routes = new ArrayList<>();
        String sql = "SELECT * FROM routes ORDER BY created_at DESC";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RouteModel route = new RouteModel();
                route.setId(rs.getInt("id"));
                route.setOrigin(rs.getString("origin"));
                route.setDestination(rs.getString("destination"));
                route.setDistanceKm(rs.getBigDecimal("distance_km"));
                route.setDurationHours(rs.getBigDecimal("duration_hours"));
                route.setBaseFare(rs.getBigDecimal("base_fare"));
                route.setStatus(rs.getString("status"));
                route.setCreatedAt(rs.getTimestamp("created_at"));
                route.setUpdatedAt(rs.getTimestamp("updated_at"));
                routes.add(route);
            }
        } catch (Exception e) {
            System.out.println("Error fetching routes: " + e.getMessage());
        }
        return routes;
    }

    public RouteModel getRouteById(int id) {
        String sql = "SELECT * FROM routes WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                RouteModel route = new RouteModel();
                route.setId(rs.getInt("id"));
                route.setOrigin(rs.getString("origin"));
                route.setDestination(rs.getString("destination"));
                route.setDistanceKm(rs.getBigDecimal("distance_km"));
                route.setDurationHours(rs.getBigDecimal("duration_hours"));
                route.setBaseFare(rs.getBigDecimal("base_fare"));
                route.setStatus(rs.getString("status"));
                route.setCreatedAt(rs.getTimestamp("created_at"));
                route.setUpdatedAt(rs.getTimestamp("updated_at"));
                return route;
            }
        } catch (Exception e) {
            System.out.println("Error fetching route by id: " + e.getMessage());
        }
        return null;
    }

    public boolean updateRoute(RouteModel route) {
        String sql = "UPDATE routes SET origin=?, destination=?, distance_km=?, duration_hours=?, base_fare=?, status=? WHERE id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, route.getOrigin());
            ps.setString(2, route.getDestination());
            ps.setBigDecimal(3, route.getDistanceKm());
            ps.setBigDecimal(4, route.getDurationHours());
            ps.setBigDecimal(5, route.getBaseFare());
            ps.setString(6, route.getStatus());
            ps.setInt(7, route.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating route: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteRoute(int id) {
        String sql = "DELETE FROM routes WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting route: " + e.getMessage());
            return false;
        }
    }

    public int getCount() {
        String sql = "SELECT COUNT(*) FROM routes";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Error getting route count: " + e.getMessage());
        }
        return 0;
    }
}
