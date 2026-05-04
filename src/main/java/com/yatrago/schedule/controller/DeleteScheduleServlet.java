package com.yatrago.schedule.controller;

import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/delete-schedule")
public class DeleteScheduleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                ScheduleDAO scheduleDAO = new ScheduleDAO();
                scheduleDAO.deleteSchedule(id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid schedule id for delete: " + e.getMessage());
            }
        }
        FlashUtil.setMessage(req, "success", "Schedule deleted.");
        resp.sendRedirect(req.getContextPath() + "/admin/schedule-list");
    }
}
