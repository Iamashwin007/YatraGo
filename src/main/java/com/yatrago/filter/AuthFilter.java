package com.yatrago.filter;

import com.yatrago.utils.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/admin/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req   = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        if (SessionUtil.isAdmin(req)) {
            chain.doFilter(request, response);
        } else if (SessionUtil.getUser(req) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.getRequestDispatcher("/WEB-INF/pages/access-denied.jsp").forward(req, resp);
        }
    }
}
