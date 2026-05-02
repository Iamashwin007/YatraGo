package com.yatrago.user.controller;

import com.yatrago.utils.CookieUtil;
import com.yatrago.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        SessionUtil.logout(req);
        CookieUtil.deleteCookie(resp, "email");
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
