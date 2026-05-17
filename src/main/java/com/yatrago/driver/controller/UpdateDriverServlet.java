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

@WebServlet("/admin/update-driver")
public class UpdateDriverServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        DriverDAO driverDAO = new DriverDAO();
        DriverModel driver = driverDAO.getDriverById(id);
        if (driver == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        req.setAttribute("driver", driver);
        req.getRequestDispatcher("/WEB-INF/admin/drivers/update-driver.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr         = req.getParameter("id");
        String name          = req.getParameter("name").trim();
        String licenseNumber = req.getParameter("licenseNumber").trim();
        String phone         = req.getParameter("phone").trim();
        String expStr        = req.getParameter("experienceYears").trim();
        String busIdStr      = req.getParameter("busId").trim();
        String status        = req.getParameter("status").trim();

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
            return;
        }

        DriverModel driver = new DriverModel();
        driver.setId(id);
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);
        driver.setPhone(phone);
        driver.setStatus(status);

        if (name.isEmpty() || licenseNumber.isEmpty() || phone.isEmpty() || expStr.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled.");
            req.setAttribute("driver", driver);
            req.getRequestDispatcher("/WEB-INF/admin/drivers/update-driver.jsp").forward(req, resp);
            return;
        }

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

        driver.setExperienceYears(experienceYears);
        driver.setBusId(busIdStr.isEmpty() ? null : Integer.parseInt(busIdStr));

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