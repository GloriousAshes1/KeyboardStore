package com.keyboardstore.controller.admin.order;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.entity.Product;


@WebServlet("/admin/add_product_form")
public class ShowAddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ShowAddProductServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProductDAO gameDAO = new ProductDAO();
	    List<Product> listProduct = gameDAO.listAll();
	    request.setAttribute("listProduct", listProduct);
	    String addFormPage = "add_product_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(addFormPage);
		dispatcher.forward(request, response);
	}
}
