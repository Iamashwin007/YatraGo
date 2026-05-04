package com.yatrago.bus.controller;

import com.yatrago.bus.dao.BusDAO;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/delete-bus")
public class DeleteBusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                BusDAO busDAO = new BusDAO();
                busDAO.deleteBus(id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid bus id for delete: " + e.getMessage());
            }
        }
        FlashUtil.setMessage(req, "success", "Bus deleted.");
        resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
    }
}
