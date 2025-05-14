package lk.sliit.rentalx.rentalx.Service;

import lk.sliit.rentalx.rentalx.Model.User;
import lk.sliit.rentalx.rentalx.util.FileStorageUtil;
import lk.sliit.rentalx.rentalx.util.PasswordUtil;

public class UserService {

    public boolean registerUser(User user) {
        // Hash the password before saving
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        return FileStorageUtil.saveUser(user);
    }

    public User getUserByEmail(String email) {
        return FileStorageUtil.getUserByEmail(email);
    }

    public boolean isEmailExists(String email) {
        return FileStorageUtil.isEmailExists(email);
    }

    public boolean validateLogin(String email, String password) {
        User user = getUserByEmail(email);
        if (user != null) {
            return PasswordUtil.verifyPassword(password, user.getPassword());
        }
        return false;
    }
}