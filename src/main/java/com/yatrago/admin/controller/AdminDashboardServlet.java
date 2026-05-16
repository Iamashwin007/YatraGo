package com.yatrago.admin.controller;

import com.yatrago.booking.dao.BookingDAO;
import com.yatrago.bus.dao.BusDAO;
import com.yatrago.route.dao.RouteDAO;
import com.yatrago.schedule.dao.ScheduleDAO;
import com.yatrago.user.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Handles GET requests to /admin/dashboard.
// Only doGet is needed because the dashboard is read-only — it shows data, never saves it.
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Create one DAO object per table so we can call getCount() on each.
        // Each DAO knows how to query its own table; the servlet just asks for the number.
        BusDAO busDAO = new BusDAO();
        RouteDAO routeDAO = new RouteDAO();
        ScheduleDAO scheduleDAO = new ScheduleDAO();
        UserDAO userDAO = new UserDAO();

        // setAttribute puts a value on the request so the JSP can read it with ${busCount}, etc.
        // We never pass data to the JSP directly — attributes are the bridge between servlet and JSP.
        req.setAttribute("busCount",      busDAO.getCount());
        req.setAttribute("routeCount",    routeDAO.getCount());
        req.setAttribute("scheduleCount", scheduleDAO.getCount());
        req.setAttribute("userCount",     userDAO.getCount());

        // BookingDAO has extra aggregate methods (revenue, confirmed count, per-route breakdown),
        // so we create it separately from the simple-count DAOs above.
        BookingDAO bookingDAO = new BookingDAO();
        req.setAttribute("totalBookings",     bookingDAO.getTotalBookingsCount());
        req.setAttribute("totalRevenue",      bookingDAO.getTotalRevenue());
        req.setAttribute("confirmedBookings", bookingDAO.getConfirmedBookingsCount());

        // bookingsPerRoute returns a List of Maps (route name, booking count, revenue).
        // The dashboard JSP uses a JSTL <c:forEach> loop to turn this list into a table.
        req.setAttribute("bookingsPerRoute",  bookingDAO.getBookingsPerRoute());

        // forward() hands control to the JSP while keeping all the attributes we just set.
        // We use forward (not redirect) so the JSP can read the request attributes.
        req.getRequestDispatcher("/WEB-INF/admin/dashboard.jsp").forward(req, resp);
    }
}
