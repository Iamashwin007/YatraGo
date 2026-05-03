package com.yatrago.route.controller;

import com.yatrago.route.dao.RouteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/delete-route")
public class DeleteRouteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                RouteDAO routeDAO = new RouteDAO();
                routeDAO.deleteRoute(id);
            } catch (NumberFormatException e) {
                System.out.println("Invalid route id for delete: " + e.getMessage());
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/route-list");
    }
}
