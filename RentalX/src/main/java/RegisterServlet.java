import lk.sliit.rentalx.rentalx.Model.User;
import lk.sliit.rentalx.rentalx.Service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/registration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate inputs
        if (fullName == null || email == null || password == null ||
                fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/registration.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/registration.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Invalid email format");
            request.getRequestDispatcher("/registration.jsp").forward(request, response);
            return;
        }

        try {
            if (userService.isEmailExists(email)) {
                request.setAttribute("error", "Email already exists");
                request.getRequestDispatcher("/registration.jsp").forward(request, response);
                return;
            }

            // Hash password with SHA-256
            String hashedPassword = hashPassword(password);
            User user = new User(fullName, email, phone, hashedPassword);

            // Register user
            boolean success = userService.registerUser(user);

            if (success) {
                request.getSession().setAttribute("message", "Registration successful! Please login.");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/registration.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration: " + e.getMessage());
            request.getRequestDispatcher("/registration.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Failed to hash password", e);
        }
    }
}