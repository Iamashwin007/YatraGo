package com.yatrago.user.controller;

import com.yatrago.user.dao.UserDAO;
import com.yatrago.user.model.UserModel;
import com.yatrago.utils.FlashUtil;
import com.yatrago.utils.PasswordUtil;
import com.yatrago.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UserModel user = SessionUtil.getUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UserModel user = SessionUtil.getUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        if ("updateName".equals(action)) {
            String name = req.getParameter("name");
            if (name == null || name.trim().isEmpty()) {
                FlashUtil.setMessage(req, "error", "Name cannot be empty.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }
            name = name.trim();
            if (new UserDAO().updateName(user.getId(), name)) {
                user.setName(name);
                FlashUtil.setMessage(req, "success", "Name updated.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            } else {
                FlashUtil.setMessage(req, "error", "Could not update name.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

        } else if ("updatePassword".equals(action)) {
            String currentPassword = req.getParameter("currentPassword");
            String newPassword     = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (currentPassword == null || currentPassword.isEmpty()
                    || newPassword == null || newPassword.isEmpty()
                    || confirmPassword == null || confirmPassword.isEmpty()) {
                FlashUtil.setMessage(req, "error", "All password fields are required.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
                FlashUtil.setMessage(req, "error", "Current password is incorrect.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                FlashUtil.setMessage(req, "error", "New passwords do not match.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            if (newPassword.length() < 6) {
                FlashUtil.setMessage(req, "error", "Password must be at least 6 characters.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }

            String hashed = PasswordUtil.hashPassword(newPassword);
            if (new UserDAO().updatePassword(user.getId(), hashed)) {
                user.setPassword(hashed);
                FlashUtil.setMessage(req, "success", "Password changed.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            } else {
                FlashUtil.setMessage(req, "error", "Could not change password.");
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }
        }
    }
}
