package com.yatrago.emergency.controller;

import com.yatrago.emergency.dao.EmergencyAlertDAO;
import com.yatrago.emergency.model.EmergencyAlertModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/alert/latest")
public class GetLatestAlertServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        EmergencyAlertDAO dao = new EmergencyAlertDAO();
        EmergencyAlertModel alert = dao.getLatestActiveAlert();

        // Put alert in request — JSP checks if null
        // If null, no active alert exists — banner stays hidden
        req.setAttribute("activeAlert", alert);
        req.getRequestDispatcher("/WEB-INF/pages/alert-banner.jsp").forward(req, resp);
        return;
    }
}