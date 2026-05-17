package com.yatrago.emergency.controller;

import com.yatrago.emergency.dao.EmergencyAlertDAO;
import com.yatrago.emergency.model.EmergencyAlertModel;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/broadcast-alert")
public class BroadcastAlertServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        EmergencyAlertDAO dao = new EmergencyAlertDAO();
        req.setAttribute("alerts", dao.getAllAlerts());
        req.getRequestDispatcher("/WEB-INF/admin/emergency-alerts.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String message = req.getParameter("message");

        if (message == null || message.trim().isEmpty()) {
            FlashUtil.setMessage(req, "error", "Alert message cannot be empty.");
            resp.sendRedirect(req.getContextPath() + "/admin/broadcast-alert");
            return;
        }

        // Get the logged-in admin's id from session
        // Adjust "userId" to match whatever key your session uses
        int adminId = (int) req.getSession().getAttribute("userId");

        EmergencyAlertModel alert = new EmergencyAlertModel();
        alert.setMessage(message.trim());
        alert.setRaisedByUserId(adminId);
        alert.setStatus("active");

        EmergencyAlertDAO dao = new EmergencyAlertDAO();

        if (dao.insertAlert(alert)) {
            FlashUtil.setMessage(req, "success", "Alert broadcasted successfully.");
        } else {
            FlashUtil.setMessage(req, "error", "Failed to broadcast alert. Please try again.");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/broadcast-alert");
        return;
    }
}