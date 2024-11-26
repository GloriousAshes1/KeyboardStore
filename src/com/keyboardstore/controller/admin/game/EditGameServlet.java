package com.keyboardstore.controller.admin.game;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/edit_game")
public class EditGameServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public EditGameServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProductServices productServices = new ProductServices(request, response);
		productServices.editProduct();
	}

}
