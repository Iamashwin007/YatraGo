package com.yatrago.schedule.controller;

import com.yatrago.schedule.dao.ScheduleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/schedule-list")
public class ScheduleListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ScheduleDAO scheduleDAO = new ScheduleDAO();
        req.setAttribute("schedules", scheduleDAO.getAllSchedules());
        req.getRequestDispatcher("/WEB-INF/admin/schedule-list.jsp").forward(req, resp);
    }
}
