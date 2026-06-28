package com.example;

import java.util.Date;

public class Transaction {
    private final String id;
    private final String fromAccount;
    private final String toAccount;
    private final double amount;
    private final Date timestamp;
    private final String status;

    public Transaction(String id, String fromAccount, String toAccount, double amount, String status) {
        this.id = id;
        this.fromAccount = fromAccount;
        this.toAccount = toAccount;
        this.amount = amount;
        this.timestamp = new Date();
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public String getFromAccount() {
        return fromAccount;
    }

    public String getToAccount() {
        return toAccount;
    }

    public double getAmount() {
        return amount;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public String getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "id='" + id + '\'' +
                ", fromAccount='" + fromAccount + '\'' +
                ", toAccount='" + toAccount + '\'' +
                ", amount=" + amount +
                ", timestamp=" + timestamp +
                ", status='" + status + '\'' +
                '}';
    }
}
