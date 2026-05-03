package com.yatrago.schedule.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class ScheduleModel {
    // DB columns
    private int id;
    private int busId;
    private int routeId;
    private Time departureTime;
    private Time arrivalTime;
    private Date journeyDate;
    private BigDecimal fare;
    private int availableSeats;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Display-only fields populated by JOIN queries
    private String busNumber;
    private String operatorName;
    private String routeOrigin;
    private String routeDestination;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBusId() { return busId; }
    public void setBusId(int busId) { this.busId = busId; }

    public int getRouteId() { return routeId; }
    public void setRouteId(int routeId) { this.routeId = routeId; }

    public Time getDepartureTime() { return departureTime; }
    public void setDepartureTime(Time departureTime) { this.departureTime = departureTime; }

    public Time getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(Time arrivalTime) { this.arrivalTime = arrivalTime; }

    public Date getJourneyDate() { return journeyDate; }
    public void setJourneyDate(Date journeyDate) { this.journeyDate = journeyDate; }

    public BigDecimal getFare() { return fare; }
    public void setFare(BigDecimal fare) { this.fare = fare; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }

    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String operatorName) { this.operatorName = operatorName; }

    public String getRouteOrigin() { return routeOrigin; }
    public void setRouteOrigin(String routeOrigin) { this.routeOrigin = routeOrigin; }

    public String getRouteDestination() { return routeDestination; }
    public void setRouteDestination(String routeDestination) { this.routeDestination = routeDestination; }
}
