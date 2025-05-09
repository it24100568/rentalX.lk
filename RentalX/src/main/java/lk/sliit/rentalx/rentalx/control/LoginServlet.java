package lk.sliit.rentalx.rentalx.control;

import lk.sliit.rentalx.rentalx.repository.UserRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserRepository repo = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (repo.saveUser(email, password)) {
            // store user in session and go to dashboard
            HttpSession session = req.getSession();
            session.setAttribute("userEmail", email);
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid email or password.");
            req.getRequestDispatcher("/login.jsp")
                    .forward(req, resp);
        }
    }
}
