package lk.sliit.rentalx.rentalx.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/register"})
public class RegistrationServlet extends HttpServlet {

    // Configuration constants
    private static final String USERS_FILE = "/WEB-INF/data/users.txt";
    private static final String SLIIT_EMAIL_DOMAIN = "@my.sliit.lk";
    private static final String SUCCESS_REDIRECT = "login.jsp";
    private static final String ERROR_REDIRECT = "registration.jsp";
    private static final String DELIMITER = ",";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get and sanitize form parameters
            String fullName = sanitizeInput(request.getParameter("fullName"));
            String email = sanitizeInput(request.getParameter("email"));
            String phone = sanitizeInput(request.getParameter("phone"));
            String password = sanitizeInput(request.getParameter("password"));
            String confirmPassword = sanitizeInput(request.getParameter("confirmPassword"));

            // 2. Validate inputs
            List<String> validationErrors = validateInputs(fullName, email, phone, password, confirmPassword);
            if (!validationErrors.isEmpty()) {
                handleErrors(request, response, validationErrors);
                return;
            }

            // 3. Check if email already exists
            if (isEmailRegistered(email)) {
                handleError(request, response, "Email already registered. Please use a different email.");
                return;
            }

            // 4. Prepare and save user data
            saveUserData(fullName, email, phone, password);

            // 5. Redirect with success message
            response.sendRedirect(SUCCESS_REDIRECT + "?success=Registration successful! Please login.");

        } catch (Exception e) {
            handleError(request, response, "System error: Unable to complete registration. Please try again.");
            logError("Registration error", e);
        }
    }

    // Input validation method
    private List<String> validateInputs(String fullName, String email, String phone,
                                        String password, String confirmPassword) {
        List<String> errors = new ArrayList<>();

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Full name is required");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        } else if (!email.endsWith(SLIIT_EMAIL_DOMAIN)) {
            errors.add("Please use your SLIIT email (" + SLIIT_EMAIL_DOMAIN + ")");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.add("Phone number is required");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        } else if (password.length() < 8) {
            errors.add("Password must be at least 8 characters");
        }

        if (!password.equals(confirmPassword)) {
            errors.add("Passwords do not match");
        }

        return errors;
    }

    // Check if email already exists
    private boolean isEmailRegistered(String email) throws IOException {
        Path path = Paths.get(getServletContext().getRealPath(USERS_FILE));
        if (!Files.exists(path)) {
            return false;
        }

        try (BufferedReader reader = Files.newBufferedReader(path)) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(DELIMITER);
                if (userData.length > 0 && userData[0].equalsIgnoreCase(email)) {
                    return true;
                }
            }
        }
        return false;
    }

    // Save user data to file
    private void saveUserData(String fullName, String email, String phone, String password)
            throws IOException {
        Path path = Paths.get(getServletContext().getRealPath(USERS_FILE));
        Files.createDirectories(path.getParent());

        String userData = String.join(DELIMITER,
                email, fullName, phone, password) + System.lineSeparator();

        Files.write(path, userData.getBytes(),
                StandardOpenOption.CREATE,
                StandardOpenOption.APPEND);
    }

    // Helper method to sanitize input
    private String sanitizeInput(String input) {
        return input == null ? null : input.trim();
    }

    // Error handling methods
    private void handleErrors(HttpServletRequest request, HttpServletResponse response,
                              List<String> errors) throws ServletException, IOException {
        request.setAttribute("errors", errors);
        request.getRequestDispatcher(ERROR_REDIRECT).forward(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(ERROR_REDIRECT).forward(request, response);
    }

    // Logging method
    private void logError(String message, Exception e) {
        System.err.println(message + ": " + e.getMessage());
        e.printStackTrace();
    }
}