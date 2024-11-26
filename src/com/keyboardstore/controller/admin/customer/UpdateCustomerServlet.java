package com.keyboardstore.controller.admin.customer;

import com.keyboardstore.service.CustomerService;
import com.keyboardstore.controller.BaseServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/update_customer")
public class UpdateCustomerServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public UpdateCustomerServlet() {
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerService  customerService =  new CustomerService(response, request);
		customerService.updateCustomer();
	}

}
