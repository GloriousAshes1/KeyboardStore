package com.keyboardstore.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keyboardstore.entity.Review;

public class ReviewDAO extends JpaDAO<Review> implements GenericDAO<Review> {

	@Override
	public Review create(Review review) {
		review.setReviewTime(new Date());
		return super.create(review);
	}

	@Override
	public Review get(Object rewiewID) {
		return super.find(Review.class, rewiewID);
	}

	@Override
	public void delete(Object reviewId) {
		super.delete(Review.class, reviewId);

	}

	@Override
	public long count() {
		return super.countWithNamedQuery("Review.countAll");
	}

	@Override
	public List<Review> listAll() {
		return super.findWithNamedQuery("Review.listAll");
	}

	public Review findByCustomerAndGame(Integer customerId, Integer productId) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("customerId", customerId);
		parameters.put("productId", productId);
		List<Review> result = super.findWithNamedQuery("Review.findByCustomerAndProduct", parameters);
		if (!result.isEmpty()) {
			Review review = result.get(0);
			return review;
		}
		return null;

	}
	
	public List<Review> listMostRecent() {
		return super.findWithNamedQuery("Review.listAll", 0, 3);
	}

}
