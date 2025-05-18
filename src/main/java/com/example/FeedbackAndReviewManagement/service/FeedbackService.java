package com.example.FeedbackAndReviewManagement.service;

import com.example.FeedbackAndReviewManagement.entity.Review;
import com.example.FeedbackAndReviewManagement.entity.VerifiedReview;
import com.example.FeedbackAndReviewManagement.repository.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class FeedbackService {
    private final FeedbackRepository repository;

    @Autowired
    public FeedbackService(FeedbackRepository repository) {
        this.repository = repository;
    }

    public Review submitReview(Review review) {
        return repository.save(review);
    }

    public List<Review> getAllReviews() {
        return repository.findAll();
    }

    public List<Review> getReviewsByVehicle(String vehicleId) {
        return repository.findByVehicleId(vehicleId);
    }

    public Review getReviewById(Long id) {
        return repository.findById(id);
    }

    public void deleteReview(Long id) {
        repository.delete(id);
    }

    public Review update(Review review) {
        Review existingReview = repository.findById(review.getId());
        if (existingReview == null) {
            throw new RuntimeException("Review not found");
        }
        repository.update(review);
        return review;
    }

    public Review verifyReview(Long reviewId, String adminId, String notes) {
        Review review = repository.findById(reviewId);
        if (review == null) {
            throw new RuntimeException("Review not found");
        }

        VerifiedReview verifiedReview = new VerifiedReview(
            review.getVehicleId(),
            review.getUserId(),
            review.getUserName(),
            review.getRating(),
            review.getComment(),
            adminId,
            notes
        );
        verifiedReview.setId(review.getId());
        verifiedReview.setReviewDate(review.getReviewDate());
        
        repository.update(verifiedReview);
        return verifiedReview;
    }

    public List<Review> getRecentReviews(int days) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -days);
        Date cutoffDate = cal.getTime();
        
        return repository.findAll().stream()
                .filter(review -> review.getReviewDate().after(cutoffDate))
                .collect(Collectors.toList());
    }

    public List<Review> getReviewsByRatingRange(int minRating, int maxRating) {
        return repository.findAll().stream()
                .filter(review -> review.getRating() >= minRating && review.getRating() <= maxRating)
                .collect(Collectors.toList());
    }

    public List<Review> getVerifiedReviews() {
        return repository.findVerifiedReviews();
    }

    public List<Review> getUserReviews(String userId) {
        return repository.findByUserId(userId);
    }
} 