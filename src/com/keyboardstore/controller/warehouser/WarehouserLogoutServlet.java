package com.keyboardstore.controller.warehouser;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/warehouser/logout")
public class WarehouserLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public WarehouserLogoutServlet() {super();}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("useremail");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/warehouser/login.jsp");
        dispatcher.forward(request, response);
    }
}
