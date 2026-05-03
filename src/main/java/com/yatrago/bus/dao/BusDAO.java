package com.yatrago.bus.dao;

import com.yatrago.bus.model.BusModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BusDAO {

    public boolean isBusNumberExist(String busNumber) {
        String sql = "SELECT id FROM buses WHERE bus_number = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, busNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println("Error checking bus number: " + e.getMessage());
            return false;
        }
    }

    public boolean addBus(BusModel bus) {
        String sql = "INSERT INTO buses (bus_number, operator_name, bus_type, total_seats, amenities, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, bus.getBusNumber());
            ps.setString(2, bus.getOperatorName());
            ps.setString(3, bus.getBusType());
            ps.setInt(4, bus.getTotalSeats());
            ps.setString(5, bus.getAmenities());
            ps.setString(6, bus.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error adding bus: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<BusModel> getAllBuses() {
        ArrayList<BusModel> buses = new ArrayList<>();
        String sql = "SELECT * FROM buses ORDER BY created_at DESC";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BusModel bus = new BusModel();
                bus.setId(rs.getInt("id"));
                bus.setBusNumber(rs.getString("bus_number"));
                bus.setOperatorName(rs.getString("operator_name"));
                bus.setBusType(rs.getString("bus_type"));
                bus.setTotalSeats(rs.getInt("total_seats"));
                bus.setAmenities(rs.getString("amenities"));
                bus.setStatus(rs.getString("status"));
                bus.setCreatedAt(rs.getTimestamp("created_at"));
                bus.setUpdatedAt(rs.getTimestamp("updated_at"));
                buses.add(bus);
            }
        } catch (Exception e) {
            System.out.println("Error fetching buses: " + e.getMessage());
        }
        return buses;
    }

    public BusModel getBusById(int id) {
        String sql = "SELECT * FROM buses WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                BusModel bus = new BusModel();
                bus.setId(rs.getInt("id"));
                bus.setBusNumber(rs.getString("bus_number"));
                bus.setOperatorName(rs.getString("operator_name"));
                bus.setBusType(rs.getString("bus_type"));
                bus.setTotalSeats(rs.getInt("total_seats"));
                bus.setAmenities(rs.getString("amenities"));
                bus.setStatus(rs.getString("status"));
                bus.setCreatedAt(rs.getTimestamp("created_at"));
                bus.setUpdatedAt(rs.getTimestamp("updated_at"));
                return bus;
            }
        } catch (Exception e) {
            System.out.println("Error fetching bus by id: " + e.getMessage());
        }
        return null;
    }

    public boolean updateBus(BusModel bus) {
        String sql = "UPDATE buses SET bus_number=?, operator_name=?, bus_type=?, total_seats=?, amenities=?, status=? WHERE id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, bus.getBusNumber());
            ps.setString(2, bus.getOperatorName());
            ps.setString(3, bus.getBusType());
            ps.setInt(4, bus.getTotalSeats());
            ps.setString(5, bus.getAmenities());
            ps.setString(6, bus.getStatus());
            ps.setInt(7, bus.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating bus: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteBus(int id) {
        String sql = "DELETE FROM buses WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting bus: " + e.getMessage());
            return false;
        }
    }

    public int getCount() {
        String sql = "SELECT COUNT(*) FROM buses";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Error getting bus count: " + e.getMessage());
        }
        return 0;
    }
}
