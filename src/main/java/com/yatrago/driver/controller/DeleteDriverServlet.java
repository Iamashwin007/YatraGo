package com.yatrago.driver.controller;

import com.yatrago.driver.dao.DriverDAO;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// This servlet only handles deletion — no page to show.
// It only accepts POST (never GET) so someone can't delete a driver
// just by visiting a URL in their browser.
@WebServlet("/admin/delete-driver")
public class DeleteDriverServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");

        // Only try to delete if we actually received an ID
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                DriverDAO driverDAO = new DriverDAO();
                driverDAO.deleteDriver(id);
            } catch (NumberFormatException e) {
                // Bad ID — just log it and continue to redirect
                System.out.println("Invalid driver id for delete: " + e.getMessage());
            }
        }

        // Always go back to the list after attempting delete
        FlashUtil.setMessage(req, "success", "Driver deleted.");
        resp.sendRedirect(req.getContextPath() + "/admin/driver-list");
    }
}