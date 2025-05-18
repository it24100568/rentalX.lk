package com.example.vehiclerentalservice.util;

import com.example.vehiclerentalservice.model.RentalTransaction;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class CustomLinkedList implements Iterable<RentalTransaction> {
    private Node head;
    private int size;

    // Node class for the linked list
    private class Node {
        RentalTransaction data;
        Node next;

        Node(RentalTransaction data) {
            this.data = data;
            this.next = null;
        }
    }

    public CustomLinkedList() {
        this.head = null;
        this.size = 0;
    }

    // Add a new rental transaction
    public void add(RentalTransaction rental) {
        Node newNode = new Node(rental);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
        size++;
    }

    // Update a rental transaction by ID
    public void update(RentalTransaction updatedRental) {
        Node current = head;
        while (current != null) {
            if (current.data.getId().equals(updatedRental.getId())) {
                current.data = updatedRental;
                return;
            }
            current = current.next;
        }
        throw new IllegalArgumentException("Rental with ID " + updatedRental.getId() + " not found.");
    }

    // Get all rental transactions as a List
    public List<RentalTransaction> getAll() {
        List<RentalTransaction> result = new ArrayList<>();
        Node current = head;
        while (current != null) {
            result.add(current.data);
            current = current.next;
        }
        return result;
    }

    // Get rental transaction by ID
    public RentalTransaction getById(Long id) {
        Node current = head;
        while (current != null) {
            if (current.data.getId().equals(id)) {
                return current.data;
            }
            current = current.next;
        }
        return null;
    }

    // Delete rental transaction by ID
    public void delete(Long id) {
        if (head == null) return;

        if (head.data.getId().equals(id)) {
            head = head.next;
            size--;
            return;
        }

        Node current = head;
        while (current.next != null) {
            if (current.next.data.getId().equals(id)) {
                current.next = current.next.next;
                size--;
                return;
            }
            current = current.next;
        }
    }

    // Generate a new ID (assuming IDs are sequential)
    public Long generateId() {
        if (head == null) return 1L;
        Long maxId = head.data.getId();
        Node current = head.next;
        while (current != null) {
            if (current.data.getId() > maxId) {
                maxId = current.data.getId();
            }
            current = current.next;
        }
        return maxId + 1;
    }

    // Get size of the linked list
    public int size() {
        return size;
    }

    @Override
    public Iterator<RentalTransaction> iterator() {
        return new Iterator<RentalTransaction>() {
            private Node current = head;

            @Override
            public boolean hasNext() {
                return current != null;
            }

            @Override
            public RentalTransaction next() {
                if (!hasNext()) {
                    throw new IllegalStateException("No more elements in the list");
                }
                RentalTransaction data = current.data;
                current = current.next;
                return data;
            }
        };
    }
}