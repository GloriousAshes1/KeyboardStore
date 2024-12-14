package com.keyboardstore.controller.admin.statistic;

import com.keyboardstore.dao.OrderDAO;
import org.apache.poi.ss.usermodel.*;
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
                String productName = (String) row[1];
                String formattedDate = dateFormat.format(saleDate);  // Format date to dd/MM/yyyy
                Double subtotal = Double.parseDouble(row[3].toString());

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
    private void exportToExcel(HttpServletResponse response, List<Object[]> salesData, Date startDate, Date endDate) throws IOException {
        // Create an Excel workbook
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Sales Report");

        // Create a header row
        Row headerRow = sheet.createRow(0);

        // Create a CellStyle for the header with borders
        CellStyle headerCellStyle = workbook.createCellStyle();
        headerCellStyle.setBorderTop(BorderStyle.THIN);
        headerCellStyle.setBorderBottom(BorderStyle.THIN);
        headerCellStyle.setBorderLeft(BorderStyle.THIN);
        headerCellStyle.setBorderRight(BorderStyle.THIN);
        headerCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // Set header cells and apply style
        Cell cell0 = headerRow.createCell(0);
        cell0.setCellValue("Date");
        cell0.setCellStyle(headerCellStyle);

        Cell cell1 = headerRow.createCell(1);
        cell1.setCellValue("Product Name");
        cell1.setCellStyle(headerCellStyle);

        Cell cell2 = headerRow.createCell(2);
        cell2.setCellValue("Quantity Sold");
        cell2.setCellStyle(headerCellStyle);

        Cell cell3 = headerRow.createCell(3);
        cell3.setCellValue("Profits");
        cell3.setCellStyle(headerCellStyle);

        // Create a CellStyle for the data cells with borders
        CellStyle dataCellStyle = workbook.createCellStyle();
        dataCellStyle.setBorderTop(BorderStyle.THIN);
        dataCellStyle.setBorderBottom(BorderStyle.THIN);
        dataCellStyle.setBorderLeft(BorderStyle.THIN);
        dataCellStyle.setBorderRight(BorderStyle.THIN);

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
                Date saleDate = (Date) row[0];
                String formattedSaleDate = dateFormat.format(saleDate);

                if (formattedSaleDate.equals(formattedCurrentDate)) {
                    Row dataRow = sheet.createRow(rowNum++);

                    // Set formatted date only for the first sale of the day
                    if (!saleFound) {
                        Cell dateCell = dataRow.createCell(0);
                        dateCell.setCellValue(formattedSaleDate);
                        dateCell.setCellStyle(dataCellStyle);
                        saleFound = true;
                    }

                    // Product Name
                    Cell productNameCell = dataRow.createCell(1);
                    if (row[1] != null) {
                        productNameCell.setCellValue(row[1].toString());
                    } else {
                        productNameCell.setCellValue("");
                    }
                    productNameCell.setCellStyle(dataCellStyle);

                    // Quantity Sold
                    Cell quantityCell = dataRow.createCell(2);
                    if (row[2] != null) {
                        int quantitySold = row[2] instanceof Integer ? (Integer) row[2] : Integer.parseInt(row[2].toString());
                        quantityCell.setCellValue(quantitySold);
                    } else {
                        quantityCell.setCellValue(0);
                    }
                    quantityCell.setCellStyle(dataCellStyle);

                    // Profits
                    Cell profitCell = dataRow.createCell(3);
                    if (row[3] != null) {
                        double salesPrice = row[3] instanceof Double ? (Double) row[3] : Double.parseDouble(row[3].toString());
                        profitCell.setCellValue(salesPrice);
                    } else {
                        profitCell.setCellValue(0.0);
                    }
                    profitCell.setCellStyle(dataCellStyle);
                }
            }

            // If no sale was found for the current date, add an empty row with just the date
            if (!saleFound) {
                Row emptyRow = sheet.createRow(rowNum++);
                Cell dateCell = emptyRow.createCell(0);
                dateCell.setCellValue(formattedCurrentDate);
                dateCell.setCellStyle(dataCellStyle);
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
