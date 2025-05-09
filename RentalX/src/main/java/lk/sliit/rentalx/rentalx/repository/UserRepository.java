package lk.sliit.rentalx.rentalx.repository;

import lk.sliit.rentalx.rentalx.models.User;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class UserRepository {
    // In-memory storage for demo purposes
    // In a real application, this would connect to a database
    private static final Map<String, User> users = new HashMap<>();

    static {
        // Add some demo users
        users.put("user@example.com", new User("user@example.com", "password123", "John Doe"));
        users.put("admin@example.com", new User("admin@example.com", "admin123", "Admin User"));
    }

    public User findByEmail(String email) {
        return users.get(email);
    }

    public boolean validateUser(String email, String password) {
        User user = findByEmail(email);
        return user != null && user.getPassword().equals(password);
    }
    public boolean emailExists(String email) throws IOException {
        // Implementation to check if email exists
        return false;
    }
    
    public boolean saveUser(String email, String password) {
        return false;
    }

    public void saveUser(User user) {
    }
}