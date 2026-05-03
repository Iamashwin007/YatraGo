package com.yatrago.admin.controller;

import com.yatrago.bus.dao.BusDAO;
import com.yatrago.route.dao.RouteDAO;
import com.yatrago.user.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        BusDAO busDAO = new BusDAO();
        RouteDAO routeDAO = new RouteDAO();
        UserDAO userDAO = new UserDAO();
        req.setAttribute("busCount", busDAO.getCount());
        req.setAttribute("routeCount", routeDAO.getCount());
        req.setAttribute("userCount", userDAO.getCount());
        req.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(req, resp);
    }
}
