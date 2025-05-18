package com.example.vehiclerentalservice.service;

import com.example.vehiclerentalservice.model.RentalTransaction;
import com.example.vehiclerentalservice.util.CustomLinkedList;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RentalService {
    private CustomLinkedList rentals;

    public RentalService() {
        this.rentals = new CustomLinkedList();
    }

    public void createRental(RentalTransaction rental) {
        rental.setId(rentals.generateId());
        rentals.add(rental);
    }
    public void updateRental(RentalTransaction updatedRental) {
        rentals.update(updatedRental);
    }

    public List<RentalTransaction> getAllRentals() {
        return rentals.getAll();
    }

    public Optional<RentalTransaction> getRentalById(Long id) {
        RentalTransaction rental = rentals.getById(id);
        return Optional.ofNullable(rental);
    }

    public void deleteRental(Long id) {
        rentals.delete(id);
    }
}