package com.yatrago.schedule.controller;

import com.yatrago.bus.dao.BusDAO;
import com.yatrago.route.dao.RouteDAO;
import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.schedule.model.ScheduleModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/admin/update-schedule")
public class UpdateScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
            return;
        }

        ScheduleDAO scheduleDAO = new ScheduleDAO();
        ScheduleModel schedule = scheduleDAO.getScheduleById(id);
        if (schedule == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
            return;
        }

        req.setAttribute("schedule", schedule);
        populateDropdowns(req);
        req.getRequestDispatcher("/WEB-INF/admin/update-schedule.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr       = req.getParameter("id");
        String busIdStr    = req.getParameter("busId").trim();
        String routeIdStr  = req.getParameter("routeId").trim();
        String departurStr = req.getParameter("departureTime").trim();
        String arrivalStr  = req.getParameter("arrivalTime").trim();
        String dateStr     = req.getParameter("journeyDate").trim();
        String fareStr     = req.getParameter("fare").trim();
        String seatsStr    = req.getParameter("availableSeats").trim();
        String status      = req.getParameter("status").trim();

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
            return;
        }

        // Build a partial model immediately so error paths can re-populate the form
        ScheduleModel schedule = new ScheduleModel();
        schedule.setId(id);
        schedule.setStatus(status);

        if (busIdStr.isEmpty() || routeIdStr.isEmpty() || departurStr.isEmpty()
                || arrivalStr.isEmpty() || dateStr.isEmpty() || fareStr.isEmpty() || seatsStr.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.setAttribute("schedule", schedule);
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/update-schedule.jsp").forward(req, resp);
            return;
        }

        int busId, routeId, availableSeats;
        BigDecimal fare;
        Date journeyDate;
        Time departureTime, arrivalTime;

        try {
            busId          = Integer.parseInt(busIdStr);
            routeId        = Integer.parseInt(routeIdStr);
            availableSeats = Integer.parseInt(seatsStr);
            if (availableSeats < 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Bus, route, and seat count must be valid values.");
            req.setAttribute("schedule", schedule);
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/update-schedule.jsp").forward(req, resp);
            return;
        }

        try {
            fare = new BigDecimal(fareStr);
            if (fare.signum() < 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Fare must be a valid non-negative number.");
            req.setAttribute("schedule", schedule);
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/update-schedule.jsp").forward(req, resp);
            return;
        }

        try {
            journeyDate   = Date.valueOf(dateStr);
            departureTime = Time.valueOf(departurStr.length() == 5 ? departurStr + ":00" : departurStr);
            arrivalTime   = Time.valueOf(arrivalStr.length() == 5 ? arrivalStr + ":00" : arrivalStr);
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Invalid date or time format.");
            req.setAttribute("schedule", schedule);
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/update-schedule.jsp").forward(req, resp);
            return;
        }

        schedule.setBusId(busId);
        schedule.setRouteId(routeId);
        schedule.setDepartureTime(departureTime);
        schedule.setArrivalTime(arrivalTime);
        schedule.setJourneyDate(journeyDate);
        schedule.setFare(fare);
        schedule.setAvailableSeats(availableSeats);

        ScheduleDAO scheduleDAO = new ScheduleDAO();
        if (scheduleDAO.updateSchedule(schedule)) {
            resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
        } else {
            req.setAttribute("error", "Failed to update schedule. Please try again.");
            req.setAttribute("schedule", schedule);
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/update-schedule.jsp").forward(req, resp);
        }
    }

    private void populateDropdowns(HttpServletRequest req) {
        req.setAttribute("buses",  new BusDAO().getAllBuses());
        req.setAttribute("routes", new RouteDAO().getAllRoutes());
    }
}
