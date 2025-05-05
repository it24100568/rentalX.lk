package lk.sliit.rentalx.rentalx;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    // Hardcoded admin credentials
    private final String ADMIN_EMAIL = "admin@my.sliit.lk";
    private final String ADMIN_PASSWORD = "admin123";
    private static final String USERS_FILE = "/WEB-INF/users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 1. First check admin credentials
        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", "Administrator");
            session.setAttribute("email", ADMIN_EMAIL);
            session.setAttribute("role", "admin");
            response.sendRedirect("profile.jsp");
            return;
        }

        // 2. Check regular users from file
        String filePath = getServletContext().getRealPath(USERS_FILE);
        File file = new File(filePath);

        // Debug output (remove in production)
        System.out.println("User file path: " + filePath);
        System.out.println("File exists: " + file.exists());

        if (!file.exists()) {
            request.setAttribute("error", "System error: User database not found");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try (Scanner scanner = new Scanner(file)) {
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine().trim();
                if (line.isEmpty()) continue;

                String[] userData = line.split(",");
                if (userData.length >= 4 &&
                        userData[0].trim().equalsIgnoreCase(email) &&
                        userData[3].trim().equals(password)) {

                    // Successful login
                    HttpSession session = request.getSession();
                    session.setAttribute("user", userData[1].trim()); // Full name
                    session.setAttribute("email", userData[0].trim()); // Email
                    session.setAttribute("role", "user");
                    response.sendRedirect("profile.jsp");
                    return;
                }
            }

            // If we get here, credentials didn't match
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (FileNotFoundException e) {
            request.setAttribute("error", "System error: Unable to access user data");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}