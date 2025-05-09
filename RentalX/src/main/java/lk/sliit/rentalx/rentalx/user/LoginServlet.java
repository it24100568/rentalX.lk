package lk.sliit.rentalx.rentalx.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    // Constants for configuration
    private static final String ADMIN_EMAIL = "admin@my.sliit.lk";
    private static final String ADMIN_PASSWORD = "admin123";
    private static final String USERS_FILE = "/WEB-INF/data/users.txt";
    private static final String ADMIN_ROLE = "admin";
    private static final String USER_ROLE = "user";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get parameters from request
            String email = sanitizeInput(request.getParameter("email"));
            String password = sanitizeInput(request.getParameter("password"));

            // 2. Validate inputs
            if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
                handleError(request, response, "Email and password are required");
                return;
            }

            // 3. Check admin credentials first
            if (authenticateAdmin(email, password)) {
                createAdminSession(request);
                redirectToProfile(response);
                return;
            }

            // 4. Check regular users
            User authenticatedUser = authenticateUser(email, password);
            if (authenticatedUser != null) {
                createUserSession(request, authenticatedUser);
                redirectToProfile(response);
                return;
            }

            // 5. If no match found
            handleError(request, response, "Invalid email or password");

        } catch (Exception e) {
            handleError(request, response, "System error: " + e.getMessage());
        }
    }

    // Helper method to authenticate admin
    private boolean authenticateAdmin(String email, String password) {
        return ADMIN_EMAIL.equalsIgnoreCase(email) && ADMIN_PASSWORD.equals(password);
    }

    // Helper method to authenticate regular user
    private User authenticateUser(String email, String password) throws IOException {
        String filePath = getServletContext().getRealPath(USERS_FILE);
        File file = new File(filePath);

        if (!file.exists()) {
            throw new FileNotFoundException("User database not found");
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;

                String[] userData = line.split(",");
                if (userData.length >= 4) {
                    String userEmail = userData[0].trim();
                    String userPassword = userData[3].trim();

                    if (userEmail.equalsIgnoreCase(email)){
                        if (userPassword.equals(password)) {
                            return new User(
                                    userEmail,
                                    userData[1].trim(), // name
                                    userData[2].trim(), // phone
                                    userPassword,
                                    USER_ROLE
                            );
                        }
                        // Email matched but password didn't - stop searching
                        return null;
                    }
                }
            }
        }
        return null;
    }

    // Helper method to create admin session
    private void createAdminSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.setAttribute("user", "Administrator");
        session.setAttribute("email", ADMIN_EMAIL);
        session.setAttribute("role", ADMIN_ROLE);
    }

    // Helper method to create user session
    private void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user.getName());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("phone", user.getPhone());
        session.setAttribute("role", user.getRole());
    }

    // Helper method for error handling
    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // Helper method for successful login redirect
    private void redirectToProfile(HttpServletResponse response) throws IOException {
        response.sendRedirect("profile.jsp");
    }

    // Helper method to sanitize input
    private String sanitizeInput(String input) {
        if (input == null) return null;
        return input.trim();
    }

    // Inner User class for better data encapsulation
    private static class User {
        private String email;
        private String name;
        private String phone;
        private String password;
        private String role;

        public User(String email, String name, String phone, String password, String role) {
            this.email = email;
            this.name = name;
            this.phone = phone;
            this.password = password;
            this.role = role;
        }

        // Getters
        public String getEmail() { return email; }
        public String getName() { return name; }
        public String getPhone() { return phone; }
        public String getPassword() { return password; }
        public String getRole() { return role; }
    }

    // Add to LoginServlet.java
    private void updateUserProfile(String email, String newName, String newPhone) throws IOException {
        Path path = Paths.get(getServletContext().getRealPath(USERS_FILE));
        List<String> lines = Files.readAllLines(path);

        for (int i = 0; i < lines.size(); i++) {
            String[] userData = lines.get(i).split(",");
            if (userData[0].equals(email)) {
                lines.set(i, String.join(",", email, newName, newPhone, userData[3]));
                break;
            }
        }
        Files.write(path, lines);
    }

    private void deleteUser(String email) throws IOException {
        Path path = Paths.get(getServletContext().getRealPath(USERS_FILE));
        List<String> lines = Files.readAllLines(path)
                .stream()
                .filter(line -> !line.startsWith(email + ","))
                .collect(Collectors.toList());
        Files.write(path, lines);
    }

}