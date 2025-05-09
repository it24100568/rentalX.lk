package lk.sliit.rentalx.rentalx;
@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean rememberMe = "on".equals(request.getParameter("remember"));

        try {
            // Get all admins from file
            List<Admin> admins = AdminManagementServlet.getAllAdmins();

            // Find admin with matching credentials
            Admin admin = admins.stream()
                    .filter(a -> a.getEmail().equalsIgnoreCase(email) && a.getPassword().equals(password))
                    .findFirst()
                    .orElse(null);

            if (admin != null) {
                // Update last login time
                admin.setLastLogin(new Date());
                AdminManagementServlet.saveAdmins(admins);

                // Log the login activity
                admin.logActivity("Logged in to admin portal");

                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);

                // Set remember me cookie if selected
                if (rememberMe) {
                    Cookie emailCookie = new Cookie("adminEmail", email);
                    emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                    emailCookie.setHttpOnly(true);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                }

                // Redirect to admin dashboard
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check for remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("adminEmail")) {
                    request.setAttribute("rememberedEmail", cookie.getValue());
                    break;
                }
            }
        }

        request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
    }
}
