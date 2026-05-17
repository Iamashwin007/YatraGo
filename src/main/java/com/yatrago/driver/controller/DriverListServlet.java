package com.yatrago.driver.controller;

import com.yatrago.driver.dao.DriverDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/driver-list")
public class DriverListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        DriverDAO driverDAO = new DriverDAO();
        req.setAttribute("drivers", driverDAO.getAllDrivers());
        req.getRequestDispatcher("/WEB-INF/admin/drivers/driver-list.jsp").forward(req, resp);
    }
}