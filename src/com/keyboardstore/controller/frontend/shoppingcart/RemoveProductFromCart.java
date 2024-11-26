package com.keyboardstore.controller.frontend.shoppingcart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.entity.Product;

@WebServlet("/remove_from_cart")
public class RemoveProductFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RemoveProductFromCart() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer productId = Integer.parseInt(request.getParameter("product_id"));

		Object cartObject = request.getSession().getAttribute("cart");

		ShoppingCart shoppingCart = (ShoppingCart) cartObject;



		shoppingCart.removeItems(new Product(productId));

		String cartPage = request.getContextPath().concat("/view_cart");
		response.sendRedirect(cartPage);
	}

}
