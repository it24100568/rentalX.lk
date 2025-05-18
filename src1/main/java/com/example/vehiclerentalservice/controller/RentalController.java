package com.example.vehiclerentalservice.controller;

import com.example.vehiclerentalservice.model.RentalTransaction;
import com.example.vehiclerentalservice.model.Vehicle;
import com.example.vehiclerentalservice.service.RentalService;
import com.example.vehiclerentalservice.service.VehicleService;
import com.example.vehiclerentalservice.util.CustomLinkedList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/rentals")
public class RentalController {

    @Autowired
    private RentalService rentalService;

    @Autowired
    private VehicleService vehicleService;

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("rental", new RentalTransaction());
        model.addAttribute("vehicles", vehicleService.getAllVehicles());
        return "rentalcreate";
    }

    @PostMapping("/create")
    public String createRental(@ModelAttribute RentalTransaction rental, RedirectAttributes redirectAttributes) {
        try {
            // Debug output
            System.out.println("Received rental: " + rental.getVehicleId() + ", " + rental.getCustomerName() + ", " +
                    rental.getStartDate() + ", " + rental.getEndDate() + ", " + rental.getRentalType());

            if (rental.getVehicleId() == null || rental.getCustomerName() == null || rental.getCustomerName().trim().isEmpty() ||
                    rental.getStartDate() == null || rental.getEndDate() == null || rental.getRentalType() == null ||
                    !rental.getRentalType().matches("(?i)hourly|daily|weekly")) {
                redirectAttributes.addFlashAttribute("error", "All fields are required, and rental type must be hourly, daily, or weekly.");
                return "redirect:/rentals/create";
            }

            // Normalize dates
            rental.setStartDate(rental.getStartDate().withSecond(0).withNano(0));
            rental.setEndDate(rental.getEndDate().withSecond(0).withNano(0));

            if (rental.getStartDate().isAfter(rental.getEndDate())) {
                redirectAttributes.addFlashAttribute("error", "Start date must be before end date.");
                return "redirect:/rentals/create";
            }

            Vehicle vehicle = vehicleService.getVehicleById(rental.getVehicleId())
                    .orElseThrow(() -> new IllegalArgumentException("Vehicle not found with ID: " + rental.getVehicleId()));
            long duration = rental.calculateDuration();
            double basePrice = vehicle.calculateRentalPrice(1); // Price per unit (hour/day/week)
            switch (rental.getRentalType().toLowerCase()) {
                case "hourly":
                    rental.setTotalFee(basePrice * duration);
                    break;
                case "daily":
                    rental.setTotalFee(basePrice * duration);
                    break;
                case "weekly":
                    rental.setTotalFee(basePrice * duration * 7); // Weekly price adjusted
                    break;
            }
            rental.setReturnDate(null); // Set to null on creation
            rental.setStatus("active"); // Default status
            rentalService.createRental(rental);
            return "redirect:/rentals";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating rental: " + e.getMessage());
            return "redirect:/rentals/create";
        }
    }

    @GetMapping
    public String listRentals(Model model) {
        List<RentalTransaction> rentals = rentalService.getAllRentals();
        model.addAttribute("rentals", rentals);
        return "rentallist";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        return rentalService.getRentalById(id)
                .map(rental -> {
                    model.addAttribute("rental", rental);
                    model.addAttribute("vehicles", vehicleService.getAllVehicles());
                    return "rentalupdate";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Rental not found with ID: " + id);
                    return "redirect:/rentals";
                });
    }

    @PostMapping("/update")
    public String updateRental(@ModelAttribute RentalTransaction rental, RedirectAttributes redirectAttributes) {
        try {
            if (rental.getId() == null) {
                redirectAttributes.addFlashAttribute("error", "Rental ID is required for update.");
                return "redirect:/rentals";
            }
            Vehicle vehicle = vehicleService.getVehicleById(rental.getVehicleId())
                    .orElseThrow(() -> new IllegalArgumentException("Vehicle not found with ID: " + rental.getVehicleId()));
            long duration = rental.calculateDuration();
            double basePrice = vehicle.calculateRentalPrice(1); // Price per unit
            switch (rental.getRentalType().toLowerCase()) {
                case "hourly":
                    rental.setTotalFee(basePrice * duration);
                    break;
                case "daily":
                    rental.setTotalFee(basePrice * duration);
                    break;
                case "weekly":
                    rental.setTotalFee(basePrice * duration * 7); // Weekly price adjusted
                    break;
            }
            rentalService.updateRental(rental);
            return "redirect:/rentals";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating rental: " + e.getMessage());
            return "redirect:/rentals/update/" + rental.getId();
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteRental(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            rentalService.deleteRental(id);
            return "redirect:/rentals";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting rental: " + e.getMessage());
            return "redirect:/rentals";
        }
    }
}