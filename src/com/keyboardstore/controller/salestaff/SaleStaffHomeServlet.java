package com.keyboardstore.controller.salestaff;

import com.keyboardstore.dao.*;
import com.keyboardstore.entity.ProductOrder;
import com.keyboardstore.entity.Review;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/salestaff/")
public class SaleStaffHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public SaleStaffHomeServlet() {super();}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse respone) throws ServletException, IOException {
        doGet(request,respone);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        ProductDAO productDAO = new ProductDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        long totalProducts = productDAO.count();
        long totalCustomers = customerDAO.count();
        long totalOrders = orderDAO.count();
        long totalReviews = reviewDAO.count();
        double totalSales = orderDAO.totalSales();
        double totalTax = orderDAO.totalTax();
        double totalShippingFee = orderDAO.totalShippingFee();
        double totalSubToTal = orderDAO.totalSubToTal();


        List<ProductOrder> listMostRecentSales = orderDAO.listMostRecentSales();
        List<Review> listMostRecentReview = reviewDAO.listMostRecent();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("listMostRecentSales", listMostRecentSales);
        request.setAttribute("listMostRecentReview", listMostRecentReview);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalReviews", totalReviews);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("totalTax", totalTax);
        request.setAttribute("totalShippingFee", totalShippingFee);
        request.setAttribute("totalSubToTal", totalSubToTal);

        String homepage = "index.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(homepage);
        dispatcher.forward(request, response);
    }
}
