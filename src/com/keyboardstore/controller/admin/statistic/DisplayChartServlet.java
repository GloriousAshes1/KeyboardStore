package com.keyboardstore.controller.admin.statistic;

import com.keyboardstore.dao.OrderDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/show_chart")
public class DisplayChartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DisplayChartServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("specificProduct".equals(action)) {
            showSalesReportForSpecificProduct(request, response);
        } else {
            showSalesReportForAllProduct(request, response);
        }
    }

    public void showSalesReportForSpecificProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        Integer productId = Integer.parseInt(request.getParameter("productId"));
        Date startDate = null;
        Date endDate = null;

        // Parse the start and end dates if provided
        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = java.sql.Date.valueOf(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = java.sql.Date.valueOf(endDateStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Object[]> salesData = orderDAO.getSalesForSpecificProduct(productId, startDate, endDate);
        request.setAttribute("salesData", salesData);
        request.setAttribute("productId", productId);  // Pass productId
        request.setAttribute("startDate", startDate);  // Pass startDate
        request.setAttribute("endDate", endDate);      // Pass endDate

        String reportPage = "statistics.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(reportPage);
        dispatcher.forward(request, response);
    }

    public void showSalesReportForAllProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        Integer productId = null;  // Null for all products
        Date startDate = null;
        Date endDate = null;

        // Parse the start and end dates if provided
        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = java.sql.Date.valueOf(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = java.sql.Date.valueOf(endDateStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Object[]> salesData = orderDAO.getSalesForAllProducts(startDate, endDate);
        System.out.println("Sales data fetched: " + salesData);  // Log the data

        request.setAttribute("salesData", salesData);
        request.setAttribute("productId", productId);  // Pass null for all products
        request.setAttribute("startDate", startDate);  // Pass startDate
        request.setAttribute("endDate", endDate);      // Pass endDate

        String reportPage = "statistics.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(reportPage);
        dispatcher.forward(request, response);
    }
}


//    private Date parseDate(String dateStr) {
//        // Use a utility method or SimpleDateFormat to parse the date from a string
//        // Example: "yyyy-MM-dd"
//        try {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            return sdf.parse(dateStr);
//        } catch (ParseException e) {
//            return null; // Handle or log the exception if needed
//        }
//    }
//
//    private Date getDefaultStartDate() {
//        // Return a default start date (e.g., the beginning of the month or a fixed date)
//        Calendar cal = Calendar.getInstance();
//        cal.set(Calendar.DAY_OF_MONTH, 1); // Set to the first day of the current month
//        return cal.getTime();
//    }
//
//    private Date getDefaultEndDate() {
//        // Return the current date as the default end date
//        return new Date();
//    }
//}
