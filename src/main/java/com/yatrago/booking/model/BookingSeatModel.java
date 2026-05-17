package com.yatrago.booking.model;

import java.sql.Timestamp;

public class BookingSeatModel {

    // ── booking_seats table columns ────────────────────────────────────────
    private int       id;
    private int       bookingId;
    private String    seatNumber;
    private String    passengerName;  // nullable in DB
    private Integer   passengerAge;   // Integer (not int) — nullable in DB
    private Timestamp createdAt;

    // ── Constructor ────────────────────────────────────────────────────────
    public BookingSeatModel() {}

    // ── Getters and Setters ───────────────────────────────────────────────
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }

    public Integer getPassengerAge() { return passengerAge; }
    public void setPassengerAge(Integer passengerAge) { this.passengerAge = passengerAge; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
