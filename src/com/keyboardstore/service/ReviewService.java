package com.keyboardstore.service;

import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.dao.ReviewDAO;
import com.keyboardstore.entity.Customer;
import com.keyboardstore.entity.Product;
import com.keyboardstore.entity.Review;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class ReviewService{
	private ReviewDAO reviewDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public ReviewService(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		this.reviewDAO = new ReviewDAO();
	}

	public void listAllReview() throws ServletException, IOException {
		listAllReview(null);
	}

	public void listAllReview(String message) throws ServletException, IOException {
		List<Review> listReviews = reviewDAO.listAll();
		listReviews.sort((c1, c2) -> Integer.compare(c2.getReviewId(), c1.getReviewId()));

		request.setAttribute("listReviews", listReviews);
		if (message != null) {
			request.setAttribute("message", message);
		}
		String listPage = "review_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);

	}
	public void editReview() throws ServletException, IOException {
		Integer reviewID = Integer.parseInt(request.getParameter("id"));
		Review review = reviewDAO.get(reviewID);
		request.setAttribute("review", review);

		String editPage = "review_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);

	}

	public void updateReview() throws ServletException, IOException {
		Integer reviewID = Integer.parseInt(request.getParameter("reviewId"));

		String hedline = request.getParameter("headline");
		String commnent = request.getParameter("comment");

		Review review = reviewDAO.get(reviewID);
		review.setHeadline(hedline);
		review.setComment(commnent);
		reviewDAO.update(review);
		String message = "The review has been updated successfully";
		listAllReview(message);

	}

	public void deleteReview() throws ServletException, IOException {
		Integer reviewID = Integer.parseInt(request.getParameter("id"));
		reviewDAO.delete(reviewID);
		String message = "Review deleted succesefully";
		listAllReview(message);

	}

	public void showReviewForm() throws ServletException, IOException {
		Integer productId = Integer.parseInt(request.getParameter("product_id"));
		ProductDAO productDAO = new ProductDAO();
		Product product = productDAO.get(productId);

		HttpSession session = request.getSession();
		session.setAttribute("product", product);

		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		Review existReview = reviewDAO.findByCustomerAndGame(customer.getCustomerId(), productId);
		String targetPage = "frontend/review_form.jsp";
		if (existReview != null) {
			request.setAttribute("review", existReview);
			targetPage = "frontend/review_info.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(targetPage);
		dispatcher.forward(request, response);

	}

	public void submitReview() throws ServletException, IOException {
		Integer productIdId = Integer.parseInt(request.getParameter("productId"));
		Integer rating = Integer.parseInt(request.getParameter("rating"));
		String headLine = request.getParameter("headline");
		String comment = request.getParameter("comment");
		Review newReview = new Review();
		newReview.setRating(rating);
		newReview.setHeadline(headLine);
		newReview.setComment(comment);

		Product product = new Product();
		product.setProductId(productIdId);

		newReview.setProduct(product);

		Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");

		newReview.setCustomer(customer);

		reviewDAO.create(newReview);

		String mesagePage = "frontend/review_done.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(mesagePage);
		dispatcher.forward(request, response);
	}
}

