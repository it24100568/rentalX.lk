package lk.sliit.Service;

import lk.sliit.Model.Admin;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class AdminService {
    private static final String ADMIN_FILE = "C:/Users/Yuhansa/IdeaProjects/rental_application/admins.txt";


    public void saveAdmin(Admin admin) {
        try {
            File file = new File(ADMIN_FILE);
            file.getParentFile().mkdirs();
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                writer.write(admin.getName() + "," + admin.getEmail() + "," + admin.getPassword());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public List<Admin> readAdmins() {
        List<Admin> admins = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3) {
                    admins.add(new Admin(parts[0], parts[1], parts[2]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return admins;
    }
}
