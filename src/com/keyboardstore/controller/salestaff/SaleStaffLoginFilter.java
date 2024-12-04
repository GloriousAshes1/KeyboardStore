package com.keyboardstore.controller.salestaff;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/salestaff/*")
public class SaleStaffLoginFilter extends HttpFilter implements Filter {
    public SaleStaffLoginFilter() {super();}

    public void destroy() {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httRequest = (HttpServletRequest) request;
        HttpSession session = httRequest.getSession(false);

        boolean loggedIn = session != null && session.getAttribute("useremail") != null;
        String loginURI = httRequest.getContextPath()+"/salestaff/login";
        boolean loginRequest = httRequest.getRequestURI().equals(loginURI);
        boolean loginPage = httRequest.getRequestURI().endsWith("login.jsp");

//        if(loggedIn && (loginRequest||loginPage )) {
//            RequestDispatcher dispatcher = request.getRequestDispatcher("/salestaff/");
//            dispatcher.forward(request, response);
//        }
//
//        else if(loggedIn || loginRequest ) {
//            chain.doFilter(httRequest, response);
//        }
//        else {
//            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
//            dispatcher.forward(request, response);
//        }
        if (loggedIn) {
            // Check if the logged-in user is a staff member
            String role = (String) session.getAttribute("userrole");  // Assuming user role is stored in session

            if ("Sale Staff".equalsIgnoreCase(role)) {
                // Allow access to staff pages
                chain.doFilter(request, response);
            } else {
                // If the user is not staff, redirect to an appropriate page (e.g., Admin or Home)
                RequestDispatcher dispatcher = request.getRequestDispatcher("/accessDenied.jsp");  // Customize as needed
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
