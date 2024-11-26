package com.keyboardstore.controller.frontend;

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

@WebFilter("/*")
public class CustomerLoginFilter extends HttpFilter implements Filter {
       
	private static final String[] loginRequiredURLS = { "/view_profile", "/update_profile", "edit_profile","/checkout", "/place_order",
			"/write_review" , "/view_orders","/show_order_detail"};
	
	public CustomerLoginFilter() {
	}

	public void destroy() {
	}

	private boolean isLoginRequired(String requestURL) {
		for (String loginRequiredURL : loginRequiredURLS) {
			if (requestURL.contains(loginRequiredURL)) {
				return true;
			}
		}
		return false;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);
		
		String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
		if (path.startsWith("/admin")) {
			chain.doFilter(request, response);
			return;
		}
		boolean isLoggedIn = session != null && session.getAttribute("loggedCustomer") != null;
		String requestURL = httpRequest.getRequestURL().toString();
		String requestURI = httpRequest.getRequestURI();
		System.out.println("Context path  : "  +  httpRequest.getContextPath());
		System.out.println("Request URI:   " + requestURI);
		System.out.println("Path is :  "  + path);
		System.out.println("Is logged in ?  " + isLoggedIn);
		System.out.println("Request URL :  " + requestURL );
		System.out.println("Query string  " + httpRequest.getQueryString());
		
		if (!isLoggedIn && isLoginRequired(requestURL)) {
			String queryString = httpRequest.getQueryString();
			String redirectURL = requestURL;
			if(queryString != null) {
				redirectURL = redirectURL.concat("?").concat(queryString);
			}
			session.setAttribute("redirectURL", redirectURL);
			String loginPage = "frontend/login.jsp";
			RequestDispatcher requestDispatcher = httpRequest.getRequestDispatcher(loginPage);
			requestDispatcher.forward(httpRequest, response);

		} else {
			chain.doFilter(request, response);
		}

	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
