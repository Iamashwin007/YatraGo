package com.yatrago.driver.controller;

import com.yatrago.driver.dao.DriverDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// This servlet handles the Driver List page.
// It only needs GET — no form submission here, just displaying data.
@WebServlet("/admin/driver-list")
public class DriverListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Fetch all drivers from the database (with bus numbers via JOIN)
        DriverDAO driverDAO = new DriverDAO();

        // Put the list into the request so the JSP can loop through it
        req.setAttribute("drivers", driverDAO.getAllDrivers());

        // Send the user to the list page
        req.getRequestDispatcher("/WEB-INF/admin/drivers/driver-list.jsp").forward(req, resp);
    }
}