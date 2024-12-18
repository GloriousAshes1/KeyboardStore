package com.keyboardstore.controller.admin.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.service.CustomerService;

@WebServlet("/admin/new_customer")
public class ShowCustomerNewFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ShowCustomerNewFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		CustomerService customerService = new CustomerService(response, request);
		customerService.newCustomer();
	}

}
