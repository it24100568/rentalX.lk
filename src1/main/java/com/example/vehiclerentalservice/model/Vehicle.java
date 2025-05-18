package com.example.vehiclerentalservice.model;

import java.util.Objects;

public abstract class Vehicle {
    private Long id;
    private String model;
    private String type;
    private double price;
    private boolean available;

    public Vehicle() {
    }

    public Vehicle(Long id, String model, String type, double price, boolean available) {
        this.id = id;
        this.model = model;
        this.type = type;
        this.price = price;
        this.available = available;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public abstract double calculateRentalPrice(int days);

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vehicle vehicle = (Vehicle) o;
        return Double.compare(vehicle.price, price) == 0 && available == vehicle.available && Objects.equals(id, vehicle.id) && Objects.equals(model, vehicle.model) && Objects.equals(type, vehicle.type);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, model, type, price, available);
    }
}