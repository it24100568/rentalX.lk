package com.example.vehiclerentalservice.model;

public class PaymentIssue extends Ticket {
    public PaymentIssue() {
        setTicketType("Payment");
    }

    public PaymentIssue(Long id, String description) {
        super(id, description, "Payment");
    }
}