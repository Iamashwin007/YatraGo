package com.yatrago.driver.controller;

import com.yatrago.driver.dao.DriverDAO;
import com.yatrago.driver.model.DriverModel;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// This servlet handles the Add Driver page.
// GET  → just show the empty form
// POST → read the form data, validate it, save to DB
@WebServlet("/admin/add-driver")
public class AddDriverServlet extends HttpServlet {

    // Someone opened /admin/add-driver in their browser — show the form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
    }

    // Someone submitted the Add Driver form — process it
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Step 1: Read everything the user typed in the form
        String name          = req.getParameter("name").trim();
        String licenseNumber = req.getParameter("licenseNumber").trim();
        String phone         = req.getParameter("phone").trim();
        String expStr        = req.getParameter("experienceYears").trim();
        String busIdStr      = req.getParameter("busId").trim();   // optional — can be blank
        String status        = req.getParameter("status").trim();

        // Step 2: Make sure required fields are not empty
        if (name.isEmpty() || licenseNumber.isEmpty() || phone.isEmpty() || expStr.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled.");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
            return; // stop here, show the form again with the error
        }

        // Step 3: Make sure experience years is actually a valid number
        int experienceYears;
        try {
            experienceYears = Integer.parseInt(expStr);
            if (experienceYears < 0) throw new NumberFormatException(); // can't have negative experience
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Experience years must be a valid number (0 or more).");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
            return;
        }

        // Step 4: Check if this license number is already taken
        DriverDAO driverDAO = new DriverDAO();
        if (driverDAO.isLicenseExist(licenseNumber)) {
            req.setAttribute("error", "License number '" + licenseNumber + "' is already registered.");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
            return;
        }

        // Step 5: Build the DriverModel object with all the data
        DriverModel driver = new DriverModel();
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);
        driver.setPhone(phone);
        driver.setExperienceYears(experienceYears);
        driver.setBusId(busIdStr.isEmpty() ? null : Integer.parseInt(busIdStr)); // null if left blank
        driver.setStatus(status.isEmpty() ? "active" : status); // default to active

        // Step 6: Save to database and redirect or show error
        if (driverDAO.addDriver(driver)) {
            FlashUtil.setMessage(req, "success", "Driver added successfully.");
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
        } else {
            req.setAttribute("error", "Something went wrong. Please try again.");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
        }
    }
}