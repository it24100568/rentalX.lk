package lk.sliit.rentalx.rentalx.models;
// src/main/java/com/rentalx/models/User.java
import java.io.Serializable;

public class User implements Serializable {
    private String fullName;
    private String email;
    private String phone;
    private String password;

    // Constructors
    public User(String mail, String password123, String johnDoe) {}

    public User(String fullName, String email, String phone, String password) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
    }

    // Getters and Setters
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return fullName + "," + email + "," + phone + "," + password;
    }
}