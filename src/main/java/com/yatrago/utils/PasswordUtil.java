package com.yatrago.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    public static String hashPassword(String plain) {
        return BCrypt.hashpw(plain, BCrypt.gensalt(12));
    }

    public static boolean verifyPassword(String plain, String hash) {
        try {
            return BCrypt.checkpw(plain, hash);
        } catch (Exception e) {
            System.out.println("Password verification error: " + e.getMessage());
            return false;
        }
    }
}
