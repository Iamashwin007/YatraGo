package com.yatrago.driver.dao;

import com.yatrago.driver.model.DriverModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

// DAO = Data Access Object
// This class is the only one that talks to the database.
// The servlets call methods here — they never write SQL themselves.
public class DriverDAO {

    // -----------------------------------------------------------
    // CHECK: does a driver with this license number already exist?
    // Used in AddDriverServlet to prevent duplicates.
    // -----------------------------------------------------------
    public boolean isLicenseExist(String licenseNumber) {
        String sql = "SELECT id FROM drivers WHERE license_number = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, licenseNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // if a row came back, the license already exists

        } catch (Exception e) {
            System.out.println("Error checking license: " + e.getMessage());
            return false;
        }
    }

    // -----------------------------------------------------------
    // CREATE: insert a new driver into the database
    // Returns true if it worked, false if something went wrong.
    // -----------------------------------------------------------
    public boolean addDriver(DriverModel driver) {
        String sql = "INSERT INTO drivers (name, license_number, phone, experience_years, bus_id, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, driver.getName());
            ps.setString(2, driver.getLicenseNumber());
            ps.setString(3, driver.getPhone());
            ps.setInt(4, driver.getExperienceYears());

            // bus_id is nullable — we must handle null specially
            // If we just called ps.setInt with null it would crash
            if (driver.getBusId() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, driver.getBusId());
            }

            ps.setString(6, driver.getStatus());
            return ps.executeUpdate() > 0; // executeUpdate returns number of rows affected

        } catch (Exception e) {
            System.out.println("Error adding driver: " + e.getMessage());
            return false;
        }
    }

    // -----------------------------------------------------------
    // READ ALL: get every driver, with their assigned bus number
    // We use a LEFT JOIN so drivers with no bus still appear.
    // -----------------------------------------------------------
    public ArrayList<DriverModel> getAllDrivers() {
        ArrayList<DriverModel> drivers = new ArrayList<>();

        // LEFT JOIN means: give me all drivers, and if they have a bus, show its number too
        // If bus_id is NULL, b.bus_number will just come back as null — that's fine
        String sql = "SELECT d.*, b.bus_number " +
                "FROM drivers d " +
                "LEFT JOIN buses b ON d.bus_id = b.id " +
                "ORDER BY d.created_at DESC";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // mapRow() converts one database row into one DriverModel object
                DriverModel driver = mapRow(rs);
                driver.setBusNumber(rs.getString("bus_number")); // will be null if no bus
                drivers.add(driver);
            }

        } catch (Exception e) {
            System.out.println("Error fetching drivers: " + e.getMessage());
        }
        return drivers;
    }

    // -----------------------------------------------------------
    // READ ONE: get a single driver by their ID
    // Used by UpdateDriverServlet to pre-fill the edit form.
    // -----------------------------------------------------------
    public DriverModel getDriverById(int id) {
        String sql = "SELECT * FROM drivers WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs); // found — return the driver
            }

        } catch (Exception e) {
            System.out.println("Error fetching driver by id: " + e.getMessage());
        }
        return null; // not found
    }

    // -----------------------------------------------------------
    // UPDATE: save changes to an existing driver
    // -----------------------------------------------------------
    public boolean updateDriver(DriverModel driver) {
        String sql = "UPDATE drivers SET name=?, license_number=?, phone=?, " +
                "experience_years=?, bus_id=?, status=? WHERE id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, driver.getName());
            ps.setString(2, driver.getLicenseNumber());
            ps.setString(3, driver.getPhone());
            ps.setInt(4, driver.getExperienceYears());

            // Same nullable bus_id handling as in addDriver
            if (driver.getBusId() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, driver.getBusId());
            }

            ps.setString(6, driver.getStatus());
            ps.setInt(7, driver.getId()); // WHERE id = ?
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error updating driver: " + e.getMessage());
            return false;
        }
    }

    // -----------------------------------------------------------
    // DELETE: remove a driver by ID
    // -----------------------------------------------------------
    public boolean deleteDriver(int id) {
        String sql = "DELETE FROM drivers WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error deleting driver: " + e.getMessage());
            return false;
        }
    }

    // -----------------------------------------------------------
    // PRIVATE HELPER: turns one ResultSet row into a DriverModel
    // We use this in both getAllDrivers() and getDriverById()
    // to avoid writing the same mapping code twice.
    // -----------------------------------------------------------
    private DriverModel mapRow(ResultSet rs) throws Exception {
        DriverModel d = new DriverModel();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setLicenseNumber(rs.getString("license_number"));
        d.setPhone(rs.getString("phone"));
        d.setExperienceYears(rs.getInt("experience_years"));

        // Tricky part: rs.getInt("bus_id") returns 0 when the DB value is NULL
        // rs.wasNull() tells us if the last column read was actually NULL
        int busId = rs.getInt("bus_id");
        d.setBusId(rs.wasNull() ? null : busId);

        d.setStatus(rs.getString("status"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        d.setUpdatedAt(rs.getTimestamp("updated_at"));
        return d;
    }
}