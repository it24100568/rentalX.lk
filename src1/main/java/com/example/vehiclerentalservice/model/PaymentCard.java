package com.example.vehiclerentalservice.model;

public class PaymentCard {
    private Long id;
    private String cardNumber;
    private String holderName;
    private String expiryDate; // Format: MM/YY
    private String cvv;
    private boolean isDefault;

    public PaymentCard() {}

    public PaymentCard(Long id, String cardNumber, String holderName, String expiryDate, String cvv, boolean isDefault) {
        this.id = id;
        this.cardNumber = cardNumber;
        this.holderName = holderName;
        this.expiryDate = expiryDate;
        this.cvv = cvv;
        this.isDefault = isDefault;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }
    public String getHolderName() { return holderName; }
    public void setHolderName(String holderName) { this.holderName = holderName; }
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }
    public String getCvv() { return cvv; }
    public void setCvv(String cvv) { this.cvv = cvv; }
    public boolean getIsDefault() { return isDefault; }
    public void setIsDefault(boolean isDefault) { this.isDefault = isDefault; }
}