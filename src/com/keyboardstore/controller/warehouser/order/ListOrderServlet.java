package com.keyboardstore.controller.warehouser.order;

import com.keyboardstore.service.OrderServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/warehouser/list_order")
public class ListOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ListOrderServlet() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OrderServices orderServices = new OrderServices(request, response);
		orderServices.listAllOrder();
	}

}
