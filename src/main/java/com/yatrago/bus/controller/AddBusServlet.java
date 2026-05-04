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

@WebServlet("/admin/add-bus")
public class AddBusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/admin/add-bus.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String busNumber    = req.getParameter("busNumber").trim();
        String operatorName = req.getParameter("operatorName").trim();
        String busType      = req.getParameter("busType").trim();
        String seatsStr     = req.getParameter("totalSeats").trim();
        String amenities    = req.getParameter("amenities").trim();
        String status       = req.getParameter("status").trim();

        if (busNumber.isEmpty() || operatorName.isEmpty() || busType.isEmpty() || seatsStr.isEmpty()) {
            req.setAttribute("error", "All required fields must be filled.");
            req.getRequestDispatcher("/WEB-INF/admin/add-bus.jsp").forward(req, resp);
            return;
        }

        int totalSeats;
        try {
            totalSeats = Integer.parseInt(seatsStr);
            if (totalSeats < 1) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Total seats must be a positive number.");
            req.getRequestDispatcher("/WEB-INF/admin/add-bus.jsp").forward(req, resp);
            return;
        }

        BusDAO busDAO = new BusDAO();
        if (busDAO.isBusNumberExist(busNumber)) {
            req.setAttribute("error", "Bus number '" + busNumber + "' already exists.");
            req.getRequestDispatcher("/WEB-INF/admin/add-bus.jsp").forward(req, resp);
            return;
        }

        BusModel bus = new BusModel();
        bus.setBusNumber(busNumber);
        bus.setOperatorName(operatorName);
        bus.setBusType(busType);
        bus.setTotalSeats(totalSeats);
        bus.setAmenities(amenities.isEmpty() ? null : amenities);
        bus.setStatus(status.isEmpty() ? "active" : status);

        if (busDAO.addBus(bus)) {
            FlashUtil.setMessage(req, "success", "Bus added successfully.");
            resp.sendRedirect(req.getContextPath() + "/admin/bus-list");
        } else {
            req.setAttribute("error", "Failed to add bus. Please try again.");
            req.getRequestDispatcher("/WEB-INF/admin/add-bus.jsp").forward(req, resp);
        }
    }
}
