package com.keyboardstore.controller.salestaff;

import com.keyboardstore.controller.BaseServlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/salestaff/logout")
public class SaleStaffLogoutServlet extends BaseServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("useremail");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/salestaff/login.jsp");
        dispatcher.forward(request, response);
    }
}
