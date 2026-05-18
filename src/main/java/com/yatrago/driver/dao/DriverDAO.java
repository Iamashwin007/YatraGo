package com.yatrago.driver.dao;

import com.yatrago.driver.model.DriverModel;
import com.yatrago.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DriverDAO {

    public boolean isLicenseExist(String licenseNumber) {
        String sql = "SELECT id FROM drivers WHERE license_number = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, licenseNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            System.out.println("Error checking license: " + e.getMessage());
            return false;
        }
    }

    public boolean addDriver(DriverModel driver) {
        String sql = "INSERT INTO drivers (name, license_number, phone, experience_years, bus_id, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, driver.getName());
            ps.setString(2, driver.getLicenseNumber());
            ps.setString(3, driver.getPhone());
            ps.setInt(4, driver.getExperienceYears());
            if (driver.getBusId() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, driver.getBusId());
            }
            ps.setString(6, driver.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error adding driver: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<DriverModel> getAllDrivers() {
        ArrayList<DriverModel> drivers = new ArrayList<>();
        String sql = "SELECT d.*, b.bus_number " +
                "FROM drivers d " +
                "LEFT JOIN buses b ON d.bus_id = b.id " +
                "ORDER BY d.created_at DESC";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DriverModel driver = mapRow(rs);
                driver.setBusNumber(rs.getString("bus_number"));
                drivers.add(driver);
            }
        } catch (Exception e) {
            System.out.println("Error fetching drivers: " + e.getMessage());
        }
        return drivers;
    }

    public DriverModel getDriverById(int id) {
        String sql = "SELECT * FROM drivers WHERE id = ?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (Exception e) {
            System.out.println("Error fetching driver by id: " + e.getMessage());
        }
        return null;
    }

    public boolean updateDriver(DriverModel driver) {
        String sql = "UPDATE drivers SET name=?, license_number=?, phone=?, " +
                "experience_years=?, bus_id=?, status=? WHERE id=?";
        try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, driver.getName());
            ps.setString(2, driver.getLicenseNumber());
            ps.setString(3, driver.getPhone());
            ps.setInt(4, driver.getExperienceYears());
            if (driver.getBusId() == null) {
                ps.setNull(5, java.sql.Types.INTEGER);
            } else {
                ps.setInt(5, driver.getBusId());
            }
            ps.setString(6, driver.getStatus());
            ps.setInt(7, driver.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating driver: " + e.getMessage());
            return false;
        }
    }

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

    private DriverModel mapRow(ResultSet rs) throws Exception {
        DriverModel d = new DriverModel();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setLicenseNumber(rs.getString("license_number"));
        d.setPhone(rs.getString("phone"));
        d.setExperienceYears(rs.getInt("experience_years"));
        int busId = rs.getInt("bus_id");
        d.setBusId(rs.wasNull() ? null : busId);
        d.setStatus(rs.getString("status"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        d.setUpdatedAt(rs.getTimestamp("updated_at"));
        return d;
    }
}