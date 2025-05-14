package lk.sliit.rentalx.rentalx.Controller;
import lk.sliit.rentalx.rentalx.Model.User;
import lk.sliit.rentalx.rentalx.Service.FileService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;

@MultipartConfig
public class UserController extends HttpServlet {
    private FileService fileService = new FileService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            User user = new User(
                    request.getParameter("id"),
                    request.getParameter("name"),
                    request.getParameter("email"),
                    request.getParameter("password"),
                    false
            );
            fileService.saveUser(user);
            response.sendRedirect("user_login.jsp");

        } else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            List<User> users = fileService.readUsers();
            for (User user : users) {
                if (user.getEmail().equals(email) && user.getPassword().equals(password) && !user.isBlocked()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    response.sendRedirect("home.jsp");
                    return;
                }
            }
            response.sendRedirect("user_login.jsp?error=invalid");

        } else if ("update".equals(action)) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address1 = request.getParameter("address1");
            String address2 = request.getParameter("address2");

            Part filePart = request.getPart("profileImage");
            String fileName = filePart.getSubmittedFileName();
            String imagePath = "";

            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            if (fileName != null && !fileName.isEmpty()) {
                String uploadPath = getServletContext().getRealPath("") + "images" + File.separator + fileName;
                File imageFile = new File(uploadPath);
                imageFile.getParentFile().mkdirs();
                filePart.write(uploadPath);
                imagePath = "images/" + fileName;
            } else {
                imagePath = currentUser.getProfileImagePath();
            }

            User updatedUser = new User(id, name, email, password, false, address1, address2, imagePath);
            fileService.updateUser(updatedUser);
            session.setAttribute("user", updatedUser);
            session.setAttribute("success", "Profile updated successfully.");
            response.sendRedirect("profile.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
        }
    }
}