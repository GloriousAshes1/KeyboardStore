package com.keyboardstore.controller.salestaff.order;

import com.keyboardstore.service.OrderServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/salestaff/update_order")
public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateOrderServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		OrderServices orderServices = new OrderServices(request, response);
		orderServices.updateOrder();
	}

}
