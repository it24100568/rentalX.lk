package com.example.FeedbackAndReviewManagement.repository;

import com.example.FeedbackAndReviewManagement.entity.Review;
import java.util.List;

public interface FeedbackRepository {
    Review save(Review review);
    Review findById(Long id);
    List<Review> findAll();
    List<Review> findByVehicleId(String vehicleId);
    List<Review> findByUserId(String userId);
    List<Review> findByRating(int rating);
    List<Review> findVerifiedReviews();
    void delete(Long id);
    void update(Review review);
} 