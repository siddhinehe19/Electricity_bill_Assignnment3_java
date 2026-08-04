package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.regex.Pattern;

@WebServlet("/calculate")
public class ElectricityBillServlet extends HttpServlet {

    private static final DecimalFormat MONEY_FORMAT = new DecimalFormat("₹#,##0.00");
    private static final Pattern ALPHANUMERIC_ID_PATTERN = Pattern.compile("^[A-Za-z0-9]+$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerName = request.getParameter("customerName");
        String customerId = request.getParameter("customerId");
        String unitsRaw = request.getParameter("units");
        double units = 0;
        String error = "";

        if (customerId == null || !ALPHANUMERIC_ID_PATTERN.matcher(customerId).matches()) {
            error = "Customer ID must be alphanumeric only (letters and numbers).";
        }

        try {
            units = Double.parseDouble(unitsRaw);
            if (units < 0) {
                error = "Units must be a positive number.";
            }
        } catch (NumberFormatException ex) {
            error = "Please enter a valid number of units.";
        }

        double bill = 0;
        String breakdown = "";

        if (error.isEmpty()) {
            bill = calculateBill(units);
            breakdown = buildBreakdown(units);
        }

        request.setAttribute("customerName", customerName);
        request.setAttribute("customerId", customerId);
        request.setAttribute("units", unitsRaw);
        request.setAttribute("error", error);
        request.setAttribute("bill", MONEY_FORMAT.format(bill));
        request.setAttribute("breakdown", breakdown);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    private double calculateBill(double units) {
        double total = 0;

        if (units <= 50) {
            total = units * 3.50;
        } else if (units <= 150) {
            total = 50 * 3.50 + (units - 50) * 4.00;
        } else if (units <= 250) {
            total = 50 * 3.50 + 100 * 4.00 + (units - 150) * 5.20;
        } else {
            total = 50 * 3.50 + 100 * 4.00 + 100 * 5.20 + (units - 250) * 6.50;
        }

        return total;
    }

    private String buildBreakdown(double units) {
        double first50 = Math.min(units, 50) * 3.50;
        double next100 = Math.max(0, Math.min(units - 50, 100)) * 4.00;
        double next100Again = Math.max(0, Math.min(units - 150, 100)) * 5.20;
        double above250 = Math.max(0, units - 250) * 6.50;

        return "First 50 units: " + MONEY_FORMAT.format(first50) + "<br>"
                + "Next 100 units: " + MONEY_FORMAT.format(next100) + "<br>"
                + "Next 100 units: " + MONEY_FORMAT.format(next100Again) + "<br>"
                + "Above 250 units: " + MONEY_FORMAT.format(above250);
    }
}
