package com.keyboardstore.controller.salestaff.customer;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/salestaff/create_customer")
public class CreateCustomerServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public CreateCustomerServlet() {
    	super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerService customerService = new CustomerService(response, request);
		customerService.createCustomer();
	}

}
