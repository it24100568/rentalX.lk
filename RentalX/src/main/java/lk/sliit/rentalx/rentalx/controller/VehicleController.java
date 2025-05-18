package com.example.vehiclerentalservice.controller;

import com.example.vehiclerentalservice.model.Car;
import com.example.vehiclerentalservice.model.Vehicle;
import com.example.vehiclerentalservice.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/vehicles")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("vehicle", new Car());
        return "vehiclecreate";
    }

    @PostMapping("/create")
    public String createVehicle(@ModelAttribute Car vehicle, RedirectAttributes redirectAttributes) {
        try {
            if (vehicle.getType() == null || vehicle.getType().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Vehicle type is required.");
                return "redirect:/vehicles/create";
            }
            Vehicle newVehicle = vehicleService.createVehicleWithType(vehicle.getModel(), vehicle.getType(), vehicle.getPrice(), vehicle.isAvailable());
            vehicleService.createVehicleWithType(newVehicle);
            return "redirect:/vehicles";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating vehicle: " + e.getMessage());
            return "redirect:/vehicles/create";
        }
    }

    @GetMapping
    public String listVehicles(Model model, @RequestParam(value = "sort", required = false) String sort) {
        model.addAttribute("vehicles", vehicleService.sortVehiclesBy(sort));
        model.addAttribute("currentSort", sort); // Pass the current sort criterion to the template
        return "vehiclelist";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        return vehicleService.getVehicleById(id)
                .map(vehicle -> {
                    model.addAttribute("vehicle", vehicle);
                    return "vehicleupdate";
                })
                .orElseGet(() -> {
                    redirectAttributes.addFlashAttribute("error", "Vehicle not found with ID: " + id);
                    return "redirect:/vehicles";
                });
    }

    @PostMapping("/update")
    public String updateVehicle(@ModelAttribute Car vehicle, RedirectAttributes redirectAttributes) {
        try {
            if (vehicle.getId() == null) {
                redirectAttributes.addFlashAttribute("error", "Vehicle ID is required for update.");
                return "redirect:/vehicles";
            }
            if (vehicle.getType() == null || vehicle.getType().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Vehicle type is required.");
                return "redirect:/vehicles/update/" + vehicle.getId();
            }
            Vehicle updatedVehicle = vehicleService.createVehicleWithType(vehicle.getModel(), vehicle.getType(), vehicle.getPrice(), vehicle.isAvailable());
            updatedVehicle.setId(vehicle.getId());
            vehicleService.updateVehicleWithType(updatedVehicle);
            return "redirect:/vehicles";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating vehicle: " + e.getMessage());
            return "redirect:/vehicles/update/" + vehicle.getId();
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteVehicle(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            vehicleService.deleteVehicle(id);
            return "redirect:/vehicles";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting vehicle: " + e.getMessage());
            return "redirect:/vehicles";
        }
    }
}