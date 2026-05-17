package com.yatrago.driver.model;

import java.sql.Timestamp;

// This class represents one row in the "drivers" table.
// Think of it like a form — each field here matches a column in the database.
public class DriverModel {

    // These are all the columns in the drivers table
    private int id;
    private String name;
    private String licenseNumber;
    private String phone;
    private int experienceYears;

    // bus_id can be NULL in the database (driver not assigned to any bus yet)
    // We use Integer (capital I) instead of int so it can hold null
    private Integer busId;

    // This one is NOT a database column — we fill it from a JOIN query
    // so the JSP can show the bus number instead of just a number ID
    private String busNumber;

    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // --- Getters and Setters ---
    // These let other classes read and write the fields above

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }

    public Integer getBusId() { return busId; }
    public void setBusId(Integer busId) { this.busId = busId; }

    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}