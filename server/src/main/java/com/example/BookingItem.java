package com.example;

public class BookingItem {

    private int elementID;
    private int clientID;
    private double amount;

    public BookingItem() {
    }

    public String someGreeting(String name){
        return String.format("Hi, %s!", name);
    }

    public BookingItem(int elementID, int clientID, double amount) {
        this.elementID = elementID;
        this.clientID = clientID;
        this.amount = amount;
    }

    public int getElementID() {
        return elementID;
    }

    public void setElementID(int elementID) {
        this.elementID = elementID;
    }

    public int getClientID() {
        return clientID;
    }

    public void setClientID(int clientID) {
        this.clientID = clientID;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
