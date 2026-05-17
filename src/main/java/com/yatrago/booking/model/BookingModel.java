package com.yatrago.booking.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;

public class BookingModel {

    // ── bookings table columns ─────────────────────────────────────────────
    private int        id;
    private int        userId;
    private int        scheduleId;
    private String     bookingReference;
    private BigDecimal totalFare;
    private int        passengerCount;
    private String     bookingStatus;      // "pending" | "confirmed" | "cancelled"
    private Timestamp  createdAt;
    private Timestamp  updatedAt;

    // ── JOIN fields populated by DAO read methods ──────────────────────────
    // From schedules table
    private Timestamp  departureTime;
    private Timestamp  arrivalTime;
    private int        availableSeats;
    private BigDecimal scheduleFare;

    // From routes table
    private String     origin;
    private String     destination;

    // From buses table
    private String     busNumber;
    private String     operatorName;
    private String     busType;

    // ── Seats list — populated only by getBookingById() ───────────────────
    private ArrayList<BookingSeatModel> seats;

    // ── Constructors ───────────────────────────────────────────────────────
    public BookingModel() {}

    // ── Getters and Setters: table columns ────────────────────────────────
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getScheduleId() { return scheduleId; }
    public void setScheduleId(int scheduleId) { this.scheduleId = scheduleId; }

    public String getBookingReference() { return bookingReference; }
    public void setBookingReference(String bookingReference) { this.bookingReference = bookingReference; }

    public BigDecimal getTotalFare() { return totalFare; }
    public void setTotalFare(BigDecimal totalFare) { this.totalFare = totalFare; }

    public int getPassengerCount() { return passengerCount; }
    public void setPassengerCount(int passengerCount) { this.passengerCount = passengerCount; }

    public String getBookingStatus() { return bookingStatus; }
    public void setBookingStatus(String bookingStatus) { this.bookingStatus = bookingStatus; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    // ── Getters and Setters: JOIN fields ──────────────────────────────────
    public Timestamp getDepartureTime() { return departureTime; }
    public void setDepartureTime(Timestamp departureTime) { this.departureTime = departureTime; }

    public Timestamp getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(Timestamp arrivalTime) { this.arrivalTime = arrivalTime; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public BigDecimal getScheduleFare() { return scheduleFare; }
    public void setScheduleFare(BigDecimal scheduleFare) { this.scheduleFare = scheduleFare; }

    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }

    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String operatorName) { this.operatorName = operatorName; }

    public String getBusType() { return busType; }
    public void setBusType(String busType) { this.busType = busType; }

    // ── Getters and Setters: seats list ───────────────────────────────────
    public ArrayList<BookingSeatModel> getSeats() { return seats; }
    public void setSeats(ArrayList<BookingSeatModel> seats) { this.seats = seats; }
}