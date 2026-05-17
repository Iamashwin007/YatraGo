package com.yatrago.booking.controller;

import com.yatrago.booking.dao.BookingDAO;
import com.yatrago.booking.model.BookingModel;
import com.yatrago.booking.model.BookingSeatModel;
import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.schedule.model.ScheduleModel;
import com.yatrago.user.model.UserModel;
import com.yatrago.utils.FlashUtil;
import com.yatrago.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;

@WebServlet("/confirm-booking")
public class ConfirmBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Check user is logged in
        UserModel user = SessionUtil.getUser(req);
        if (user == null) {
            FlashUtil.setMessage(req, "error", "Please log in to book a seat.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Read scheduleId
        String scheduleIdParam = req.getParameter("scheduleId");
        int scheduleId;
        try {
            scheduleId = Integer.parseInt(scheduleIdParam);
        } catch (NumberFormatException e) {
            FlashUtil.setMessage(req, "error", "Invalid schedule.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        // 3. Load schedule to get fare
        ScheduleModel schedule = new ScheduleDAO().getScheduleById(scheduleId);
        if (schedule == null) {
            FlashUtil.setMessage(req, "error", "Schedule not found.");
            resp.sendRedirect(req.getContextPath() + "/search");
            return;
        }

        // 4. Read seat numbers, passenger names, passenger ages (parallel arrays from JSP)
        String[] seatNumbers    = req.getParameterValues("seatNumber");
        String[] passengerNames = req.getParameterValues("passengerName");
        String[] passengerAges  = req.getParameterValues("passengerAge");

        if (seatNumbers == null || seatNumbers.length == 0) {
            FlashUtil.setMessage(req, "error", "Please select at least one seat.");
            resp.sendRedirect(req.getContextPath() + "/seat-select?scheduleId=" + scheduleId);
            return;
        }

        int passengerCount = seatNumbers.length;

        // 5. Calculate total fare
        BigDecimal totalFare = schedule.getFare().multiply(BigDecimal.valueOf(passengerCount));

        // 6. Generate booking reference e.g. YG-482910
        String bookingReference = "YG-" + (100000 + (int)(Math.random() * 900000));

        // 7. Build BookingModel
        BookingModel booking = new BookingModel();
        booking.setUserId(user.getId());
        booking.setScheduleId(scheduleId);
        booking.setBookingReference(bookingReference);
        booking.setTotalFare(totalFare);
        booking.setPassengerCount(passengerCount);
        booking.setBookingStatus("confirmed");

        // 8. Build seat list
        // seatNumber from JSP is a string like "1A", "2C" — we extract the row number (integer part)
        ArrayList<BookingSeatModel> seats = new ArrayList<>();
        for (int i = 0; i < passengerCount; i++) {
            BookingSeatModel seat = new BookingSeatModel();

            // Extract numeric part from seat label e.g. "1A" -> 1, "10C" -> 10
            String seatLabel = seatNumbers[i];
            int seatNum;
            try {
                seatNum = Integer.parseInt(seatLabel.replaceAll("[^0-9]", ""));
            } catch (NumberFormatException e) {
                seatNum = i + 1; // fallback
            }
            seat.setSeatNumber(seatNum);

            // Passenger name
            String name = (passengerNames != null && i < passengerNames.length)
                    ? passengerNames[i].trim() : "";
            seat.setPassengerName(name.isEmpty() ? "Passenger " + (i + 1) : name);

            // Passenger age (nullable)
            if (passengerAges != null && i < passengerAges.length) {
                try {
                    seat.setPassengerAge(Integer.parseInt(passengerAges[i].trim()));
                } catch (NumberFormatException e) {
                    seat.setPassengerAge(null);
                }
            }

            seats.add(seat);
        }

        // 9. Save to database
        boolean success = new BookingDAO().createBooking(booking, seats);

        if (success) {
            FlashUtil.setMessage(req, "success", "Booking confirmed! Reference: " + bookingReference);
            resp.sendRedirect(req.getContextPath() + "/e-ticket?bookingId=" + booking.getId());
        } else {
            FlashUtil.setMessage(req, "error", "Booking failed. Please try again.");
            resp.sendRedirect(req.getContextPath() + "/seat-select?scheduleId=" + scheduleId);
        }
    }
}
