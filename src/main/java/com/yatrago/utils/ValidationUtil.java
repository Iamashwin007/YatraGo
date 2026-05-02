package com.yatrago.utils;

public class ValidationUtil {

    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        return email.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$");
    }

    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        return phone.matches("^9\\d{9}$");
    }

    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) return false;
        return password.matches(".*[a-zA-Z].*") && password.matches(".*\\d.*");
    }

    public static boolean isNotEmpty(String s) {
        return s != null && !s.trim().isEmpty();
    }
}
