package com.keyboardstore.service;

import com.keyboardstore.dao.UserDAO;
import com.keyboardstore.entity.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserServices {
	private UserDAO userDAO;
	private HttpServletRequest request;
	private	HttpServletResponse response;
	public UserServices(HttpServletRequest request, HttpServletResponse response) {
		this.request=request;
		this.response=response;

		userDAO = new UserDAO();
	}

	public void listUser()throws ServletException, IOException {
		listUser(null, null);
	}

	public void listUser(String message, String messageType) throws ServletException, IOException {
		List<Users> listUsers = userDAO.listAll();

		request.setAttribute("listUsers", listUsers);
		if (message != null) {
			request.setAttribute("message", message);
			request.setAttribute("messageType", messageType);  // Pass message type
		}

		String listPage = "user_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}

	public void createUser() throws ServletException, IOException {
		String email = request.getParameter("email");
		String fullname = request.getParameter("fullname");
		String password = request.getParameter("password");
		String role = request.getParameter("role");

		Users existUser = userDAO.findByEmail(email);

		if (existUser != null) {
			String message = "Create user fail. A user with email: " + email + " already existed";
			request.setAttribute("message", message);
			request.setAttribute("messageType", "error");  // Set message type as error
			// Set attributes to retain entered data
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.setAttribute("role", role);
			RequestDispatcher dispatcher = request.getRequestDispatcher("user_form.jsp");
			dispatcher.forward(request, response);
		} else {
			Users newUser = new Users(email, fullname, password,role);
			userDAO.create(newUser);
			listUser("New user created successfully", "success");  // Success message type
		}
	}

	public void editUser() throws ServletException, IOException {
		Integer userId = Integer.parseInt(request.getParameter("id"));
		Users user = userDAO.get(userId);
		
		request.setAttribute("user", user);
		String editPage = "user_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	public void updateUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		
		Users userById = userDAO.get(userId);
		Users userByEmail = userDAO.findByEmail(email);
		
		if(userByEmail != null && userByEmail.getUserId() != userById.getUserId()) {
			String message = "Could not update user. User with email " + email + " already exists.";
			request.setAttribute("message", message);
			request.setAttribute("messageType", "error");  // Error message type
			// Set attributes to retain entered data
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullName);
			request.setAttribute("role", role);
		} else {
			Users user = new Users(userId,email, fullName, password,role);
			userDAO.update(user);

			String message = "User is updated successfully";
			listUser(message, "success");  // Success message type
		}
	}

	public void deleteUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("id"));
		userDAO.delete(userId);

		String message = "User with ID " + userId + " has been deleted successfully";
		listUser(message, "success");  // Success message type
	}

	public void showUserNewForm() throws ServletException, IOException {
		String newPage = "user_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(newPage);
		requestDispatcher.forward(request, response);
	}

	public void login() throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		boolean loginResult = userDAO.checkLogin(email, password);
		if (loginResult) {
			request.getSession().setAttribute("useremail", email);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
			dispatcher.forward(request, response);
		} 
		else {
			String message = "Login failed!";
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}
}
