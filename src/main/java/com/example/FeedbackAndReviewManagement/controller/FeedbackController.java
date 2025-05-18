package com.example.FeedbackAndReviewManagement.controller;

import com.example.FeedbackAndReviewManagement.entity.Review;
import com.example.FeedbackAndReviewManagement.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.validation.Valid;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/reviews")
public class FeedbackController {
    private static final String VIEW_REVIEWS_PAGE = "feedback/view-reviews";
    private static final String SUBMIT_FORM_PAGE = "feedback/form";
    
    private final FeedbackService feedbackService;

    @Autowired
    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    @GetMapping
    public String listReviews(Model model) {  //Shows all reviews
        try {
            List<Review> reviews = feedbackService.getAllReviews();
            model.addAttribute("reviews", reviews);
            return VIEW_REVIEWS_PAGE;
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Failed to load reviews. Please try again.");
            return VIEW_REVIEWS_PAGE;
        }
    }

    @GetMapping("/submit")
    public String showSubmitReviewForm(Model model) {
        if (!model.containsAttribute("feedback")) {
            model.addAttribute("feedback", new Review());
        }
        return SUBMIT_FORM_PAGE;
    }

    @PostMapping("/submit")
    public String submitReview(  //Handles review submission with validation
            @Valid @ModelAttribute("feedback") Review review,
            BindingResult result,
            RedirectAttributes redirectAttributes) {
        
        if (result.hasErrors()) {
            redirectAttributes.addFlashAttribute("feedback", review);
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.feedback", result);
            return "redirect:/reviews/submit";
        }

        try {
            review.setReviewDate(new Date());
            feedbackService.submitReview(review);
            redirectAttributes.addFlashAttribute("successMessage", "Thank you! Your review has been submitted successfully.");
            return "redirect:/reviews";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("feedback", review);
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to submit review. Please try again.");
            return "redirect:/reviews/submit";
        }
    }

    @PostMapping("/update")
    public String updateReview(
            @ModelAttribute Review review,
            RedirectAttributes redirectAttributes) {
        try {
            Review existingReview = feedbackService.getReviewById(review.getId());
            if (existingReview == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Review not found.");
                return "redirect:/reviews";
            }

            // Preserve the original review date
            review.setReviewDate(existingReview.getReviewDate());
            
            feedbackService.update(review);
            redirectAttributes.addFlashAttribute("successMessage", "Review updated successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update review. Please try again.");
        }
        return "redirect:/reviews";
    }

    @GetMapping("/search")
    public String searchReviews(  //Searches reviews by vehicle
            @RequestParam(required = false) String query,
            Model model) {
        try {
            List<Review> searchResults;
            if (query != null && !query.trim().isEmpty()) {
                searchResults = feedbackService.getReviewsByVehicle(query);
                model.addAttribute("searchQuery", query);
            } else {
                searchResults = feedbackService.getAllReviews();
            }
            model.addAttribute("reviews", searchResults);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Failed to search reviews. Please try again.");
        }
        return VIEW_REVIEWS_PAGE;
    }

    @GetMapping("/edit/{id}")  //Displays edit form for a review
    public String showEditForm(@PathVariable Long id, Model model) {
        try {
            Review review = feedbackService.getReviewById(id);
            if (review != null) {
                model.addAttribute("feedback", review);
                return SUBMIT_FORM_PAGE;
            }
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Failed to load review for editing. Please try again.");
        }
        return "redirect:/reviews";
    }

    @PostMapping("/delete/{id}")
    public String deleteReview(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {
        try {
            feedbackService.deleteReview(id);
            redirectAttributes.addFlashAttribute("successMessage", "Review has been deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete review. Please try again.");
        }
        return "redirect:/reviews";
    }
} 