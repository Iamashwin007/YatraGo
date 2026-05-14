package com.yatrago.home;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/pages/*")
public class PageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo(); // e.g. /about or /contact

        if (pathInfo == null || "/".equals(pathInfo)) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        switch (pathInfo) {
            case "/about":
                req.getRequestDispatcher("/WEB-INF/pages/about.jsp").forward(req, resp);
                break;
            case "/contact":
                req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}