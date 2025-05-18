package com.example.vehiclerentalservice.model;

public class GeneralQuery extends Ticket {
    public GeneralQuery() {
        setTicketType("Question");
    }

    public GeneralQuery(Long id, String description) {
        super(id, description, "Question");
    }
}