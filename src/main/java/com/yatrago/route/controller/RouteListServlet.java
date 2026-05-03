package com.yatrago.route.controller;

import com.yatrago.route.dao.RouteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/route-list")
public class RouteListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        RouteDAO routeDAO = new RouteDAO();
        req.setAttribute("routes", routeDAO.getAllRoutes());
        req.getRequestDispatcher("/WEB-INF/admin/route-list.jsp").forward(req, resp);
    }
}
