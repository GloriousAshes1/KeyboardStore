package com.keyboardstore.controller.frontend;

import java.io.IOException;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.dao.CategoryDAO;
import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.entity.Category;
import com.keyboardstore.entity.Product;

@WebServlet("")
public class HomeServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
   
    public HomeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryDAO categoryDAO = new CategoryDAO();
		ProductDAO productDAO = new ProductDAO();
		
		List<Category> listCategory = categoryDAO.listAll();
		List<Product> listNewProducts = productDAO.listNewProducts();
		List<Product> listBestSellingProducts = productDAO.listBestSellingProducts();
		List<Product> listMostFavoredProducts = productDAO.listMostFavoredProducts();
		
		request.setAttribute("listCategory", listCategory);
		request.setAttribute("listNewProducts", listNewProducts);
		request.setAttribute("listBestSellingProducts", listBestSellingProducts);
		request.setAttribute("listMostFavoredProducts", listMostFavoredProducts);
		
		String homePage = "frontend/index.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(homePage);
		dispatcher.forward(request, response);
	}
}
