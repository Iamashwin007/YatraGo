package com.yatrago.utils;

import com.yatrago.user.model.UserModel;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    public static void setUser(HttpServletRequest req, UserModel user) {
        req.getSession().setAttribute("user", user);
    }

    public static UserModel getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        return (UserModel) session.getAttribute("user");
    }

    public static boolean isLoggedIn(HttpServletRequest req) {
        return getUser(req) != null;
    }

    public static boolean isAdmin(HttpServletRequest req) {
        UserModel user = getUser(req);
        return user != null && "admin".equals(user.getRole());
    }

    public static void logout(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
