package com.yatrago.user.controller;

import com.yatrago.user.dao.UserDAO;
import com.yatrago.user.model.UserModel;
import com.yatrago.utils.CookieUtil;
import com.yatrago.utils.FlashUtil;
import com.yatrago.utils.PasswordUtil;
import com.yatrago.utils.SessionUtil;
import com.yatrago.utils.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (!ValidationUtil.isNotEmpty(email) || !ValidationUtil.isNotEmpty(password)) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }

        UserModel user = userDAO.getUserByEmail(email.trim());

        if (user == null || !PasswordUtil.verifyPassword(password, user.getPassword())) {
            req.setAttribute("error", "Invalid email or password.");
            req.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(req, resp);
            return;
        }

        SessionUtil.setUser(req, user);
        CookieUtil.setCookie(resp, "email", user.getEmail(), 30 * 24 * 60 * 60);
        FlashUtil.setMessage(req, "success", "Welcome back, " + user.getName() + ".");

        if ("admin".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}
