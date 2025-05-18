package com.example.vehiclerentalservice.model;

public abstract class Ticket {
    private Long id;
    private String description;
    private String ticketType;

    public Ticket() {}

    public Ticket(Long id, String description, String ticketType) {
        this.id = id;
        this.description = description;
        this.ticketType = ticketType;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getTicketType() { return ticketType; }
    public void setTicketType(String ticketType) { this.ticketType = ticketType; }
}