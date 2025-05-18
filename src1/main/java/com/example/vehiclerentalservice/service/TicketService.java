package com.example.vehiclerentalservice.service;

import com.example.vehiclerentalservice.model.Ticket;
import com.example.vehiclerentalservice.model.TechnicalIssue;
import com.example.vehiclerentalservice.model.PaymentIssue;
import com.example.vehiclerentalservice.model.GeneralQuery;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TicketService {
    private final String filePath = "src/main/resources/data/tickets.txt";

    public TicketService() {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void addTicket(Ticket ticket) {
        List<Ticket> tickets = getAllTickets();
        ticket.setId(generateId(tickets));
        tickets.add(ticket);
        saveTickets(tickets);
    }

    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",", 3);
                if (data.length == 3) {
                    Long id = Long.parseLong(data[0]);
                    String ticketType = data[1];
                    String description = data[2];
                    Ticket ticket;
                    switch (ticketType) {
                        case "Technical":
                            ticket = new TechnicalIssue(id, description);
                            break;
                        case "Payment":
                            ticket = new PaymentIssue(id, description);
                            break;
                        case "Question":
                            ticket = new GeneralQuery(id, description);
                            break;
                        default:
                            continue;
                    }
                    tickets.add(ticket);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public Optional<Ticket> getTicketById(Long id) {
        return getAllTickets().stream()
                .filter(ticket -> ticket.getId().equals(id))
                .findFirst();
    }

    public void updateTicket(Ticket updatedTicket) {
        List<Ticket> tickets = getAllTickets();
        tickets.removeIf(ticket -> ticket.getId().equals(updatedTicket.getId()));
        tickets.add(updatedTicket);
        saveTickets(tickets);
    }

    public void deleteTicket(Long id) {
        List<Ticket> tickets = getAllTickets();
        tickets.removeIf(ticket -> ticket.getId().equals(id));
        saveTickets(tickets);
    }

    private void saveTickets(List<Ticket> tickets) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Ticket ticket : tickets) {
                writer.write(ticket.getId() + "," + ticket.getTicketType() + "," + ticket.getDescription());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Long generateId(List<Ticket> tickets) {
        return tickets.stream().map(Ticket::getId).max(Long::compare).orElse(0L) + 1;
    }
}