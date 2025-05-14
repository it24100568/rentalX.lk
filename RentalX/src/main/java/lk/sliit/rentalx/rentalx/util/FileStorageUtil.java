package lk.sliit.rentalx.rentalx.util;
import lk.sliit.rentalx.rentalx.Model.User;
import java.io.*;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.nio.file.*;
import java.util.*;
import jakarta.servlet.ServletContext;

public class FileStorageUtil {
    private static final String USER_FILE_NAME = "users.txt";
    private static final String BACKUP_FILE_NAME = "users.bak";
    private static String filePath;
    private static String backupPath;

    // Initialize the file storage system
    public static void init(ServletContext context) throws IOException {
        String webInfPath = context.getRealPath("/WEB-INF");
        if (webInfPath == null) {
            throw new IOException("WEB-INF directory not found");
        }

        File dataDir = new File(webInfPath, "data");
        if (!dataDir.exists() && !dataDir.mkdirs()) {
            throw new IOException("Failed to create data directory");
        }

        filePath = dataDir.getAbsolutePath() + File.separator + USER_FILE_NAME;
        backupPath = dataDir.getAbsolutePath() + File.separator + BACKUP_FILE_NAME;

        createFileIfNotExists(filePath);
        createFileIfNotExists(backupPath);
    }

    private static void createFileIfNotExists(String path) throws IOException {
        File file = new File(path);
        if (!file.exists() && !file.createNewFile()) {
            throw new IOException("Failed to create file: " + path);
        }
    }

    // Save user with proper file locking
    public static synchronized boolean saveUser(User user) {
        if (user == null || user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }

        // Create backup before modification
        if (!createBackup()) {
            return false;
        }

        try (RandomAccessFile raf = new RandomAccessFile(filePath, "rw");
             FileChannel channel = raf.getChannel();
             FileLock lock = channel.lock()) {

            try (FileWriter fw = new FileWriter(raf.getFD());
                 BufferedWriter bw = new BufferedWriter(fw);
                 PrintWriter out = new PrintWriter(bw)) {

                if (user.getId() == null || user.getId().isEmpty()) {
                    user.setId(UUID.randomUUID().toString());
                }

                out.println(user.toStorageString());
                return true;
            }
        } catch (IOException e) {
            restoreFromBackup();
            System.err.println("Error saving user: " + e.getMessage());
            return false;
        }
    }

    // Get all users with improved error handling
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try (RandomAccessFile raf = new RandomAccessFile(filePath, "r");
             FileChannel channel = raf.getChannel();
             FileLock lock = channel.lock(0, Long.MAX_VALUE, true);
             BufferedReader br = new BufferedReader(new FileReader(raf.getFD()))) {

            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        User user = User.fromStorageString(line);
                        if (user != null) {
                            users.add(user);
                        }
                    } catch (IllegalArgumentException e) {
                        System.err.println("Skipping malformed user record: " + line);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading users: " + e.getMessage());
        }
        return users;
    }

    // Backup and restore utilities
    private static boolean createBackup() {
        try {
            Files.copy(Paths.get(filePath), Paths.get(backupPath),
                    StandardCopyOption.REPLACE_EXISTING);
            return true;
        } catch (IOException e) {
            System.err.println("Backup creation failed: " + e.getMessage());
            return false;
        }
    }

    private static void restoreFromBackup() {
        try {
            Files.copy(Paths.get(backupPath), Paths.get(filePath),
                    StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            System.err.println("Restore from backup failed: " + e.getMessage());
        }
    }

    // Improved email check
    public static boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        return getAllUsers().stream()
                .anyMatch(user -> email.equalsIgnoreCase(user.getEmail()));
    }

    // Get user by email with null check
    public static User getUserByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        return getAllUsers().stream()
                .filter(user -> email.equalsIgnoreCase(user.getEmail()))
                .findFirst()
                .orElse(null);
    }

    public static void printAllUsers() {
        System.out.println("All users:"+getAllUsers().toString());

    }
}