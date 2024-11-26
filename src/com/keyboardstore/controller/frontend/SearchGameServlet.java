package com.keyboardstore.controller.frontend;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchGameServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public SearchGameServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductServices productServices = new ProductServices(request, response);
		productServices.search();
	}

}
