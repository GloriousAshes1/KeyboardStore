package com.keyboardstore.controller.warehouser;

import com.keyboardstore.service.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/warehouser/login")
public class WarehouserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public WarehouserLoginServlet() {}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        userServices.login();
    }
}
