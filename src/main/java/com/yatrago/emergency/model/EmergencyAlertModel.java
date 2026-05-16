package com.yatrago.emergency.model;

import java.sql.Timestamp;

public class EmergencyAlertModel {

    // ── emergency_alerts table columns ─────────────────────────────────────
    private int       id;
    private String    message;
    private int       raisedByUserId;
    private String    status;           // 'active' | 'resolved'
    private Timestamp createdAt;

    // ── Constructor ────────────────────────────────────────────────────────
    public EmergencyAlertModel() {}

    // ── Getters and Setters ───────────────────────────────────────────────
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public int getRaisedByUserId() { return raisedByUserId; }
    public void setRaisedByUserId(int raisedByUserId) { this.raisedByUserId = raisedByUserId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}