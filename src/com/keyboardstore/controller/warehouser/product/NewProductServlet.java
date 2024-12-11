package com.keyboardstore.controller.warehouser.product;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/warehouser/new_product")
public class NewProductServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;


    public NewProductServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProductServices productServices = new ProductServices(request, response);
		productServices.showProductNewForm();
	}

}
