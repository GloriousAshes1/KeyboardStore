package com.keyboardstore.controller.frontend.order;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.dao.CategoryDAO;
import com.keyboardstore.entity.Category;
import com.keyboardstore.service.OrderServices;

@WebServlet("/place_order")
public class PlaceOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public PlaceOrderServlet() {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		CategoryDAO categoryDAO = new CategoryDAO();
		List<Category> listCategory = categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);
		
		OrderServices orderServices = new OrderServices(request, response);
		orderServices.placeOrder();
	}

}
