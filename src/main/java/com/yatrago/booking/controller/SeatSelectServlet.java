package com.yatrago.booking.controller;

import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/seat-select")
public class SeatSelectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
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
        req.getRequestDispatcher("/WEB-INF/booking/seat-select.jsp").forward(req, resp);
    }
}
