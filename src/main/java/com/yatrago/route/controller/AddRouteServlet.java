package com.yatrago.route.controller;

import com.yatrago.route.dao.RouteDAO;
import com.yatrago.route.model.RouteModel;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/add-route")
public class AddRouteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/admin/add-route.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String origin        = req.getParameter("origin").trim();
        String destination   = req.getParameter("destination").trim();
        String distanceStr   = req.getParameter("distanceKm").trim();
        String durationStr   = req.getParameter("durationHours").trim();
        String fareStr       = req.getParameter("baseFare").trim();
        String status        = req.getParameter("status").trim();

        if (origin.isEmpty() || destination.isEmpty() || distanceStr.isEmpty()
                || durationStr.isEmpty() || fareStr.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/WEB-INF/admin/add-route.jsp").forward(req, resp);
            return;
        }

        BigDecimal distanceKm, durationHours, baseFare;
        try {
            distanceKm    = new BigDecimal(distanceStr);
            durationHours = new BigDecimal(durationStr);
            baseFare      = new BigDecimal(fareStr);
            if (distanceKm.signum() < 0 || durationHours.signum() < 0 || baseFare.signum() < 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Distance, duration, and fare must be valid non-negative numbers.");
            req.getRequestDispatcher("/WEB-INF/admin/add-route.jsp").forward(req, resp);
            return;
        }

        RouteDAO routeDAO = new RouteDAO();
        if (routeDAO.isRouteExist(origin, destination)) {
            req.setAttribute("error", "A route from '" + origin + "' to '" + destination + "' already exists.");
            req.getRequestDispatcher("/WEB-INF/admin/add-route.jsp").forward(req, resp);
            return;
        }

        RouteModel route = new RouteModel();
        route.setOrigin(origin);
        route.setDestination(destination);
        route.setDistanceKm(distanceKm);
        route.setDurationHours(durationHours);
        route.setBaseFare(baseFare);
        route.setStatus(status.isEmpty() ? "active" : status);

        if (routeDAO.addRoute(route)) {
            FlashUtil.setMessage(req, "success", "Route added successfully.");
            resp.sendRedirect(req.getContextPath() + "/admin/route-list");
        } else {
            req.setAttribute("error", "Failed to add route. Please try again.");
            req.getRequestDispatcher("/WEB-INF/admin/add-route.jsp").forward(req, resp);
        }
    }
}
