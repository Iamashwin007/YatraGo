package com.yatrago.booking.controller;

import com.yatrago.booking.dao.BookingDAO;
import com.yatrago.booking.model.BookingModel;
import com.yatrago.user.model.UserModel;
import com.yatrago.utils.FlashUtil;
import com.yatrago.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/e-ticket")
public class ETicketServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UserModel user = SessionUtil.getUser(req);
        if (user == null) {
            FlashUtil.setMessage(req, "error", "Please log in.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        String bookingIdParam = req.getParameter("bookingId");
        int bookingId;
        try {
            bookingId = Integer.parseInt(bookingIdParam);
        } catch (NumberFormatException e) {
            FlashUtil.setMessage(req, "error", "Invalid booking.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }
        BookingModel booking = new BookingDAO().getBookingById(bookingId);
        if (booking == null || booking.getUserId() != user.getId()) {
            FlashUtil.setMessage(req, "error", "Booking not found.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }
        req.setAttribute("booking", booking);
        req.getRequestDispatcher("/WEB-INF/booking/e-ticket.jsp").forward(req, resp);
    }
}
