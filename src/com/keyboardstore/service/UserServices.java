package com.keyboardstore.service;

import com.keyboardstore.dao.UserDAO;
import com.keyboardstore.entity.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
		Integer userId = Integer.parseInt(request.getParameter("userId"));
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
			Users user = userDAO.get(userId);
			request.setAttribute("user", user);
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullName);
			request.setAttribute("role", role);
			RequestDispatcher dispatcher = request.getRequestDispatcher("user_form.jsp");
			dispatcher.forward(request, response);
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

		// Check if login is successful by verifying credentials
		boolean loginResult = userDAO.checkLogin(email, password);

		if (loginResult) {
			// Fetch the user's details from the database using the email
			Users user = userDAO.findByEmail(email); // Fetch the user based on email
			Integer userId = user.getUserId();       // Retrieve the userId from the Users entity
			String role = user.getRole();            // Get the user's role from the entity

			// Create a new session for the user if they are logged in
			HttpSession session = request.getSession();
			session.setAttribute("useremail", email);  // Store user email in the session
			session.setAttribute("userrole", role);    // Store user role in the session
			session.setAttribute("userId", userId);    // Store userId in the session

			// Check if a specific redirect URL is set, and redirect accordingly
			Object objRedirectURL = session.getAttribute("redirectURL");
			if (objRedirectURL != null) {
				String redirectURL = (String) objRedirectURL;
				session.removeAttribute("redirectURL"); // Clean up the session
				response.sendRedirect(redirectURL); // Redirect to the original requested URL
			} else {
				// Redirect the user based on their role
				if ("Manager".equalsIgnoreCase(role)) {
					// Redirect to the manager's page
					response.sendRedirect(request.getContextPath() + "/admin/");
				} else if ("Sale Staff".equalsIgnoreCase(role)) {
					// Redirect to the sales staff page
					response.sendRedirect(request.getContextPath() + "/salestaff/");
				} else {
					// If the role is not recognized, show an error message
					String message = "Invalid user role!";
					request.setAttribute("message", message);
					RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
					dispatcher.forward(request, response);
				}
			}
		} else {
			// Login failed, display an error message and redirect to login page
			String message = "Login failed! Please check your email or password.";
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}

	public void searchUsers() throws ServletException, IOException {
		String query = request.getParameter("query");
		List<Users> listUsers;
		if (query != null && !query.trim().isEmpty()) {
			listUsers = userDAO.search(query); // Perform search
		} else {
			listUsers = userDAO.listAll(); // If no query, list all users
		}
		request.setAttribute("listUsers", listUsers);

		// Set a message about the search results
		String message = "Found " + listUsers.size() + " user(s) matching '" + query + "'";
		request.setAttribute("message", message);
		request.setAttribute("messageType", "info");

		// Forward to the JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("user_list.jsp");
		dispatcher.forward(request, response);
	}

}
