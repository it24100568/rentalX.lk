package com.example.vehiclerentalservice.service;

import com.example.vehiclerentalservice.model.PaymentCard;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class PaymentService {
    private final String filePath = "src/main/resources/data/paymentcards.txt";

    public PaymentService() {
        File file = new File(filePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void addPaymentCard(PaymentCard card) {
        List<PaymentCard> cards = getAllPaymentCards();
        card.setId(generateId(cards));
        cards.add(card);
        savePaymentCards(cards);
    }

    public List<PaymentCard> getAllPaymentCards() {
        List<PaymentCard> cards = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 6) {
                    cards.add(new PaymentCard(
                            Long.parseLong(data[0]),
                            data[1],
                            data[2],
                            data[3],
                            data[4],
                            Boolean.parseBoolean(data[5])
                    ));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return cards;
    }

    public Optional<PaymentCard> getPaymentCardById(Long id) {
        return getAllPaymentCards().stream()
                .filter(card -> card.getId().equals(id))
                .findFirst();
    }

    public void updatePaymentCard(PaymentCard updatedCard) {
        List<PaymentCard> cards = getAllPaymentCards();
        cards.removeIf(card -> card.getId().equals(updatedCard.getId()));
        cards.add(updatedCard);
        savePaymentCards(cards);
    }

    public void deletePaymentCard(Long id) {
        List<PaymentCard> cards = getAllPaymentCards();
        cards.removeIf(card -> card.getId().equals(id));
        savePaymentCards(cards);
    }

    private void savePaymentCards(List<PaymentCard> cards) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (PaymentCard card : cards) {
                writer.write(card.getId() + "," + card.getCardNumber() + "," +
                        card.getHolderName() + "," + card.getExpiryDate() + "," +
                        card.getCvv() + "," + card.getIsDefault());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Long generateId(List<PaymentCard> cards) {
        return cards.stream().map(PaymentCard::getId).max(Long::compare).orElse(0L) + 1;
    }
}