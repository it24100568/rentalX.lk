package lk.sliit.rentalx.rentalx.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordUtil {

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedPassword = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Error hashing password: " + e.getMessage());
            e.printStackTrace();
            // In case of error, return a simple hash to avoid breaking the application
            return password + "_hashed";
        }
    }

    public static boolean verifyPassword(String password, String hashedPassword) {
        String newHashedPassword = hashPassword(password);
        return newHashedPassword.equals(hashedPassword);
    }
}