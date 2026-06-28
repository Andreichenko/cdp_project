package com.example;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class PaymentServiceTest {
    private PaymentService paymentService;

    @Before
    public void setUp() {
        paymentService = new PaymentService();
    }

    @Test
    public void testSuccessfulTransfer() throws PaymentException {
        Double initialSender = paymentService.getBalance("ACC1001");
        Double initialRecipient = paymentService.getBalance("ACC1002");

        Transaction tx = paymentService.transfer("ACC1001", "ACC1002", 500.0);

        assertNotNull(tx.getId());
        assertEquals("ACC1001", tx.getFromAccount());
        assertEquals("ACC1002", tx.getToAccount());
        assertEquals(500.0, tx.getAmount(), 0.001);
        assertEquals("SUCCESS", tx.getStatus());

        assertEquals(initialSender - 500.0, paymentService.getBalance("ACC1001"), 0.001);
        assertEquals(initialRecipient + 500.0, paymentService.getBalance("ACC1002"), 0.001);
    }

    @Test
    public void testInsufficientFunds() {
        try {
            paymentService.transfer("ACC1003", "ACC1001", 1000.0);
            fail("Expected PaymentException to be thrown");
        } catch (PaymentException e) {
            assertTrue(e.getMessage().contains("Insufficient funds"));
        }
    }

    @Test
    public void testTransferToSameAccount() {
        try {
            paymentService.transfer("ACC1001", "ACC1001", 100.0);
            fail("Expected PaymentException to be thrown");
        } catch (PaymentException e) {
            assertEquals("Cannot transfer money to the same account.", e.getMessage());
        }
    }

    @Test
    public void testNonExistentAccount() {
        try {
            paymentService.transfer("ACC1001", "ACC9999", 100.0);
            fail("Expected PaymentException to be thrown");
        } catch (PaymentException e) {
            assertEquals("Recipient account not found.", e.getMessage());
        }
    }

    @Test
    public void testNegativeAmount() {
        try {
            paymentService.transfer("ACC1001", "ACC1002", -50.0);
            fail("Expected PaymentException to be thrown");
        } catch (PaymentException e) {
            assertEquals("Transfer amount must be greater than zero.", e.getMessage());
        }
    }
}
