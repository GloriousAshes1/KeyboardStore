package com.keyboardstore.controller.frontend.customer;

import com.keyboardstore.service.CustomerService;
import com.keyboardstore.controller.BaseServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/update_profile")
public class UpdateCustomerProfileServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public UpdateCustomerProfileServlet() {
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerService customerService = new CustomerService(response, request);
		customerService.updateCustomerProfile();
	}

}
