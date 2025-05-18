package com.example.vehiclerentalservice.controller;

import com.example.vehiclerentalservice.model.Ticket;
import com.example.vehiclerentalservice.model.TechnicalIssue;
import com.example.vehiclerentalservice.model.PaymentIssue;
import com.example.vehiclerentalservice.model.GeneralQuery;
import com.example.vehiclerentalservice.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tickets")
public class TicketController {
    @Autowired
    private TicketService ticketService;

    @GetMapping
    public String listTickets(Model model) {
        model.addAttribute("tickets", ticketService.getAllTickets());
        return "ticketlist";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("ticket", new TechnicalIssue()); // Default to TechnicalIssue for form binding
        return "ticketcreate";
    }

    @PostMapping("/create")
    public String createTicket(@RequestParam String ticketType, @RequestParam String description) {
        Ticket ticket;
        switch (ticketType) {
            case "Technical":
                ticket = new TechnicalIssue();
                break;
            case "Payment":
                ticket = new PaymentIssue();
                break;
            case "Question":
                ticket = new GeneralQuery();
                break;
            default:
                throw new IllegalArgumentException("Invalid ticket type");
        }
        ticket.setDescription(description);
        ticketService.addTicket(ticket);
        return "redirect:/tickets";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        Ticket ticket = ticketService.getTicketById(id).orElseThrow(() -> new IllegalArgumentException("Invalid ID"));
        model.addAttribute("ticket", ticket);
        return "ticketupdate";
    }

    @PostMapping("/update")
    public String updateTicket(@RequestParam Long id, @RequestParam String ticketType, @RequestParam String description) {
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
                throw new IllegalArgumentException("Invalid ticket type");
        }
        ticketService.updateTicket(ticket);
        return "redirect:/tickets";
    }

    @GetMapping("/delete/{id}")
    public String showDeleteForm(@PathVariable Long id, Model model) {
        Ticket ticket = ticketService.getTicketById(id).orElseThrow(() -> new IllegalArgumentException("Invalid ID"));
        model.addAttribute("ticket", ticket);
        return "ticketdelete";
    }

    @PostMapping("/delete/{id}")
    public String deleteTicket(@PathVariable Long id) {
        ticketService.deleteTicket(id);
        return "redirect:/tickets";
    }
}