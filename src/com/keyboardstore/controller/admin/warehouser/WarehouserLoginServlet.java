package com.keyboardstore.controller.admin.warehouser;

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
    public WarehouserLoginServlet() {super();}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        userServices.login();
    }
}
