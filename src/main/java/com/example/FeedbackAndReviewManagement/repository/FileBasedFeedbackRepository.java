package com.example.FeedbackAndReviewManagement.repository;

import com.example.FeedbackAndReviewManagement.entity.Review;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Repository
public class FileBasedFeedbackRepository implements FeedbackRepository {
    private static final String DATA_FILE = "src/main/resources/data/reviews.json";
    private final ObjectMapper objectMapper;
    private final AtomicLong idGenerator;

    public FileBasedFeedbackRepository() {
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
        this.objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        this.objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        this.objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        this.idGenerator = new AtomicLong(1);
        createDataFileIfNotExists();
    }

    private void createDataFileIfNotExists() {
        File dataFile = new File(DATA_FILE);
        if (!dataFile.exists()) {
            try {
                // Create parent directories if they don't exist
                File parentDir = dataFile.getParentFile();
                if (!parentDir.exists()) {
                    if (!parentDir.mkdirs()) {
                        throw new RuntimeException("Failed to create data directory: " + parentDir.getAbsolutePath());
                    }
                }
                
                // Create the file and write an empty array
                objectMapper.writeValue(dataFile, new ArrayList<Review>());
                
                // Set proper file permissions
                dataFile.setReadable(true, false);
                dataFile.setWritable(true, false);
            } catch (IOException e) {
                throw new RuntimeException("Failed to create or initialize data file: " + e.getMessage(), e);
            }
        }
    }

    @Override
    public Review save(Review review) {
        List<Review> reviews = readAllReviews();
        if (review.getId() == null) {
            review.setId(idGenerator.getAndIncrement());
        }
        reviews.add(review);
        writeReviews(reviews);
        return review;
    }

    @Override
    public Review findById(Long id) {
        return readAllReviews().stream()
                .filter(review -> review.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Review> findAll() {
        return readAllReviews();
    }

    @Override
    public List<Review> findByVehicleId(String vehicleId) {
        return readAllReviews().stream()
                .filter(review -> review.getVehicleId().equals(vehicleId))
                .collect(Collectors.toList());
    }

    @Override
    public List<Review> findByUserId(String userId) {
        return readAllReviews().stream()
                .filter(review -> review.getUserId().equals(userId))
                .collect(Collectors.toList());
    }

    @Override
    public List<Review> findByRating(int rating) {
        return readAllReviews().stream()
                .filter(review -> review.getRating() == rating)
                .collect(Collectors.toList());
    }

    @Override
    public List<Review> findVerifiedReviews() {
        return readAllReviews().stream()
                .filter(Review::isVerified)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(Long id) {
        List<Review> reviews = readAllReviews();
        reviews.removeIf(review -> review.getId().equals(id));
        writeReviews(reviews);
    }

    @Override
    public void update(Review updatedReview) {
        List<Review> reviews = readAllReviews();
        boolean found = false;
        
        for (int i = 0; i < reviews.size(); i++) {
            if (reviews.get(i).getId().equals(updatedReview.getId())) {
                reviews.set(i, updatedReview);
                found = true;
                break;
            }
        }
        
        if (!found) {
            throw new RuntimeException("Review not found with ID: " + updatedReview.getId());
        }
        
        writeReviews(reviews);
    }

    private List<Review> readAllReviews() {
        try {
            return objectMapper.readValue(new File(DATA_FILE),
                    objectMapper.getTypeFactory().constructCollectionType(List.class, Review.class));
        } catch (IOException e) {
            throw new RuntimeException("Failed to read reviews from file", e);
        }
    }

    private void writeReviews(List<Review> reviews) {
        try {
            objectMapper.writeValue(new File(DATA_FILE), reviews);
        } catch (IOException e) {
            throw new RuntimeException("Failed to write reviews to file", e);
        }
    }
} 