package com.keyboardstore.service;

import com.keyboardstore.dao.CustomerDAO;
import com.keyboardstore.entity.Customer;

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

	public void listCustomers(String message) throws ServletException, IOException {
		List<Customer> listCustomer = customerDAO.listAll();
		if (message != null) {
			request.setAttribute("message", message);
		}
		request.setAttribute("listCustomer", listCustomer);
		String path = "customer_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(path);
		requestDispatcher.forward(request, response);
	}

	public void listCustomers() throws ServletException, IOException {
		listCustomers(null);
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
		Customer existCustomer = customerDAO.findByEmail(email);
		if (existCustomer != null) {
			String message = "Could not create customer. Email " + email + " is already registred by another customer";
			listCustomers(message);
		} else {
			Customer newCustomer = new Customer();
			updateCustomerFieldsFromForm(newCustomer);
			customerDAO.create(newCustomer);
			String message = "New Customer has been created succesefully";
			listCustomers(message);
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
		Integer customerID = Integer.parseInt(request.getParameter("customerId"));
		String email = request.getParameter("email");
		Customer customerByEmail = customerDAO.findByEmail(email);
		String message = null;
		if (customerByEmail != null && customerByEmail.getCustomerId() != customerID) {
			message = "Could not update the customer id " + customerID
					+ "because threre's an existing customer have the same email";
		} else {
			Customer customerById = customerDAO.get(customerID);
			updateCustomerFieldsFromForm(customerById);
			customerDAO.update(customerById);
			message = "The customer has been update successefully";
		}
		listCustomers(message);
	}

	public void deleteCustomer() throws ServletException, IOException {
		Integer customerID = Integer.parseInt(request.getParameter("id"));
		customerDAO.delete(customerID);
		String message = "The customer has been deteleted successefuly";
		listCustomers(message);

	}

	public void registerCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");
		Customer existCustomer = customerDAO.findByEmail(email);
		String message = "";
		if (existCustomer != null) {
			message = "Could not register you. Email " + email + " is already registred by another customer";
		} else {
			Customer newCustomer = new Customer();
			updateCustomerFieldsFromForm(newCustomer);
			customerDAO.create(newCustomer);
            String title = "Register Successfully !!!";
            String body = "Thank you for your registration at KeyBoard Store!\n" +
                    "If you have any questions or need further assistance, please contact us at Website or call (+84) 0398641860.\n" +
                    "Have a great day!\n" +
                    "Best regards.";
            //gửi mail
			MailServices mailServices = new MailServices();
			mailServices.SendMail(email, title, body);
			message = "You have been registered  succesefully.Thank you.<br/>"
					+ "<a href='login'>Click here</a> to login";
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
		Customer customer = customerDAO.checkLogin(email, password);
		if (customer == null) {
			String message = "Login failed. Please check your email or password";
			request.setAttribute("message", message);
			showLogin();
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loggedCustomer", customer);
			Object objRedirectURL = session.getAttribute("redirectURL");
			if (objRedirectURL != null) {
				String redirectURL = (String) objRedirectURL;
				session.removeAttribute("redirectURL");
				response.sendRedirect(redirectURL);
			} else {
				response.sendRedirect(request.getContextPath());
			}
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
