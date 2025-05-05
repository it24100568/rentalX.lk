package lk.sliit.rentalx.rentalx;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.nio.file.*;

@WebServlet("/register")

public class RegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {



        // Get form parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate inputs
        if (!password.equals(confirmPassword)) {
            forwardWithError(request, response, "Passwords do not match");
            return;
        }

        if (!email.endsWith("@my.sliit.lk")) {
            forwardWithError(request, response, "Please use your SLIIT email (@my.sliit.lk)");
            return;
        }

        // Prepare user data
        String userData = String.format("%s,%s,%s,%s\n",
                email, fullName, phone, password);

        // Save to file
        try {
            Path path = Paths.get(getServletContext().getRealPath("/WEB-INF/users.txt"));
            Files.createDirectories(path.getParent()); // Create directory if not exists
            Files.write(path, userData.getBytes(), StandardOpenOption.CREATE, StandardOpenOption.APPEND);

            // Redirect to login page with success message
            response.sendRedirect("login.jsp?success=Registration successful! Please login.");

        } catch (IOException e) {
            forwardWithError(request, response, "System error: Unable to complete registration");
            e.printStackTrace();
        }
    }

    private void forwardWithError(HttpServletRequest request,
                                  HttpServletResponse response,
                                  String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("registration.jsp").forward(request, response);
    }
}