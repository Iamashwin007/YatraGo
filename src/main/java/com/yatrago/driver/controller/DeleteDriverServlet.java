package com.yatrago.driver.controller;

import com.yatrago.driver.dao.DriverDAO;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/delete-driver")
public class DeleteDriverServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                DriverDAO driverDAO = new DriverDAO();
                driverDAO.deleteDriver(id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid driver id for delete: " + e.getMessage());
            }
        }
        FlashUtil.setMessage(req, "success", "Driver deleted.");
        resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
    }
}