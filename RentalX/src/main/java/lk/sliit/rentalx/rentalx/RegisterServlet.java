//package lk.sliit.rentalx.rentalx.control;
//
//import lk.sliit.rentalx.rentalx.models.User;
//import lk.sliit.rentalx.rentalx.service.UserService;
//import lk.sliit.rentalx.rentalx.util.FileStorageUtil;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@WebServlet("/register")
//public class RegisterServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    private UserService userService;
//
//    @Override
//    public void init() {
//        userService = new UserService();
//        System.out.println("RegisterServlet initialized");
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        request.getRequestDispatcher("registration.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        System.out.println("Processing registration request...");
//
//        // Get form data
//        String fullName = request.getParameter("fullName");
//        String email = request.getParameter("email").trim();
//        String phone = request.getParameter("phone");
//        String password = request.getParameter("password");
//        String confirmPassword = request.getParameter("confirmPassword");
//
//        System.out.println("Registration attempt for: " + email);
//
//        // Validate inputs
//        if (fullName == null || email == null || password == null ||
//                fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
//            request.setAttribute("error", "All fields are required");
//            request.getRequestDispatcher("registration.jsp").forward(request, response);
//            return;
//        }
//
//        if (!password.equals(confirmPassword)) {
//            request.setAttribute("error", "Passwords do not match");
//            request.getRequestDispatcher("registration.jsp").forward(request, response);
//            return;
//        }
//
//        if (userService.isEmailExists(email)) {
//            request.setAttribute("error", "Email already exists");
//            request.getRequestDispatcher("registration.jsp").forward(request, response);
//            return;
//        }
//
//        // Create user object
//        User user = new User(fullName, email, phone, password);
//
//        // Register user
//        boolean success = userService.registerUser(user);
//
//        if (success) {
//            System.out.println("User registered successfully: " + email);
//            // Debug: Print all users
//            FileStorageUtil.printAllUsers();
//
//            request.getSession().setAttribute("message", "Registration successful! Please login.");
//            response.sendRedirect("login.jsp");
//        } else {
//            System.out.println("Registration failed for: " + email);
//            request.setAttribute("error", "Registration failed. Please try again.");
//            request.getRequestDispatcher("registration.jsp").forward(request, response);
//        }
//    }
//}