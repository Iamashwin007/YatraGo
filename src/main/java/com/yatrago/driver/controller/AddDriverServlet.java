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

@WebServlet("/admin/add-driver")
public class AddDriverServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name          = req.getParameter("name").trim();
        String licenseNumber = req.getParameter("licenseNumber").trim();
        String phone         = req.getParameter("phone").trim();
        String expStr        = req.getParameter("experienceYears").trim();
        String busIdStr      = req.getParameter("busId").trim();
        String status        = req.getParameter("status").trim();

        if (name.isEmpty() || licenseNumber.isEmpty() || phone.isEmpty() || expStr.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled.");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
            return;
        }

        int experienceYears;
        try {
            experienceYears = Integer.parseInt(expStr);
            if (experienceYears < 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Experience years must be a valid number (0 or more).");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
            return;
        }

        DriverDAO driverDAO = new DriverDAO();
        if (driverDAO.isLicenseExist(licenseNumber)) {
            req.setAttribute("error", "License number '" + licenseNumber + "' is already registered.");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
            return;
        }

        DriverModel driver = new DriverModel();
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);
        driver.setPhone(phone);
        driver.setExperienceYears(experienceYears);
        driver.setBusId(busIdStr.isEmpty() ? null : Integer.parseInt(busIdStr));
        driver.setStatus(status.isEmpty() ? "active" : status);

        if (driverDAO.addDriver(driver)) {
            FlashUtil.setMessage(req, "success", "Driver added successfully.");
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
        } else {
            req.setAttribute("error", "Something went wrong. Please try again.");
            req.getRequestDispatcher("/WEB-INF/admin/drivers/add-driver.jsp").forward(req, resp);
        }
    }
}