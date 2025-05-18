package com.example.vehiclerentalservice.model;

public class Truck extends Vehicle {
    public Truck() {
        super();
    }

    public Truck(Long id, String model, String type, double price, boolean available) {
        super(id, model, type, price, available);
    }

    @Override
    public double calculateRentalPrice(int days) {
        // Simple implementation: base price per day multiplied by number of days
        return getPrice() * days;
    }
}