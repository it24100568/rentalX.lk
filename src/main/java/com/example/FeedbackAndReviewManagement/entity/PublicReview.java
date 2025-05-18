package com.example.FeedbackAndReviewManagement.entity;

public class PublicReview extends Review {
    private boolean anonymous;

    public PublicReview() {
        super();
        this.anonymous = false;
    }

    public PublicReview(String vehicleId, String userId, String userName, int rating, String comment, boolean anonymous) {
        super(vehicleId, userId, userName, rating, comment);
        this.anonymous = anonymous;
    }

    public boolean isAnonymous() {
        return anonymous;
    }

    public void setAnonymous(boolean anonymous) {
        this.anonymous = anonymous;
    }

    @Override
    public String getUserName() {
        return isAnonymous() ? "Anonymous User" : super.getUserName();
    }
} 