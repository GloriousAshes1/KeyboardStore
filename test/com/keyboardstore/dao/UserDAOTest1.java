/*
package com.gamestore.dao;

import static org.junit.Assert.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.*;

import com.gamestore.entity.Users;

public class UserDAOTest1 {
	private static EntityManagerFactory entityManagerFactory;
	private static EntityManager entityManager;
	private static UserDAO userDAO; 
	@BeforeClass
	public void setUp() throws Exception{
		entityManagerFactory = Persistence.createEntityManagerFactory("GameStore");
		entityManager = entityManagerFactory.createEntityManager();
		
		userDAO = new UserDAO();
	}

	@AfterClass
	public void tearDown()throws Exception{
		entityManager.close();
		entityManagerFactory.close();
	}

	@Test
	public void testCreateUsers() {
		Users user1 = new Users();
		user1.setEmail("nam@codejava.net");
		user1.setFullName("Nam Ha Minh");
		user1.setPassword("hellowolrd");
		
		user1 = userDAO.create(user1);
		
		assertTrue(user1.getUserId()>0);
	}


}
*/
