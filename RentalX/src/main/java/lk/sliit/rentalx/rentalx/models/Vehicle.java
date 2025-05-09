package lk.sliit.rentalx.rentalx.models;


public class Vehicle {
    private String id;
    private String model;
    private String type;
    private double pricePerDay;
    private int year;
    private String color;
    private String licensePlate;
    private boolean available;

    // Constructors
    public Vehicle() {}

    public Vehicle(String model, String type, double pricePerDay, int year,
                   String color, String licensePlate) {
        this.model = model;
        this.type = type;
        this.pricePerDay = pricePerDay;
        this.year = year;
        this.color = color;
        this.licensePlate = licensePlate;
        this.available = true;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

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

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }


    // ... (other getters/setters)
}