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

// This servlet handles the Edit Driver page.
// GET  → load the driver's current data and show the pre-filled form
// POST → save the updated data to the database
@WebServlet("/admin/update-driver")
public class UpdateDriverServlet extends HttpServlet {

    // Someone clicked "Edit" on a driver — show the form pre-filled with their data
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get the driver ID from the URL e.g. /admin/update-driver?id=3
        String idStr = req.getParameter("id");

        // If no ID was given, just go back to the list
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            // ID wasn't a valid number — go back to list
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        // Fetch that driver from the database
        DriverDAO driverDAO = new DriverDAO();
        DriverModel driver = driverDAO.getDriverById(id);

        // If no driver found with that ID, go back to list
        if (driver == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        // Put the driver object in the request so the JSP can fill the form
        req.setAttribute("driver", driver);
        req.getRequestDispatcher("/WEB-INF/admin/drivers/update-driver.jsp").forward(req, resp);
    }

    // Someone submitted the edit form — save the changes
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Read all the form fields
        String idStr         = req.getParameter("id");
        String name          = req.getParameter("name").trim();
        String licenseNumber = req.getParameter("licenseNumber").trim();
        String phone         = req.getParameter("phone").trim();
        String expStr        = req.getParameter("experienceYears").trim();
        String busIdStr      = req.getParameter("busId").trim();
        String status        = req.getParameter("status").trim();

        // Parse the ID — if invalid, go back to list
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        // Build a partial model now — useful if we need to re-show the form on error
        // (the form will stay filled with what the user typed)
        DriverModel driver = new DriverModel();
        driver.setId(id);
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);
        driver.setPhone(phone);
        driver.setStatus(status);

        // Validate required fields
        if (name.isEmpty() || licenseNumber.isEmpty() || phone.isEmpty() || expStr.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled.");
            req.setAttribute("driver", driver);
            req.getRequestDispatcher("/WEB-INF/admin/drivers/update-driver.jsp").forward(req, resp);
            return;
        }

        // Validate experience years
        int experienceYears;
        try {
            experienceYears = Integer.parseInt(expStr);
            if (experienceYears < 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Experience years must be a valid number (0 or more).");
            req.setAttribute("driver", driver);
            req.getRequestDispatcher("/WEB-INF/admin/drivers/update-driver.jsp").forward(req, resp);
            return;
        }

        // Complete filling the model
        driver.setExperienceYears(experienceYears);
        driver.setBusId(busIdStr.isEmpty() ? null : Integer.parseInt(busIdStr));

        // Save to DB and redirect or show error
        DriverDAO driverDAO = new DriverDAO();
        if (driverDAO.updateDriver(driver)) {
            FlashUtil.setMessage(req, "success", "Driver updated successfully.");
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
        } else {
            req.setAttribute("error", "Something went wrong. Please try again.");
            req.setAttribute("driver", driver);
            req.getRequestDispatcher("/WEB-INF/admin/drivers/update-driver.jsp").forward(req, resp);
        }
    }
}