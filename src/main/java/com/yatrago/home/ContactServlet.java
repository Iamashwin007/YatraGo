package com.yatrago.home;

import com.yatrago.utils.FlashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || subject == null || subject.trim().isEmpty()
                || message == null || message.trim().isEmpty()) {
            FlashUtil.setMessage(req, "error", "All fields are required.");
            resp.sendRedirect(req.getContextPath() + "/pages/contact");
            return;
        }

        FlashUtil.setMessage(req, "success", "Thank you for contacting us");
        resp.sendRedirect(req.getContextPath() + "/pages/contact");
    }
}