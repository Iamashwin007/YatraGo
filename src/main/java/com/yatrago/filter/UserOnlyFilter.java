package com.yatrago.filter;

import com.yatrago.user.model.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/search", "/seat-select", "/my-bookings"})
public class UserOnlyFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        UserModel user = req.getSession(false) != null
                ? (UserModel) req.getSession().getAttribute("user")
                : null;

        if (user != null && "admin".equals(user.getRole())) {
            req.getRequestDispatcher("/WEB-INF/pages/access-denied.jsp").forward(req, resp);
            return;
        }

        chain.doFilter(request, response);
    }
}
