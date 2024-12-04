package com.keyboardstore.controller.salestaff.product;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/salestaff/search_product")
public class SearchProductServlet extends BaseServlet {
    private static final long serialVersionUID = 1L;

    public SearchProductServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductServices productServices = new ProductServices(request, response);
        try {
            productServices.searchProduct(request, response);  // Handles the search and forwards results
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error while searching for products.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("product_list.jsp").forward(request, response);
        }
    }
}
