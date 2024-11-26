package com.keyboardstore.controller.admin.game;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

@WebServlet("/admin/list_games")
public class ListGameServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProductServices productServices = new ProductServices(request, response);
		productServices.listProducts();
	}

}
