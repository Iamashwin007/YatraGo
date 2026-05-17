package com.yatrago.booking.controller;

import com.yatrago.booking.dao.BookingDAO;
import com.yatrago.user.model.UserModel;
import com.yatrago.utils.FlashUtil;
import com.yatrago.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cancel-booking")
public class CancelBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
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
            FlashUtil.setMessage(req, "error", "Could not cancel booking.");
            resp.sendRedirect(req.getContextPath() + "/my-bookings");
            return;
        }

        boolean success = new BookingDAO().cancelBooking(bookingId);
        if (success) {
            FlashUtil.setMessage(req, "success", "Booking cancelled.");
        } else {
            FlashUtil.setMessage(req, "error", "Could not cancel booking.");
        }
        resp.sendRedirect(req.getContextPath() + "/my-bookings");
        return;
    }
}
