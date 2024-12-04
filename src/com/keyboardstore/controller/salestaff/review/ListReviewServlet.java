package com.keyboardstore.controller.salestaff.review;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/salestaff/list_review")
public class ListReviewServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public ListReviewServlet() {
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReviewService reviewService = new ReviewService(request, response);
		reviewService.listAllReview();
	}

}
