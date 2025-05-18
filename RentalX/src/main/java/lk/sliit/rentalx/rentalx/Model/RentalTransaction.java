package com.example.vehiclerentalservice.model;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Objects;

public class RentalTransaction {
    private Long id;
    private Long vehicleId;
    private String customerName;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private LocalDateTime returnDate; // Null if not returned
    private String rentalType; // "hourly", "daily", "weekly"
    private String status; // "active", "completed", "late"
    private double totalFee;

    public RentalTransaction() {
    }

    public RentalTransaction(Long id, Long vehicleId, String customerName, LocalDateTime startDate, LocalDateTime endDate, LocalDateTime returnDate, String rentalType, String status, double totalFee) {
        this.id = id;
        this.vehicleId = vehicleId;
        this.customerName = customerName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.returnDate = returnDate;
        this.rentalType = rentalType;
        this.status = status;
        this.totalFee = totalFee;
    }

    public RentalTransaction(Long id, Long vehicleId, String customerName, LocalDateTime startDate, LocalDateTime endDate, String rentalType, String status, double totalFee) {
        this(id, vehicleId, customerName, startDate, endDate, null, rentalType, status, totalFee);
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Long vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public LocalDateTime getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDateTime returnDate) {
        this.returnDate = returnDate;
    }

    public String getRentalType() {
        return rentalType;
    }

    public void setRentalType(String rentalType) {
        this.rentalType = rentalType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(double totalFee) {
        this.totalFee = totalFee;
    }

    // Polymorphic method to calculate duration based on rental type
    public long calculateDuration() {
        LocalDateTime end = (returnDate != null) ? returnDate : LocalDateTime.now();
        switch (rentalType.toLowerCase()) {
            case "hourly":
                return ChronoUnit.HOURS.between(startDate, end);
            case "daily":
                return ChronoUnit.DAYS.between(startDate, end);
            case "weekly":
                return ChronoUnit.WEEKS.between(startDate, end);
            default:
                throw new IllegalArgumentException("Invalid rental type: " + rentalType);
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RentalTransaction that = (RentalTransaction) o;
        return Double.compare(that.totalFee, totalFee) == 0 &&
                Objects.equals(id, that.id) &&
                Objects.equals(vehicleId, that.vehicleId) &&
                Objects.equals(customerName, that.customerName) &&
                Objects.equals(startDate, that.startDate) &&
                Objects.equals(endDate, that.endDate) &&
                Objects.equals(returnDate, that.returnDate) &&
                Objects.equals(rentalType, that.rentalType) &&
                Objects.equals(status, that.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, vehicleId, customerName, startDate, endDate, returnDate, rentalType, status, totalFee);
    }
}