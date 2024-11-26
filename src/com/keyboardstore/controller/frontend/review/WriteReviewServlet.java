package com.keyboardstore.controller.frontend.review;

import com.keyboardstore.service.ReviewService;
import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.dao.CategoryDAO;
import com.keyboardstore.entity.Category;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/write_review")
public class WriteReviewServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public WriteReviewServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryDAO categoryDAO = new CategoryDAO();
		List<Category> listCategory = categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);
		
		ReviewService reviewService =  new ReviewService(request, response);
		reviewService.showReviewForm();;
	}

}
