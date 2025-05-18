package com.example.vehiclerentalservice.model;

public class TechnicalIssue extends Ticket {
    public TechnicalIssue() {
        setTicketType("Technical");
    }

    public TechnicalIssue(Long id, String description) {
        super(id, description, "Technical");
    }
}