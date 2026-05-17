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
import java.util.ArrayList;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        UserModel user = SessionUtil.getUser(req);
        if (user == null) {
            FlashUtil.setMessage(req, "error", "Please log in to view bookings.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        ArrayList<BookingModel> bookings = new BookingDAO().getBookingsByUser(user.getId());
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/WEB-INF/booking/my-bookings.jsp").forward(req, resp);
    }
}
