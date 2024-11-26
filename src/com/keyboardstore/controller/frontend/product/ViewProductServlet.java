package com.keyboardstore.controller.frontend.product;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/view_product")
public class ViewProductServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public ViewProductServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProductServices productServices =new ProductServices(request, response);
		productServices.viewProductDetail();
	}

}
