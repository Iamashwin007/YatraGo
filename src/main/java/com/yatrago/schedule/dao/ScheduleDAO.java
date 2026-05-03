package com.yatrago.schedule.dao;

import com.yatrago.schedule.model.ScheduleModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ScheduleDAO {

    public boolean addSchedule(ScheduleModel s) {
        String sql = "INSERT INTO schedules (bus_id, route_id, departure_time, arrival_time, journey_date, fare, available_seats, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, s.getBusId());
            ps.setInt(2, s.getRouteId());
            ps.setTime(3, s.getDepartureTime());
            ps.setTime(4, s.getArrivalTime());
            ps.setDate(5, s.getJourneyDate());
            ps.setBigDecimal(6, s.getFare());
            ps.setInt(7, s.getAvailableSeats());
            ps.setString(8, s.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error adding schedule: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<ScheduleModel> getAllSchedules() {
        ArrayList<ScheduleModel> list = new ArrayList<>();
        String sql = "SELECT s.*, b.bus_number, b.operator_name, r.origin, r.destination " +
                     "FROM schedules s " +
                     "JOIN buses b ON s.bus_id = b.id " +
                     "JOIN routes r ON s.route_id = r.id " +
                     "ORDER BY s.journey_date, s.departure_time";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            System.out.println("Error fetching schedules: " + e.getMessage());
        }
        return list;
    }

    public ScheduleModel getScheduleById(int id) {
        String sql = "SELECT s.*, b.bus_number, b.operator_name, r.origin, r.destination " +
                     "FROM schedules s " +
                     "JOIN buses b ON s.bus_id = b.id " +
                     "JOIN routes r ON s.route_id = r.id " +
                     "WHERE s.id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) {
            System.out.println("Error fetching schedule by id: " + e.getMessage());
        }
        return null;
    }

    public boolean updateSchedule(ScheduleModel s) {
        String sql = "UPDATE schedules SET bus_id=?, route_id=?, departure_time=?, arrival_time=?, journey_date=?, fare=?, available_seats=?, status=? WHERE id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, s.getBusId());
            ps.setInt(2, s.getRouteId());
            ps.setTime(3, s.getDepartureTime());
            ps.setTime(4, s.getArrivalTime());
            ps.setDate(5, s.getJourneyDate());
            ps.setBigDecimal(6, s.getFare());
            ps.setInt(7, s.getAvailableSeats());
            ps.setString(8, s.getStatus());
            ps.setInt(9, s.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating schedule: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteSchedule(int id) {
        String sql = "DELETE FROM schedules WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting schedule: " + e.getMessage());
            return false;
        }
    }

    public int getCount() {
        String sql = "SELECT COUNT(*) FROM schedules";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Error getting schedule count: " + e.getMessage());
        }
        return 0;
    }

    private ScheduleModel mapRow(ResultSet rs) throws Exception {
        ScheduleModel s = new ScheduleModel();
        s.setId(rs.getInt("id"));
        s.setBusId(rs.getInt("bus_id"));
        s.setRouteId(rs.getInt("route_id"));
        s.setDepartureTime(rs.getTime("departure_time"));
        s.setArrivalTime(rs.getTime("arrival_time"));
        s.setJourneyDate(rs.getDate("journey_date"));
        s.setFare(rs.getBigDecimal("fare"));
        s.setAvailableSeats(rs.getInt("available_seats"));
        s.setStatus(rs.getString("status"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        s.setUpdatedAt(rs.getTimestamp("updated_at"));
        s.setBusNumber(rs.getString("bus_number"));
        s.setOperatorName(rs.getString("operator_name"));
        s.setRouteOrigin(rs.getString("origin"));
        s.setRouteDestination(rs.getString("destination"));
        return s;
    }
}
