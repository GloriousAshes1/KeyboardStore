package com.keyboardstore.controller.admin.statistic;

import com.keyboardstore.dao.OrderDAO;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/admin/show_chart")
public class DisplayChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DisplayChartServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        String productIdStr = request.getParameter("productId");
        String export = request.getParameter("export");
        Integer productId = null;
        Date startDate = null;
        Date endDate = null;
        Date endDateforInput = null;

        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);

            // Use SimpleDateFormat to parse dates in dd/MM/yyyy format
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

            // Parse start date
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = dateFormat.parse(startDateStr); // Parse start date
            }

            // Parse end date
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDateforInput = dateFormat.parse(endDateStr);
                endDate = dateFormat.parse(endDateStr); // Parse end date
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(endDate);
                calendar.set(Calendar.HOUR_OF_DAY, 23);  // Set end date to 23:59:59
                calendar.set(Calendar.MINUTE, 59);
                calendar.set(Calendar.SECOND, 59);
                calendar.set(Calendar.MILLISECOND, 999);
                endDate = calendar.getTime(); // Adjust the end date to include the full day
            }

            List<Object[]> salesData = null;

            // Check if a specific product is selected
            if (productIdStr != null && !productIdStr.isEmpty()) {
                productId = Integer.parseInt(productIdStr);
                salesData = orderDAO.getProfitsForSpecificProduct(productId, startDate, endDate);
                request.setAttribute("productId", productId);
            } else {
                // Get sales for all products if no specific product is selected
                salesData = orderDAO.getProfitsForAllProducts(startDate, endDate);
            }

            // Aggregate sales data by date (using TreeMap to ensure the dates are sorted)
            Map<String, Map<String, Double>> salesByDateAndProduct = new TreeMap<>();

            for (Object[] row : salesData) {
                Date saleDate = (Date) row[0];
                String productName = (String) row[2]; // Assuming the product name is in row[2]
                String formattedDate = dateFormat.format(saleDate);  // Format date to dd/MM/yyyy
                Double subtotal = (Double) row[4]; // Assuming the subtotal is in row[4]

                // Initialize the map for this date if it doesn't exist
                salesByDateAndProduct.putIfAbsent(formattedDate, new TreeMap<>());
                Map<String, Double> productSales = salesByDateAndProduct.get(formattedDate);

                // Sum sales for the same product on the same date
                productSales.put(productName, productSales.getOrDefault(productName, 0.0) + subtotal);
            }

            // Set the sales data, start date, and end date as request attributes
            request.setAttribute("salesData", salesByDateAndProduct);
            request.setAttribute("salesDataExcel", salesData);


            // Handle export to Excel
            if ("true".equals(export)) {
                exportToExcel(response, salesData, startDate, endDate);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward to JSP page for rendering the report
        String reportPage = "statistics.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(reportPage);
        dispatcher.forward(request, response);
    }

    // Method to export sales data to an Excel file
    private void exportToExcel(HttpServletResponse response, List<Object[]> salesData, Date startDate, Date endDate) throws IOException {
        // Create an Excel workbook
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Sales Report");

        // Create a header row
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Date");
        headerRow.createCell(1).setCellValue("Product Name");
        headerRow.createCell(2).setCellValue("Quantity Sold");
        headerRow.createCell(3).setCellValue("Profits");
        headerRow.createCell(4).setCellValue("Total Profits");

        // Prepare to format date as dd/MM/yyyy
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        int rowNum = 1;
        double totalSalesSum = 0.0; // To calculate total sales

        // Track the current date within the date range
        Calendar current = Calendar.getInstance();
        current.setTime(startDate);

        Calendar end = Calendar.getInstance();
        end.setTime(endDate);

        // Iterate over each day in the range
        while (!current.after(end)) {
            Date currentDate = current.getTime();
            String formattedCurrentDate = dateFormat.format(currentDate);

            boolean saleFound = false;

            // Loop over salesData to check if there's a sale for the current date
            for (Object[] row : salesData) {
                // Assuming row[0] is the Date object of the sale
                Date saleDate = (Date) row[0];
                String formattedSaleDate = dateFormat.format(saleDate);

                if (formattedSaleDate.equals(formattedCurrentDate)) {
                    Row dataRow = sheet.createRow(rowNum++);

                    // Set formatted date only for the first sale of the day
                    if (!saleFound) {
                        dataRow.createCell(0).setCellValue(formattedSaleDate);
                        saleFound = true;
                    }

                    // Product Name (row[2] holds the product name)
                    if (row[2] != null) {
                        dataRow.createCell(1).setCellValue(row[2].toString());
                    }

                    // Quantity Sold (row[3] holds the quantity sold)
                    int quantitySold = 0;
                    if (row[3] != null) {
                        if (row[3] instanceof Integer) {
                            quantitySold = (Integer) row[3];
                            dataRow.createCell(2).setCellValue(quantitySold);
                        } else {
                            try {
                                quantitySold = Integer.parseInt(row[3].toString());
                                dataRow.createCell(2).setCellValue(quantitySold);
                            } catch (NumberFormatException e) {
                                dataRow.createCell(2).setCellValue(0); // Fallback to 0 if not valid
                            }
                        }
                    }

                    // Sales Price (row[4] holds the sales price)
                    double salesPrice = 0.0;
                    if (row[4] != null) {
                        if (row[4] instanceof Double) {
                            salesPrice = (Double) row[4];
                            dataRow.createCell(3).setCellValue(salesPrice);
                        } else {
                            try {
                                salesPrice = Double.parseDouble(row[4].toString());
                                dataRow.createCell(3).setCellValue(salesPrice);
                            } catch (NumberFormatException e) {
                                dataRow.createCell(3).setCellValue(0.0); // Fallback to 0.0 if not valid double
                            }
                        }
                    }

                    // Calculate total sales as quantitySold * salesPrice
                    double totalSales = quantitySold * salesPrice;
                    dataRow.createCell(4).setCellValue(totalSales);
                    totalSalesSum += totalSales; // Add to total sales sum
                }
            }

            // If no sale was found for the current date, add an empty row with just the date
            if (!saleFound) {
                Row emptyRow = sheet.createRow(rowNum++);
                emptyRow.createCell(0).setCellValue(formattedCurrentDate); // Set the date only
            }

            // Move to the next day
            current.add(Calendar.DAY_OF_MONTH, 1);
        }

        // Set response content type and header
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=sales_report.xlsx");

        // Write the Excel file to the response
        ServletOutputStream outputStream = response.getOutputStream();
        workbook.write(outputStream);
        workbook.close();
        outputStream.flush();
        outputStream.close();
    }
}
