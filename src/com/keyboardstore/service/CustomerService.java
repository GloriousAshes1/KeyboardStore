package com.keyboardstore.service;

import com.keyboardstore.dao.CustomerDAO;
import com.keyboardstore.entity.Customer;
import com.keyboardstore.passwordHash.PasswordUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

public class CustomerService {
	private CustomerDAO customerDAO;
	private HttpServletResponse response;
	private HttpServletRequest request;

	public CustomerService(HttpServletResponse response, HttpServletRequest request) {
		super();
		this.response = response;
		this.request = request;
		this.customerDAO = new CustomerDAO();
	}

	public void listCustomers() throws ServletException,IOException{
		listCustomers(null,null);
	}

	public void listCustomers(String message, String messageType) throws ServletException, IOException {
		List<Customer> listCustomer = customerDAO.listAll();
		listCustomer.sort((c1, c2) -> Integer.compare(c2.getCustomerId(), c1.getCustomerId()));

		if (message != null) {
			request.setAttribute("message", message);
			request.setAttribute("messageType", messageType);
		}
		request.setAttribute("listCustomer", listCustomer);
		String path = "customer_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(path);
		requestDispatcher.forward(request, response);
	}

	private void updateCustomerFieldsFromForm(Customer customer) {
		String email = request.getParameter("email");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipCode = request.getParameter("zipCode");
		String country = request.getParameter("country");

		customer.setFirstname(firstName);
		if (email != null && !"".equals(email)) {
			customer.setEmail(email);
		}
		if (password != null && !"".equals(password)) {
			customer.setPassword(password);
		}
		customer.setFirstname(firstName);
		customer.setLastname(lastName);
		customer.setPhone(phone);
		customer.setAddressLine1(address1);
		customer.setAddressLine2(address2);
		customer.setZipcode(zipCode);
		customer.setCity(city);
		customer.setState(state);
		customer.setCountry(country);
	}

	public void createCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");

		// Check if email already exists
		Customer existCustomer = customerDAO.findByEmail(email);
		if (existCustomer != null) {
			String message = "Could not create customer. Email " + email + " is already registered by another customer";
			request.setAttribute("message", message);
			request.setAttribute("messageType", "error");

			// Retain the form data
			request.setAttribute("email", email);
			request.setAttribute("firstName", request.getParameter("firstName"));
			request.setAttribute("lastName", request.getParameter("lastName"));
			request.setAttribute("password", request.getParameter("password"));
			request.setAttribute("phone", request.getParameter("phone"));
			request.setAttribute("address1", request.getParameter("address1"));
			request.setAttribute("address2", request.getParameter("address2"));
			request.setAttribute("city", request.getParameter("city"));
			request.setAttribute("state", request.getParameter("state"));
			request.setAttribute("zipCode", request.getParameter("zipCode"));
			request.setAttribute("country", request.getParameter("country"));

			// Forward back to form with message
			RequestDispatcher dispatcher = request.getRequestDispatcher("customer_form.jsp");
			dispatcher.forward(request, response);
		} else {
			// Create new customer with hashed password
			Customer newCustomer = new Customer();
			updateCustomerFieldsFromForm(newCustomer);

			// Encrypt password before saving
			String hashedPassword = PasswordUtil.hashPassword(newCustomer.getPassword());
			newCustomer.setPassword(hashedPassword);

			customerDAO.create(newCustomer);
			String message = "New customer has been created successfully";
			listCustomers(message, "success");
		}
	}

	public void editCustomer() throws ServletException, IOException {
		Integer customerID = Integer.parseInt(request.getParameter("id"));
		Customer customer = customerDAO.get(customerID);
		request.setAttribute("customer", customer);

		generateCountryList();

		String editPage = "customer_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	private void generateCountryList() {
		String[] countryCodes = Locale.getISOCountries();
		Map<String, String> mapCountries = new TreeMap<>();
		for (String countryCode : countryCodes) {
			Locale locale = new Locale("", countryCode);
			String code = locale.getCountry();
			String name = locale.getDisplayCountry();
			mapCountries.put(name, code);

		}
		request.setAttribute("mapCountries", mapCountries);
	}

	public void updateCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("customerId"));
		String email = request.getParameter("email");
		Customer customerByEmail = customerDAO.findByEmail(email);
		if (customerByEmail != null && customerByEmail.getCustomerId() != customerId) {
			String message = "Could not update the customer id " + customerId
					+ " because there's an existing customer with the same email";
			request.setAttribute("message", message);
			request.setAttribute("messageType", "error");

			// Retain form data
			Customer customer = customerDAO.get(customerId);
			request.setAttribute("customer", customer);
			request.setAttribute("email", email);
			request.setAttribute("firstName", request.getParameter("firstName"));
			request.setAttribute("lastName", request.getParameter("lastName"));
			request.setAttribute("password", request.getParameter("password"));
			request.setAttribute("phone", request.getParameter("phone"));
			request.setAttribute("address1", request.getParameter("address1"));
			request.setAttribute("address2", request.getParameter("address2"));
			request.setAttribute("city", request.getParameter("city"));
			request.setAttribute("state", request.getParameter("state"));
			request.setAttribute("zipCode", request.getParameter("zipCode"));
			request.setAttribute("country", request.getParameter("country"));

			RequestDispatcher dispatcher = request.getRequestDispatcher("customer_form.jsp");
			dispatcher.forward(request, response);
		} else {
			Customer customerById = customerDAO.get(customerId);
			updateCustomerFieldsFromForm(customerById);

			// If the password field is not empty, hash it before updating
			String password = request.getParameter("password");
			if (password != null && !password.isEmpty()) {
				String hashedPassword = PasswordUtil.hashPassword(password);
				customerById.setPassword(hashedPassword);
			}

			customerDAO.update(customerById);
			String message = "The customer has been updated successfully";
			listCustomers(message, "success");
		}
	}

	public void deleteCustomer() throws ServletException, IOException {
		Integer customerID = Integer.parseInt(request.getParameter("id"));
		customerDAO.delete(customerID);
		String message = "The customer has been deteleted successefuly";
		listCustomers(message,"success");

	}

	public void registerCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");
		Customer existCustomer = customerDAO.findByEmail(email);
		String message = "";
		if (existCustomer != null) {
			message = "Could not register you. Email " + email + " is already registered by another customer";
		} else {
			Customer newCustomer = new Customer();
			updateCustomerFieldsFromForm(newCustomer);

			// Encrypt password before creating the customer
			String hashedPassword = PasswordUtil.hashPassword(newCustomer.getPassword());
			newCustomer.setPassword(hashedPassword);

			customerDAO.create(newCustomer);

			String title = "Register Successfully !!!";
			String body = "Thank you for your registration at KeyBoard Store!\n" +
					"If you have any questions or need further assistance, please contact us at Website or call (+84) 0398641860.\n" +
					"Have a great day!\n" +
					"Best regards.";

			// Send mail
			MailServices mailServices = new MailServices();
			mailServices.SendMail(email, title, body);

			message = "You have been registered successfully. Thank you.<br/>" +
					"<a href='login'>Click here</a> to login";
		}
		String messagePage = "frontend/message.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(messagePage);
		request.setAttribute("message", message);
		requestDispatcher.forward(request, response);
	}

	public void showLogin() throws ServletException, IOException {
		String loginPage = "frontend/login.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(loginPage);
		dispatcher.forward(request, response);
	}

	public void doLogin() throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// Fetch customer details using the email
		Customer customer = customerDAO.findByEmail(email);

		if (customer != null) {
			String storedPassword = customer.getPassword();
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
					customer.setPassword(hashedPassword);
					customerDAO.update(customer); // Update the customer's password in the database

					loginResult = true;
				}
			}

			if (loginResult) {
				// Login successful, proceed with session creation
				HttpSession session = request.getSession();
				session.setAttribute("loggedCustomer", customer);

				// Check if a specific redirect URL is set, and redirect accordingly
				Object objRedirectURL = session.getAttribute("redirectURL");
				if (objRedirectURL != null) {
					String redirectURL = (String) objRedirectURL;
					session.removeAttribute("redirectURL");
					response.sendRedirect(redirectURL);
				} else {
					response.sendRedirect(request.getContextPath());
				}
			} else {
				// Incorrect password
				String message = "Login failed. Please check your email or password";
				request.setAttribute("message", message);
				showLogin();
			}
		} else {
			// Customer not found
			String message = "Login failed. Please check your email or password";
			request.setAttribute("message", message);
			showLogin();
		}
	}

	public void showCustomerProfile() throws ServletException, IOException {
		String profilePage = "frontend/customer_profile.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(profilePage);
		dispatcher.forward(request, response);
	}

	public void showCustomerProfileEditForm() throws ServletException, IOException {
		generateCountryList();
		String editPage = "frontend/edit_profile.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);

	}

	public void updateCustomerProfile() throws ServletException, IOException {
		Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
		updateCustomerFieldsFromForm(customer);
		customerDAO.update(customer);
		showCustomerProfile();
	}

	public void newCustomer() throws ServletException, IOException {
		generateCountryList();

		String customerForm = "customer_form.jsp";
		request.getRequestDispatcher(customerForm).forward(request, response);
	}
	
	public void showCustomerRegistrationForm() throws ServletException, IOException {
		generateCountryList();
		String registerForm = "frontend/register_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(registerForm);
		dispatcher.forward(request, response);
	}
}
