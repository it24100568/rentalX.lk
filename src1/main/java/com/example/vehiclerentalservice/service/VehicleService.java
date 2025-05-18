package com.example.vehiclerentalservice.service;

import com.example.vehiclerentalservice.model.*;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class VehicleService {
    private static final String FILE_PATH = "src/main/resources/data/vehicles.txt";

    public VehicleService() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void createVehicleWithType(Vehicle vehicle) {
        List<Vehicle> vehicles = getAllVehicles();
        vehicle.setId(generateId(vehicles));
        vehicles.add(vehicle);
        saveVehicles(vehicles);
    }

    public Vehicle createVehicleWithType(String model, String type, double price, boolean available) {
        return createVehicleInstance(model, type, price, available);
    }

    public void updateVehicleWithType(Vehicle updatedVehicle) {
        List<Vehicle> vehicles = getAllVehicles();
        vehicles.removeIf(v -> v.getId().equals(updatedVehicle.getId()));
        vehicles.add(updatedVehicle);
        saveVehicles(vehicles);
    }

    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 5) {
                    Vehicle vehicle = createVehicleFromData(data);
                    vehicles.add(vehicle);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    public List<Vehicle> sortVehiclesBy(String criterion) {
        List<Vehicle> vehicles = getAllVehicles();
        if (criterion == null || criterion.isEmpty()) {
            return vehicles; // No sorting
        }
        switch (criterion.toLowerCase()) {
            case "availability":
                selectionSortByAvailability(vehicles);
                break;
            case "price":
                selectionSortByPrice(vehicles);
                break;
            default:
                // No sorting if criterion is invalid
                break;
        }
        return vehicles;
    }

    // Custom selection sort by availability (true first, false last)
    private void selectionSortByAvailability(List<Vehicle> vehicles) {
        int n = vehicles.size();
        for (int i = 0; i < n - 1; i++) {
            int maxIndex = i;
            for (int j = i + 1; j < n; j++) {
                // Compare availability: true > false
                if (vehicles.get(j).isAvailable() && !vehicles.get(maxIndex).isAvailable()) {
                    maxIndex = j;
                }
            }
            // Swap if necessary
            if (maxIndex != i) {
                Vehicle temp = vehicles.get(i);
                vehicles.set(i, vehicles.get(maxIndex));
                vehicles.set(maxIndex, temp);
            }
        }
    }

    // Custom selection sort by price (ascending)
    private void selectionSortByPrice(List<Vehicle> vehicles) {
        int n = vehicles.size();
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n; j++) {
                if (vehicles.get(j).getPrice() < vehicles.get(minIndex).getPrice()) {
                    minIndex = j;
                }
            }
            // Swap if necessary
            if (minIndex != i) {
                Vehicle temp = vehicles.get(i);
                vehicles.set(i, vehicles.get(minIndex));
                vehicles.set(minIndex, temp);
            }
        }
    }

    public Optional<Vehicle> getVehicleById(Long id) {
        return getAllVehicles().stream()
                .filter(v -> v.getId().equals(id))
                .findFirst();
    }

    public void deleteVehicle(Long id) {
        List<Vehicle> vehicles = getAllVehicles();
        vehicles.removeIf(v -> v.getId().equals(id));
        saveVehicles(vehicles);
    }

    private void saveVehicles(List<Vehicle> vehicles) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Vehicle vehicle : vehicles) {
                writer.write(String.format("%d,%s,%s,%.2f,%b", vehicle.getId(), vehicle.getModel(),
                        vehicle.getType(), vehicle.getPrice(), vehicle.isAvailable()));
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Long generateId(List<Vehicle> vehicles) {
        return vehicles.stream().map(Vehicle::getId).max(Long::compare).orElse(0L) + 1;
    }

    private Vehicle createVehicleFromData(String[] data) {
        Long id = Long.parseLong(data[0]);
        String model = data[1];
        String type = data[2];
        double price = Double.parseDouble(data[3]);
        boolean available = Boolean.parseBoolean(data[4]);

        Vehicle vehicle = createVehicleInstance(model, type, price, available);
        vehicle.setId(id);
        return vehicle;
    }

    private Vehicle createVehicleInstance(String model, String type, double price, boolean available) {
        switch (type.toLowerCase()) {
            case "car":
                return new Car(null, model, "Car", price, available);
            case "bike":
                return new Bike(null, model, "Bike", price, available);
            case "truck":
                return new Truck(null, model, "Truck", price, available);
            default:
                throw new IllegalArgumentTypeException("Unknown vehicle type: " + type);
        }
    }
}

class IllegalArgumentTypeException extends RuntimeException {
    public IllegalArgumentTypeException(String message) {
        super(message);
    }
}