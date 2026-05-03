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

@WebServlet("/admin/add-schedule")
public class AddScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        populateDropdowns(req);
        req.getRequestDispatcher("/WEB-INF/admin/add-schedule.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String busIdStr       = req.getParameter("busId").trim();
        String routeIdStr     = req.getParameter("routeId").trim();
        String departurStr    = req.getParameter("departureTime").trim();
        String arrivalStr     = req.getParameter("arrivalTime").trim();
        String dateStr        = req.getParameter("journeyDate").trim();
        String fareStr        = req.getParameter("fare").trim();
        String seatsStr       = req.getParameter("availableSeats").trim();
        String status         = req.getParameter("status").trim();

        if (busIdStr.isEmpty() || routeIdStr.isEmpty() || departurStr.isEmpty()
                || arrivalStr.isEmpty() || dateStr.isEmpty() || fareStr.isEmpty() || seatsStr.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/add-schedule.jsp").forward(req, resp);
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
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/add-schedule.jsp").forward(req, resp);
            return;
        }

        try {
            fare = new BigDecimal(fareStr);
            if (fare.signum() < 0) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Fare must be a valid non-negative number.");
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/add-schedule.jsp").forward(req, resp);
            return;
        }

        try {
            journeyDate   = Date.valueOf(dateStr);
            departureTime = Time.valueOf(departurStr.length() == 5 ? departurStr + ":00" : departurStr);
            arrivalTime   = Time.valueOf(arrivalStr.length() == 5 ? arrivalStr + ":00" : arrivalStr);
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Invalid date or time format.");
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/add-schedule.jsp").forward(req, resp);
            return;
        }

        ScheduleModel s = new ScheduleModel();
        s.setBusId(busId);
        s.setRouteId(routeId);
        s.setDepartureTime(departureTime);
        s.setArrivalTime(arrivalTime);
        s.setJourneyDate(journeyDate);
        s.setFare(fare);
        s.setAvailableSeats(availableSeats);
        s.setStatus(status.isEmpty() ? "scheduled" : status);

        ScheduleDAO scheduleDAO = new ScheduleDAO();
        if (scheduleDAO.addSchedule(s)) {
            resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
        } else {
            req.setAttribute("error", "Failed to add schedule. Please try again.");
            populateDropdowns(req);
            req.getRequestDispatcher("/WEB-INF/admin/add-schedule.jsp").forward(req, resp);
        }
    }

    private void populateDropdowns(HttpServletRequest req) {
        req.setAttribute("buses",  new BusDAO().getAllBuses());
        req.setAttribute("routes", new RouteDAO().getAllRoutes());
    }
}
