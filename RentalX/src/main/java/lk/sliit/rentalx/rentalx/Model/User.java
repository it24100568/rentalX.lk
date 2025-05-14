package lk.sliit.rentalx.rentalx.Model;

public class User {
    private String id;
    private String name;
    private String email;
    private String password;
    private boolean isBlocked;
    private String address1;
    private String address2;
    private String profileImagePath;
    private String field1;
    private String field2;
    private String field3;
    public User(String fullName, String email, String phone, String hashedPassword) {}

    // Full constructor with all fields
    public User(String id, String name, String email, String password, boolean isBlocked, String address1, String address2, String profileImagePath) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.isBlocked = isBlocked;
        this.address1 = address1;
        this.address2 = address2;
        this.profileImagePath = profileImagePath;
    }

    // Basic constructor (for backward compatibility)
    public User(String id, String name, String email, String password, boolean isBlocked) {
        this(id, name, email, password, isBlocked, "", "", "");
    }

    public static User fromStorageString(String line) {
        return null;
    }

    // Encapsulation: Getters and Setters

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isBlocked() {
        return isBlocked;
    }

    public void setBlocked(boolean blocked) {
        isBlocked = blocked;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getProfileImagePath() {
        return profileImagePath;
    }

    public void setProfileImagePath(String profileImagePath) {
        this.profileImagePath = profileImagePath;
    }

    public boolean toStorageString() {

            try {
                String storageString = this.field1 + "|" + this.field2 + "|" + this.field3;
                return saveToStorage(storageString);
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
    private boolean saveToStorage(String storageString) {
        return false;
    }
}

