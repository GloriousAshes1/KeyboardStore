
package com.keyboardstore.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceException;

import org.junit.*;

import com.keyboardstore.entity.Users;

public class UserDAOTest {
	private static EntityManagerFactory entityManagerFactory;
	private static EntityManager entityManager;
	private static UserDAO userDAO; 

	@BeforeClass
	public static void setUp(){
		userDAO = new UserDAO();
	}

	@Test
	public void testCreateUsers() {
		Users user1 = new Users();
		user1.setEmail("khabanh@gmail.com");
		user1.setFullName("Ngo Ba Kha");
		user1.setPassword("123");

		
		user1 = userDAO.create(user1);
		
		assertTrue(user1.getUserId()>0);
	}
	
	@Test(expected = PersistenceException.class)
	public void testFieldsNotSet() {
		Users user1 = new Users();
		
		user1 = userDAO.create(user1);
	}
	
	@Test
	public void testUpdateUser() {
		Users user1 = new Users();
		user1.setUserId(2);
		user1.setEmail("huanrose@gmail");
		user1.setFullName("Bui Xuan Huan");
		user1.setPassword("9ngonruoi");
		
		user1 = userDAO.update(user1);
		String expected = "9ngonruoi";
		String actual = user1.getPassword();
		
		assertEquals(expected, actual);
	}
	@Test
	public void testGetUserFound() {
		Integer	userId = 1;
		Users user = userDAO.get(userId);
		System.out.println(user.getEmail());
		assertNotNull(user);
	}
	@Test
	public void testDeleteUser() {
		Integer	userId = 2;
		userDAO.delete(userId);
		Users user = userDAO.get(userId);
		assertNull(user);
	}
	@Test
	public void testListAll() {
		List<Users> list = userDAO.listAll();
		
		for(Users user:list) {
			System.out.println(user.getFullName());
		}
		
		assertTrue(list.size()>0);
	}
	@Test
	public void testCount() {
		long total = userDAO.count();
		assertEquals(1,total);
	}
	@Test
	public void testFindByEmail() {
		String email = "nam@codejava.net";
		Users user = userDAO.findByEmail(email);
		
		assertNotNull(user);
	}
	@Test
	public void checkLogAdmin() {
		String email = "khabanh@gmail.com";
		String pass = "123";
		boolean loginResult = userDAO.checkLogin(email, pass);
		
		assertTrue(loginResult);
	}
	@AfterClass
	public static void tearDown(){
		userDAO.close();
	}

}

