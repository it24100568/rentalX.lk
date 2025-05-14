package lk.sliit.rentalx.rentalx;

import lk.sliit.rentalx.rentalx.Model.User;
import lk.sliit.rentalx.rentalx.Service.UserService;
import lk.sliit.rentalx.rentalx.util.FileStorageUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
        System.out.println("LoginServlet initialized");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Processing login request...");

        // Get form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt for: " + email);

        // Debug: Print all users
        FileStorageUtil.printAllUsers();

        // Validate form data
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Validate login
        if (userService.validateLogin(email, password)) {
            // Get user details
            User user = userService.getUserByEmail(email);
            System.out.println("Login successful for: " + email);

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);

            // Redirect to profile page
            response.sendRedirect("profile.jsp");
        } else {
            System.out.println("Login failed for: " + email);
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}