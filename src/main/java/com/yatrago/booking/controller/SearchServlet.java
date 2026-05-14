package com.yatrago.booking.controller;

import com.yatrago.route.dao.RouteDAO;
import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("routes", new RouteDAO().getAllRoutes());
        req.getRequestDispatcher("/WEB-INF/pages/search.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String origin      = req.getParameter("origin");
        String destination = req.getParameter("destination");
        String journeyDate = req.getParameter("journeyDate");

        if (origin == null || origin.trim().isEmpty()
                || destination == null || destination.trim().isEmpty()
                || journeyDate == null || journeyDate.trim().isEmpty()) {
            FlashUtil.setMessage(req, "error", "Please fill all fields.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        req.setAttribute("schedules",   new ScheduleDAO().searchSchedules(origin, destination, journeyDate));
        req.setAttribute("origin",      origin);
        req.setAttribute("destination", destination);
        req.setAttribute("journeyDate", journeyDate);
        req.getRequestDispatcher("/WEB-INF/booking/search-results.jsp").forward(req, resp);
    }
}
