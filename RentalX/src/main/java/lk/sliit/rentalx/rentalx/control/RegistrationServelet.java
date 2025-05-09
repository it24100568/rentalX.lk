package lk.sliit.rentalx.rentalx.control;

import lk.sliit.rentalx.rentalx.models.User;
import lk.sliit.rentalx.rentalx.repository.UserRepository;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
class RegisterServlet extends HttpServlet {
    private UserRepository repo;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize repository with ServletContext
        ServletContext context = getServletContext();
        this.repo = new UserRepository();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Get all form parameters
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        // Validate input
        if (firstName == null || firstName.isEmpty() ||
                lastName == null || lastName.isEmpty() ||
                email == null || email.isEmpty() ||
                password == null || password.isEmpty()) {

            req.setAttribute("error", "All fields are required");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        try {
            // Check if email exists (changed from wait() to emailExists())
            if (repo.emailExists(email)) {
                req.setAttribute("error", "Email is already in use");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                return;
            }

            // Save and redirect to login page
            User user = new User(firstName, lastName, email, password);
            repo.saveUser(user);
            resp.sendRedirect(req.getContextPath() + "/login.jsp?success=Registration+successful");

        } catch (IOException e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}