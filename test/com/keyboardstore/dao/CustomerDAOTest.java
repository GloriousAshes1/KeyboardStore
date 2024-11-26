
package com.keyboardstore.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.keyboardstore.entity.Customer;

public class CustomerDAOTest{
	private static CustomerDAO customerDAO;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		customerDAO = new CustomerDAO();
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		customerDAO.close();
	}

	@Test
	public void testGet() {
		Integer customerId = 3;
		Customer customer = customerDAO.get(customerId);
		
		assertNotNull(customer);
	}

	@Test
	public void testCreateCustomer() {
		Customer customer = new Customer();
		customer.setEmail("khabanh@gmail.com");
		customer.setFirstname("Kha");
		customer.setLastname("Ngo Ba Kha");
		customer.setCity("Ha Noi");
		customer.setAddressLine1("11 Nguyen Dinh Chieu");
		customer.setAddressLine2("11 Nguyen Dinh Chieu");
		customer.setCountry("Viet Nam");
		customer.setState("North");
		customer.setPassword("123");
		customer.setPhone("123456");
		customer.setZipcode("100100");
	
		Customer savedCustomer = customerDAO.create(customer);
		
		assertTrue(savedCustomer.getCustomerId()>0);
	}

	@Test
	public void testUpdateCustomer() {
		Customer customer = customerDAO.get(4);
		String fullname = "Dio Brando";
		customer.setFirstname(fullname);
		Customer updateCustomer = customerDAO.update(customer);
		
		assertTrue(updateCustomer.getFirstname().equals(fullname));
	}
	
	@Test
	public void testDeleteCustomer() {
		Integer customerId = 6;
		customerDAO.delete(customerId);
		Customer customer = customerDAO.get(6);		
		
		assertNull(customer);
	}
	@Test
	public void testList() {
		List<Customer> listCustomer = customerDAO.listAll();
		
		assertFalse(listCustomer.isEmpty());
	}
	
	@Test
	public void testCount() {
		long totalCustomer = customerDAO.count();
		
		assertEquals(2, totalCustomer);
	}
	@Test
	public void testFindByEmail() {
		String email = "khabanh@gmail.com";
		Customer customer = customerDAO.findByEmail(email);
		
		assertNotNull(customer);
	}
}

