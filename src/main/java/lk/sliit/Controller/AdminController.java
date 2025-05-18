package lk.sliit.Controller;

import lk.sliit.Model.Admin;
import lk.sliit.Model.User;
import lk.sliit.Service.AdminService;
import lk.sliit.Service.FileService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminController extends HttpServlet {
    private AdminService adminService = new AdminService();
    private FileService fileService = new FileService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Admin admin = new Admin(name, email, password);
            adminService.saveAdmin(admin);
            response.sendRedirect("admin_login.jsp");
        }

        if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            List<Admin> admins = adminService.readAdmins();
            for (Admin admin : admins) {
                if (admin.getEmail().equals(email) && admin.getPassword().equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    response.sendRedirect("admin_dashboard.jsp");
                    return;
                }
            }
            response.sendRedirect("admin_login.jsp?error=invalid");
        }

        if ("blockUser".equals(action) || "unblockUser".equals(action)) {
            String userId = request.getParameter("userId");
            boolean block = "blockUser".equals(action);
            List<User> users = fileService.readUsers();
            for (User user : users) {
                if (user.getId().equals(userId)) {
                    user.setBlocked(block);
                    fileService.updateUser(user);
                    break;
                }
            }
            response.sendRedirect("user_list.jsp");
        }

        if ("deleteUser".equals(action)) {
            String userId = request.getParameter("userId");
            fileService.deleteUser(userId);
            response.sendRedirect("user_list.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("admin_login.jsp");
        }
    }
}
