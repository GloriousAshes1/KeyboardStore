package com.keyboardstore.controller.admin.user;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/new_user")
public class NewUserServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;


    public NewUserServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		UserServices userServices = new UserServices(request, response);
		userServices.showUserNewForm();
	}

}
