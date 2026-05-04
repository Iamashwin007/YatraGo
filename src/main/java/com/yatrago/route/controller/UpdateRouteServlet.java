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

@WebServlet("/admin/update-route")
public class UpdateRouteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/route-list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/route-list");
            return;
        }

        RouteDAO routeDAO = new RouteDAO();
        RouteModel route = routeDAO.getRouteById(id);
        if (route == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/route-list");
            return;
        }

        req.setAttribute("route", route);
        req.getRequestDispatcher("/WEB-INF/admin/update-route.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr       = req.getParameter("id");
        String origin      = req.getParameter("origin").trim();
        String destination = req.getParameter("destination").trim();
        String distanceStr = req.getParameter("distanceKm").trim();
        String durationStr = req.getParameter("durationHours").trim();
        String fareStr     = req.getParameter("baseFare").trim();
        String status      = req.getParameter("status").trim();

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/route-list");
            return;
        }

        // Build model from submitted values so the form re-fills correctly on error
        RouteModel route = new RouteModel();
        route.setId(id);
        route.setOrigin(origin);
        route.setDestination(destination);
        route.setStatus(status);

        if (origin.isEmpty() || destination.isEmpty() || distanceStr.isEmpty()
                || durationStr.isEmpty() || fareStr.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.setAttribute("route", route);
            req.getRequestDispatcher("/WEB-INF/admin/update-route.jsp").forward(req, resp);
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
            req.setAttribute("route", route);
            req.getRequestDispatcher("/WEB-INF/admin/update-route.jsp").forward(req, resp);
            return;
        }

        route.setDistanceKm(distanceKm);
        route.setDurationHours(durationHours);
        route.setBaseFare(baseFare);

        RouteDAO routeDAO = new RouteDAO();
        if (routeDAO.updateRoute(route)) {
            FlashUtil.setMessage(req, "success", "Route updated.");
            resp.sendRedirect(req.getContextPath() + "/admin/route-list");
        } else {
            req.setAttribute("error", "Failed to update route. Please try again.");
            req.setAttribute("route", route);
            req.getRequestDispatcher("/WEB-INF/admin/update-route.jsp").forward(req, resp);
        }
    }
}
