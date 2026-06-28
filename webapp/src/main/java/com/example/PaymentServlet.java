package com.example;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class PaymentServlet extends HttpServlet {
    private static final PaymentService paymentService = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String fromAccount = request.getParameter("fromAccount");
        String toAccount = request.getParameter("toAccount");
        String amountStr = request.getParameter("amount");

        try {
            if (amountStr == null || amountStr.trim().isEmpty()) {
                throw new PaymentException("Amount is required.");
            }

            double amount;
            try {
                amount = Double.parseDouble(amountStr);
            } catch (NumberFormatException e) {
                throw new PaymentException("Invalid amount format. Please enter a valid number.");
            }

            // Perform the transfer
            Transaction tx = paymentService.transfer(fromAccount, toAccount, amount);
            Double remainingBalance = paymentService.getBalance(fromAccount);

            // Display success receipt
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Payment Success Receipt</title>");
            out.println("<style>");
            out.println("body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; margin: 0; padding: 40px; display: flex; justify-content: center; }");
            out.println(".receipt { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); width: 100%; max-width: 450px; box-sizing: border-box; }");
            out.println(".header { text-align: center; border-bottom: 2px dashed #e2e8f0; padding-bottom: 20px; margin-bottom: 20px; }");
            out.println(".header h2 { color: #2b6cb0; margin: 0; }");
            out.println(".success-badge { display: inline-block; background-color: #c6f6d5; color: #22543d; padding: 4px 12px; border-radius: 20px; font-weight: bold; margin-top: 10px; font-size: 14px; }");
            out.println(".row { display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 15px; color: #4a5568; }");
            out.println(".row .label { font-weight: 600; color: #718096; }");
            out.println(".row .value { text-align: right; word-break: break-all; }");
            out.println(".footer { text-align: center; margin-top: 30px; border-top: 1px solid #e2e8f0; padding-top: 20px; }");
            out.println(".btn { background-color: #2b6cb0; color: white; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 15px; font-weight: bold; }");
            out.println(".btn:hover { background-color: #2b5c8f; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='receipt'>");
            out.println("<div class='header'>");
            out.println("<h2>BANKING SYSTEM</h2>");
            out.println("<span class='success-badge'>PAYMENT SUCCESSFUL</span>");
            out.println("</div>");
            out.println("<div class='row'><span class='label'>Transaction ID:</span><span class='value'>" + tx.getId() + "</span></div>");
            out.println("<div class='row'><span class='label'>From Account:</span><span class='value'>" + tx.getFromAccount() + "</span></div>");
            out.println("<div class='row'><span class='label'>To Account:</span><span class='value'>" + tx.getToAccount() + "</span></div>");
            out.println("<div class='row'><span class='label'>Amount:</span><span class='value'>$" + String.format("%.2f", tx.getAmount()) + "</span></div>");
            out.println("<div class='row'><span class='label'>Date:</span><span class='value'>" + tx.getTimestamp() + "</span></div>");
            out.println("<div class='row'><span class='label'>Remaining Balance:</span><span class='value'>$" + String.format("%.2f", remainingBalance) + "</span></div>");
            out.println("<div class='footer'>");
            out.println("<a href='index.jsp' class='btn'>Back to Dashboard</a>");
            out.println("</div>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");

        } catch (PaymentException e) {
            // Display error message
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Payment Error</title>");
            out.println("<style>");
            out.println("body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #fff5f5; margin: 0; padding: 40px; display: flex; justify-content: center; }");
            out.println(".error-box { background: white; padding: 30px; border-radius: 12px; border-top: 6px solid #e53e3e; box-shadow: 0 4px 20px rgba(0,0,0,0.08); width: 100%; max-width: 450px; box-sizing: border-box; }");
            out.println(".header h2 { color: #e53e3e; margin: 0 0 15px 0; }");
            out.println(".message { color: #4a5568; font-size: 16px; margin-bottom: 25px; line-height: 1.5; }");
            out.println(".btn { background-color: #e53e3e; color: white; border: none; padding: 10px 20px; border-radius: 6px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 15px; font-weight: bold; }");
            out.println(".btn:hover { background-color: #c53030; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='error-box'>");
            out.println("<div class='header'>");
            out.println("<h2>Transaction Failed</h2>");
            out.println("</div>");
            out.println("<div class='message'>" + e.getMessage() + "</div>");
            out.println("<div class='footer'>");
            out.println("<a href='index.jsp' class='btn'>Try Again</a>");
            out.println("</div>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}
