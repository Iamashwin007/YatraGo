package com.yatrago.bus.controller;

import com.yatrago.bus.dao.BusDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/bus-list")
public class BusListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        BusDAO busDAO = new BusDAO();
        req.setAttribute("buses", busDAO.getAllBuses());
        req.getRequestDispatcher("/WEB-INF/admin/bus-list.jsp").forward(req, resp);
    }
}
