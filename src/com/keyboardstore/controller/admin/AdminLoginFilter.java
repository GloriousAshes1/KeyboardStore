package com.keyboardstore.controller.admin;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter("/admin/*")
public class AdminLoginFilter extends HttpFilter implements Filter {
       
    public AdminLoginFilter() {
        super();
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httRequest = (HttpServletRequest) request;
		HttpSession session = httRequest.getSession(false);
		
		boolean loggedIn = session != null && session.getAttribute("useremail") != null;
		String loginURI = httRequest.getContextPath()+"/admin/login";
		boolean loginRequest = httRequest.getRequestURI().equals(loginURI);
		boolean loginPage = httRequest.getRequestURI().endsWith("login.jsp");
		
//		if(loggedIn && (loginRequest||loginPage )) {
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
//			dispatcher.forward(request, response);
//		}
//
//		else if(loggedIn || loginRequest ) {
//			chain.doFilter(httRequest, response);
//		}
//		else {
//			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
//			dispatcher.forward(request, response);
//		}
		if (loggedIn) {
			// Check if the logged-in user is a staff member
			String role = (String) session.getAttribute("userrole");  // Assuming user role is stored in session

			if ("Manager".equalsIgnoreCase(role)) {
				// Allow access to staff pages
				chain.doFilter(request, response);
			} else {
				// If the user is not staff, redirect to an appropriate page (e.g., Admin or Home)
				RequestDispatcher dispatcher = request.getRequestDispatcher("../error/403.jsp");  // Customize as needed
				dispatcher.forward(request, response);
			}
		} else if (loginRequest || loginPage) {
			// If the user is accessing login page or not logged in, allow access to login page
			chain.doFilter(request, response);
		} else {
			// Redirect to the login page if not logged in and not accessing the login page
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
