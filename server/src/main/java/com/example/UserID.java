package com.example;

import java.util.UUID;

public class UserID {

    private static int numberID;
    private static double UIDD;
    private static String firstname;
    private static String lastname;

    public UserID() {
    }

    public static int getNumberID() {
        return numberID;
    }

    public static void setNumberID(int numberID) {
        UserID.numberID = numberID;
    }

    public static double getUIDD() {
        return UIDD;
    }

    public static void setUIDD(double UIDD) {
        UserID.UIDD = UIDD;
    }

    public static String getFirstname() {
        return firstname;
    }

    public static void setFirstname(String firstname) {
        UserID.firstname = firstname;
    }

    public static String getLastname() {
        return lastname;
    }

    public static void setLastname(String lastname) {
        UserID.lastname = lastname;
    }
}
