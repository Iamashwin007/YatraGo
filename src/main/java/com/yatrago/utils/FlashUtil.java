package com.yatrago.utils;

import jakarta.servlet.http.HttpServletRequest;

public class FlashUtil {

    public static void setMessage(HttpServletRequest req, String type, String message) {
        req.getSession().setAttribute("flashType",    type);
        req.getSession().setAttribute("flashMessage", message);
    }
}
