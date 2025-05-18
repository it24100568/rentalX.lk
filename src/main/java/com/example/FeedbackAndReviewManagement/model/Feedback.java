package com.example.FeedbackAndReviewManagement.model;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Feedback {
    private Long id;
    private String customerName;
    private String vehicleType;
    private String comment;
    private int rating;
    private LocalDateTime submissionDate;
    
    // Constructor with fields
    public Feedback(Long id, String customerName, String vehicleType, String comment, int rating) {
        this.id = id;
        this.customerName = customerName;
        this.vehicleType = vehicleType;
        this.comment = comment;
        this.rating = rating;
        this.submissionDate = LocalDateTime.now();
    }
    
    // Default constructor
    public Feedback() {
        this.submissionDate = LocalDateTime.now();
    }
} 