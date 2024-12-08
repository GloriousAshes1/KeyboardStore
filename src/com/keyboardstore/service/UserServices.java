package com.keyboardstore.service;

import com.keyboardstore.dao.UserDAO;
import com.keyboardstore.entity.Users;
import com.keyboardstore.passwordHash.PasswordUtil;

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
			// Encrypt the password before saving
			String hashedPassword = PasswordUtil.hashPassword(password);
			Users newUser = new Users(email, fullname, hashedPassword, role);
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

		if (userByEmail != null && userByEmail.getUserId() != userById.getUserId()) {
			String message = "Could not update user. User with email " + email + " already exists.";
			request.setAttribute("message", message);
			request.setAttribute("messageType", "error");  // Error message type
			// Set attributes to retain entered data
			request.setAttribute("user", userById);
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullName);
			request.setAttribute("role", role);
			RequestDispatcher dispatcher = request.getRequestDispatcher("user_form.jsp");
			dispatcher.forward(request, response);
		} else {
			// If password is provided, hash it; otherwise, keep the existing password
			String hashedPassword;
			if (password != null && !password.isEmpty()) {
				hashedPassword = PasswordUtil.hashPassword(password);
			} else {
				hashedPassword = userById.getPassword();  // Keep the existing password if it's not changed
			}

			Users updatedUser = new Users(userId, email, fullName, hashedPassword, role);
			userDAO.update(updatedUser);

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

		// Fetch the user's details from the database using the email
		Users user = userDAO.findByEmail(email);

		if (user != null) {
			String storedPassword = user.getPassword();
			boolean loginResult = false;

			// Check if the stored password is hashed (BCrypt hash is typically 60 characters long)
			if (storedPassword.length() == 60) {
				// Password is hashed, use BCrypt to verify
				loginResult = PasswordUtil.checkPassword(password, storedPassword);
			} else {
				// Password is not hashed, treat it as plain text
				if (password.equals(storedPassword)) {
					// Login successful, hash the plain text password and update the database
					String hashedPassword = PasswordUtil.hashPassword(password);
					user.setPassword(hashedPassword);
					userDAO.update(user); // Update the user's password in the database

					loginResult = true;
				}
			}

			if (loginResult) {
				// Login successful, proceed with session creation
				Integer userId = user.getUserId();   // Retrieve the userId
				String role = user.getRole();        // Get the user's role

				// Create a new session for the user
				HttpSession session = request.getSession();
				session.setAttribute("useremail", email); // Store user email in the session
				session.setAttribute("userrole", role);   // Store user role in the session
				session.setAttribute("userId", userId);   // Store userId in the session

				// Redirect the user based on their role
				Object objRedirectURL = session.getAttribute("redirectURL");
				if (objRedirectURL != null) {
					String redirectURL = (String) objRedirectURL;
					session.removeAttribute("redirectURL");
					response.sendRedirect(redirectURL);
				} else {
					if ("Manager".equalsIgnoreCase(role)) {
						response.sendRedirect(request.getContextPath() + "/admin/");
					} else if ("Sale Staff".equalsIgnoreCase(role)) {
						response.sendRedirect(request.getContextPath() + "/salestaff/");
					} else {
						String message = "Invalid user role!";
						request.setAttribute("message", message);
						RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
						dispatcher.forward(request, response);
					}
				}
			} else {
				// Incorrect password
				String message = "Login failed! Incorrect password.";
				request.setAttribute("message", message);
				RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
				dispatcher.forward(request, response);
			}
		} else {
			// User not found
			String message = "Login failed! No user with email "+email+" found.";
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
