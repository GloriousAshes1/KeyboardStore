package com.keyboardstore.controller.frontend.customer;

import com.keyboardstore.controller.BaseServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/logout")
public class CustomerLogoutServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public CustomerLogoutServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().removeAttribute("loggedCustomer");
		response.sendRedirect(request.getContextPath());

	}

}
