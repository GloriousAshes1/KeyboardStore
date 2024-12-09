package com.keyboardstore.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keyboardstore.entity.Users;
public class UserDAO extends JpaDAO<Users> implements GenericDAO<Users> {
	
	public Users create(Users user) {
		return super.create(user);
	}
	@Override
	public Users update(Users user) {
		return super.update(user);
	}

	@Override
	public Users get(Object userId) {
		return super.find(Users.class, userId);
	}
	public Users findByEmail(String email) {
		List<Users>listUsers = super.findWithNamedQuery("Users.findByEmail","email",email);
		
		if(listUsers != null && listUsers.size() == 1) {
			return listUsers.get(0);
		}
		return null;
	}
	@Override
	public void delete(Object userId) {
		super.delete(Users.class, userId);
	}

	@Override
	public List<Users> listAll() {
		return super.findWithNamedQuery("Users.findAll");
	}

	@Override
	public long count() {
		return super.countWithNamedQuery("Users.countAll");
	}
	
	public boolean checkLogin(String email, String password) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("email", email);
		//parameters.put("password", password);
		
		List<Users> listUsers = super.findWithNamedQuery("Users.checkLogin", parameters);
		
		if (listUsers.size() == 1) {
			return true;
		}
		
		return false;
	}

	public List<Users> search(String query) {
		return super.findWithNamedQuery("Users.search", "query", "%" + query + "%");
	}

	public String findFullNameByUserId(Integer userId) {
		Users user = super.find(Users.class, userId);
		if (user != null) {
			return user.getFullName(); // Giả sử entity `Users` có phương thức `getFullName`
		}
		return null;
	}

}
