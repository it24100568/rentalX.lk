package com.example.FeedbackAndReviewManagement.entity;

import java.time.LocalDateTime;

public class VerifiedReview extends Review {
    private String verifiedBy;
    private LocalDateTime verificationDate;
    private String verificationNotes;

    public VerifiedReview() {
        super();
        setVerified(true);
    }

    public VerifiedReview(String vehicleId, String userId, String userName, int rating, String comment,
                         String verifiedBy, String verificationNotes) {
        super(vehicleId, userId, userName, rating, comment);
        this.verifiedBy = verifiedBy;
        this.verificationDate = LocalDateTime.now();
        this.verificationNotes = verificationNotes;
        setVerified(true);
    }

    public String getVerifiedBy() {
        return verifiedBy;
    }

    public void setVerifiedBy(String verifiedBy) {
        this.verifiedBy = verifiedBy;
    }

    public LocalDateTime getVerificationDate() {
        return verificationDate;
    }

    public void setVerificationDate(LocalDateTime verificationDate) {
        this.verificationDate = verificationDate;
    }

    public String getVerificationNotes() {
        return verificationNotes;
    }

    public void setVerificationNotes(String verificationNotes) {
        this.verificationNotes = verificationNotes;
    }
} 