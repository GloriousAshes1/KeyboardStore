/*
package com.gamestore.dao;

import static org.junit.Assert.*;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.gamestore.entity.Customer;
import com.gamestore.entity.Game;
import com.gamestore.entity.Review;

public class ReviewDAOTest {
	private static ReviewDAO reviewDAO;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		reviewDAO = new ReviewDAO();
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		reviewDAO.close();
	}

	@Test
	public void testCreateReview() {
		Review review = new Review();
		Game game = new Game();
		game.setGameId(1);
		
		Customer customer = new Customer();
		customer.setCustomerId(3);
		
		review.setGame(game);
		review.setCustomer(customer);
		
		review.setHeadline("aaaaaaa");
		review.setRating(5);
		review.setComment("xxxxxxxxxxxxxxxxxx");
		
		Review savedReview = reviewDAO.create(review);
		
		assertTrue(savedReview.getReviewId()>0);
	}

	@Test
	public void testGet() {
		fail("Not yet implemented");
	}

	@Test
	public void testDeleteObject() {
		fail("Not yet implemented");
	}

	@Test
	public void testCount() {
		fail("Not yet implemented");
	}

	@Test
	public void testListAll() {
		fail("Not yet implemented");
	}

	@Test
	public void testFindByCustomerAndBook() {
		fail("Not yet implemented");
	}

}
*/
