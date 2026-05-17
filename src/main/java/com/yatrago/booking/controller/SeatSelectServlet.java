package com.yatrago.booking.controller;

import com.yatrago.booking.dao.BookingDAO;
import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.user.model.UserModel;
import com.yatrago.utils.FlashUtil;
import com.yatrago.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/seat-select")
public class SeatSelectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UserModel user = SessionUtil.getUser(req);
        if (user == null) {
            FlashUtil.setMessage(req, "error", "Please log in to select seats.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idParam = req.getParameter("scheduleId");

        int scheduleId;
        try {
            scheduleId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            FlashUtil.setMessage(req, "error", "Invalid or missing schedule.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        com.yatrago.schedule.model.ScheduleModel schedule = new ScheduleDAO().getScheduleById(scheduleId);
        if (schedule == null) {
            FlashUtil.setMessage(req, "error", "Schedule not found.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        req.setAttribute("schedule", schedule);
        req.setAttribute("takenSeatsJson", buildTakenSeatsJson(scheduleId));
        req.getRequestDispatcher("/WEB-INF/booking/seat-select.jsp").forward(req, resp);
    }

    private String buildTakenSeatsJson(int scheduleId) {
        ArrayList<String> takenSeats = new BookingDAO().getTakenSeatRowsBySchedule(scheduleId);
        StringBuilder json = new StringBuilder();
        json.append('[');
        boolean first = true;
        for (String seat : takenSeats) {
            if (!first) json.append(',');
            json.append('"').append(seat).append('"');
            first = false;
        }
        json.append(']');
        return json.toString();
    }
}
