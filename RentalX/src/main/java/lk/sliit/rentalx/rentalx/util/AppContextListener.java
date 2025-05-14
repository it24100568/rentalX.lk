package lk.sliit.rentalx.rentalx.util;

import lk.sliit.rentalx.rentalx.util.FileStorageUtil;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.IOException;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initializing RentalX application...");
        // Initialize the file storage
        try {
            FileStorageUtil.init(sce.getServletContext());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
        System.out.println("Shutting down RentalX application...");
    }
}