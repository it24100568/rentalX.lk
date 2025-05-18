package lk.sliit.Service;

import lk.sliit.Model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileService {
    private static final String USER_FILE = "C:/Users/Yuhansa/IdeaProjects/rental_application/users.txt";

    public void saveUser(User user) {
        try {
            File file = new File(USER_FILE);
            file.getParentFile().mkdirs();

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                writer.write(user.getId() + "," + user.getName() + "," + user.getEmail() + "," +
                        user.getPassword() + "," + user.isBlocked() + "," + user.getAddress1() + "," +
                        user.getAddress2() + "," + user.getProfileImagePath());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<User> readUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                User user = new User(
                        parts[0], parts[1], parts[2], parts[3],
                        Boolean.parseBoolean(parts[4]),
                        parts.length > 5 ? parts[5] : "",
                        parts.length > 6 ? parts[6] : "",
                        parts.length > 7 ? parts[7] : ""
                );
                users.add(user);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public void updateUser(User updatedUser) {
        List<User> users = readUsers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE))) {
            for (User u : users) {
                if (u.getId().equals(updatedUser.getId())) {
                    u = updatedUser;
                }
                writer.write(u.getId() + "," + u.getName() + "," + u.getEmail() + "," +
                        u.getPassword() + "," + u.isBlocked() + "," + u.getAddress1() + "," +
                        u.getAddress2() + "," + u.getProfileImagePath());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(String userId) {
        List<User> users = readUsers();
        users.removeIf(user -> user.getId().equals(userId));
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE))) {
            for (User u : users) {
                writer.write(u.getId() + "," + u.getName() + "," + u.getEmail() + "," +
                        u.getPassword() + "," + u.isBlocked() + "," + u.getAddress1() + "," +
                        u.getAddress2() + "," + u.getProfileImagePath());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
