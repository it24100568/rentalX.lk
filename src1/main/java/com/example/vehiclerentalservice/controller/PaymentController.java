package com.example.vehiclerentalservice.controller;

import com.example.vehiclerentalservice.model.PaymentCard;
import com.example.vehiclerentalservice.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/payments")
public class PaymentController {
    @Autowired
    private PaymentService paymentService;

    @GetMapping
    public String listPaymentCards(Model model) {
        model.addAttribute("paymentCards", paymentService.getAllPaymentCards());
        return "paymentlist";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("paymentCard", new PaymentCard());
        return "paymentcreate";
    }

    @PostMapping("/create")
    public String createPaymentCard(@ModelAttribute PaymentCard paymentCard) {
        paymentService.addPaymentCard(paymentCard);
        return "redirect:/payments";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        PaymentCard paymentCard = paymentService.getPaymentCardById(id).orElseThrow(() -> new IllegalArgumentException("Invalid ID"));
        model.addAttribute("paymentCard", paymentCard);
        return "paymentupdate";
    }

    @PostMapping("/update")
    public String updatePaymentCard(@ModelAttribute PaymentCard paymentCard) {
        paymentService.updatePaymentCard(paymentCard);
        return "redirect:/payments";
    }

    @GetMapping("/delete/{id}")
    public String deletePaymentCard(@PathVariable Long id) {
        paymentService.deletePaymentCard(id);
        return "redirect:/payments";
    }
}