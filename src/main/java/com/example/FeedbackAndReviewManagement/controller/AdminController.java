package com.example.FeedbackAndReviewManagement.controller;

import com.example.FeedbackAndReviewManagement.entity.Review;
import com.example.FeedbackAndReviewManagement.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/reviews")
public class AdminController {
    private final FeedbackService feedbackService;

    @Autowired
    public AdminController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    @GetMapping
    public String showAdminPanel(Model model) { //Displays all reviews for admin moderation
        try {
            List<Review> reviews = feedbackService.getAllReviews();
            model.addAttribute("reviews", reviews);
            return "feedback/admin-moderation";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Failed to load reviews. Please try again.");
            return "feedback/admin-moderation";
        }
    }

    @PostMapping("/verify/{id}")
    public String verifyReview( //Toggles verification status of a review
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {
        try {
            Review review = feedbackService.getReviewById(id);
            if (review == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Review not found.");
                return "redirect:/admin/reviews";
            }

            review.setVerified(!review.isVerified());
            feedbackService.update(review);
            
            String message = review.isVerified() ? "Review verified successfully." : "Review unverified successfully.";
            redirectAttributes.addFlashAttribute("successMessage", message);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update review verification status.");
        }
        return "redirect:/admin/reviews";
    }

    @PostMapping("/delete/{id}")
    public String deleteReview(  //Deletes a review
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {
        try {
            feedbackService.deleteReview(id);
            redirectAttributes.addFlashAttribute("successMessage", "Review deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete review.");
        }
        return "redirect:/admin/reviews";
    }

    @GetMapping("/filter")
    public String filterReviews(  //Filter reviews by rating,date,verification status
            @RequestParam(required = false) String rating,
            @RequestParam(required = false) String dateFilter,
            @RequestParam(required = false) String status,
            Model model) {
        try {
            List<Review> reviews = feedbackService.getAllReviews();

            // Apply rating filter
            if (rating != null && !rating.isEmpty()) {
                int ratingValue = Integer.parseInt(rating);
                reviews = reviews.stream()
                    .filter(review -> review.getRating() == ratingValue)
                    .collect(Collectors.toList());
            }

            // Apply date filter
            if (dateFilter != null && !dateFilter.isEmpty()) {
                int days = Integer.parseInt(dateFilter);
                reviews = feedbackService.getRecentReviews(days);
            }

            // Apply verification status filter
            if (status != null && !status.isEmpty()) {
                boolean verified = "verified".equals(status);
                reviews = reviews.stream()
                    .filter(review -> review.isVerified() == verified)
                    .collect(Collectors.toList());
            }

            model.addAttribute("reviews", reviews);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Failed to apply filters. Please try again.");
        }
        return "feedback/admin-moderation";
    }
} 