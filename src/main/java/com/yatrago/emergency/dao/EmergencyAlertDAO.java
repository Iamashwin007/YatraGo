package com.yatrago.emergency.dao;

import com.yatrago.emergency.model.EmergencyAlertModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EmergencyAlertDAO {

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD 1 — insertAlert
    //  Inserts a new emergency alert into the database.
    //  Returns false on any error — never true unless DB committed.
    // ══════════════════════════════════════════════════════════════════════
    public boolean insertAlert(EmergencyAlertModel alert) {

        String sql = "INSERT INTO emergency_alerts (message, raised_by_user_id, status) " +
                "VALUES (?, ?, 'active')";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;

            ps.setString(1, alert.getMessage());
            ps.setInt(2,    alert.getRaisedByUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error inserting alert: " + e.getMessage());
            return false;
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD 2 — getAllAlerts
    //  Returns all alerts ordered by newest first.
    //  Returns empty list on error — never null.
    // ══════════════════════════════════════════════════════════════════════
    public ArrayList<EmergencyAlertModel> getAllAlerts() {

        ArrayList<EmergencyAlertModel> alerts = new ArrayList<>();

        String sql = "SELECT id, message, raised_by_user_id, status, created_at " +
                "FROM emergency_alerts " +
                "ORDER BY created_at DESC";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return alerts;

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                alerts.add(mapRow(rs));
            }

        } catch (Exception e) {
            System.out.println("Error fetching all alerts: " + e.getMessage());
        }

        return alerts;
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD 3 — getLatestActiveAlert
    //  Returns the single most recent alert with status = 'active'.
    //  Returns null if no active alert exists.
    //  Used by the user-side banner to check if an alert should be shown.
    // ══════════════════════════════════════════════════════════════════════
    public EmergencyAlertModel getLatestActiveAlert() {

        String sql = "SELECT id, message, raised_by_user_id, status, created_at " +
                "FROM emergency_alerts " +
                "WHERE status = 'active' " +
                "ORDER BY created_at DESC " +
                "LIMIT 1";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return null;

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (Exception e) {
            System.out.println("Error fetching latest active alert: " + e.getMessage());
        }

        return null;
    }

    // ══════════════════════════════════════════════════════════════════════
    //  METHOD 4 — resolveAlert
    //  Sets an alert's status to 'resolved'.
    //  Returns false on error.
    // ══════════════════════════════════════════════════════════════════════
    public boolean resolveAlert(int alertId) {

        String sql = "UPDATE emergency_alerts SET status = 'resolved' WHERE id = ?";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return false;

            ps.setInt(1, alertId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error resolving alert: " + e.getMessage());
            return false;
        }
    }

    // ══════════════════════════════════════════════════════════════════════
    //  PRIVATE HELPER — mapRow
    //  Maps one ResultSet row to an EmergencyAlertModel.
    // ══════════════════════════════════════════════════════════════════════
    private EmergencyAlertModel mapRow(ResultSet rs) throws Exception {
        EmergencyAlertModel a = new EmergencyAlertModel();
        a.setId(rs.getInt("id"));
        a.setMessage(rs.getString("message"));
        a.setRaisedByUserId(rs.getInt("raised_by_user_id"));
        a.setStatus(rs.getString("status"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        return a;
    }
}