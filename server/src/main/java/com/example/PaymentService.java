package com.example;

import java.util.*;

public class PaymentService {
    private final Map<String, Double> accounts = new HashMap<>();
    private final List<Transaction> transactionHistory = new ArrayList<>();

    public PaymentService() {
        // Initialize with mock accounts for demo purposes
        accounts.put("ACC1001", 5000.0);
        accounts.put("ACC1002", 1500.0);
        accounts.put("ACC1003", 250.0);
    }

    public synchronized Transaction transfer(String fromAccount, String toAccount, double amount) throws PaymentException {
        if (fromAccount == null || fromAccount.trim().isEmpty()) {
            throw new PaymentException("Sender account is required.");
        }
        if (toAccount == null || toAccount.trim().isEmpty()) {
            throw new PaymentException("Recipient account is required.");
        }
        if (fromAccount.equals(toAccount)) {
            throw new PaymentException("Cannot transfer money to the same account.");
        }
        if (amount <= 0) {
            throw new PaymentException("Transfer amount must be greater than zero.");
        }

        Double senderBalance = accounts.get(fromAccount);
        if (senderBalance == null) {
            throw new PaymentException("Sender account not found.");
        }

        Double recipientBalance = accounts.get(toAccount);
        if (recipientBalance == null) {
            throw new PaymentException("Recipient account not found.");
        }

        if (senderBalance < amount) {
            throw new PaymentException("Insufficient funds. Available balance: $" + senderBalance);
        }

        // Perform the transfer
        accounts.put(fromAccount, senderBalance - amount);
        accounts.put(toAccount, recipientBalance + amount);

        // Record the transaction
        String txId = UUID.randomUUID().toString();
        Transaction tx = new Transaction(txId, fromAccount, toAccount, amount, "SUCCESS");
        transactionHistory.add(tx);

        return tx;
    }

    public Double getBalance(String accountNum) {
        return accounts.get(accountNum);
    }

    public List<Transaction> getTransactionHistory() {
        return Collections.unmodifiableList(transactionHistory);
    }
}
