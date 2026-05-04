package com.yatrago.bus.controller;

import com.yatrago.bus.dao.BusDAO;
import com.yatrago.bus.model.BusModel;
import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/update-bus")
public class UpdateBusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
            return;
        }

        BusDAO busDAO = new BusDAO();
        BusModel bus = busDAO.getBusById(id);
        if (bus == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
            return;
        }

        req.setAttribute("bus", bus);
        req.getRequestDispatcher("/WEB-INF/admin/update-bus.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr        = req.getParameter("id");
        String busNumber    = req.getParameter("busNumber").trim();
        String operatorName = req.getParameter("operatorName").trim();
        String busType      = req.getParameter("busType").trim();
        String seatsStr     = req.getParameter("totalSeats").trim();
        String amenities    = req.getParameter("amenities").trim();
        String status       = req.getParameter("status").trim();

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
            return;
        }

        // Build model from submitted values so the form re-fills correctly on error
        BusModel bus = new BusModel();
        bus.setId(id);
        bus.setBusNumber(busNumber);
        bus.setOperatorName(operatorName);
        bus.setBusType(busType);
        bus.setAmenities(amenities);
        bus.setStatus(status);

        if (busNumber.isEmpty() || operatorName.isEmpty() || busType.isEmpty() || seatsStr.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled.");
            req.setAttribute("bus", bus);
            req.getRequestDispatcher("/WEB-INF/admin/update-bus.jsp").forward(req, resp);
            return;
        }

        int totalSeats;
        try {
            totalSeats = Integer.parseInt(seatsStr);
            if (totalSeats < 1) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Total seats must be a positive number.");
            req.setAttribute("bus", bus);
            req.getRequestDispatcher("/WEB-INF/admin/update-bus.jsp").forward(req, resp);
            return;
        }
        bus.setTotalSeats(totalSeats);
        bus.setAmenities(amenities.isEmpty() ? null : amenities);

        BusDAO busDAO = new BusDAO();
        if (busDAO.updateBus(bus)) {
            FlashUtil.setMessage(req, "success", "Bus updated.");
            resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
        } else {
            req.setAttribute("error", "Failed to update bus. Please try again.");
            req.setAttribute("bus", bus);
            req.getRequestDispatcher("/WEB-INF/admin/update-bus.jsp").forward(req, resp);
        }
    }
}
