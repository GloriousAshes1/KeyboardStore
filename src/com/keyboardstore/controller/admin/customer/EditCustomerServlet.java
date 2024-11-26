package com.keyboardstore.controller.admin.customer;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.CustomerService;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/edit_customer")
public class EditCustomerServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public EditCustomerServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerService customerService = new CustomerService(response, request);
		customerService.editCustomer();
	}

}
