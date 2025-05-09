package lk.sliit.rentalx.rentalx.user;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

@WebServlet("/admin-management")
public class AdminServlet extends HttpServlet {
    private static final String ADMINS_FILE = "/WEB-INF/data/admins.txt";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        switch (action) {
            case "add":
                addAdmin(req.getParameter("email"), req.getParameter("password"));
                break;
            case "delete":
                deleteAdmin(req.getParameter("email"));
                break;
        }
    }

    private void deleteAdmin(String email) {

    }

    private void addAdmin(String email, String password) throws IOException {
        Files.write(Paths.get(getServletContext().getRealPath(ADMINS_FILE)),
                (email + "," + password + System.lineSeparator()).getBytes(),
                StandardOpenOption.APPEND);
    }
}
