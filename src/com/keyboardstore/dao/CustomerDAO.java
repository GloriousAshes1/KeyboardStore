package com.keyboardstore.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keyboardstore.entity.Customer;

public class CustomerDAO extends JpaDAO<Customer> implements GenericDAO<Customer> {
	
	public CustomerDAO() {
	}
	@Override
	public Customer get(Object id) {
		return super.find(Customer.class, id);
	}

	@Override
	public Customer create(Customer customer) {
		customer.setRegisterDate(new Date());
		return super.create(customer);
	}
	
	@Override
	public void delete(Object id) {
		super.delete(Customer.class, id);
	}

	@Override
	public List<Customer> listAll() {
		return super.findWithNamedQuery("Customer.findAll");

	}

	@Override
	public long count() {
		return super.countWithNamedQuery("Customer.countAll");
	}

	public Customer findByEmail(String email) {
		List<Customer> listCustomers = findWithNamedQuery("Customer.findByEmail", "email", email);
		if (!listCustomers.isEmpty()) {
			return listCustomers.get(0);
		} else {
			return null;
		}
	}

	public Customer checkLogin(String email, String password) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("email", email);
		parameters.put("pass", password);
		List<Customer> result = super.findWithNamedQuery("Customer.checkLogin", parameters);
		if (!result.isEmpty()) {
			return result.get(0);
		}
			return null;
	}

}
