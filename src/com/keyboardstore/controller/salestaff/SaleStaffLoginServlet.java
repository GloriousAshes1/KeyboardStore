package com.keyboardstore.controller.salestaff;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/salestaff/login")
public class SaleStaffLoginServlet extends BaseServlet {
    private static final long serialVersionUID = 1L;


    public SaleStaffLoginServlet() {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        userServices.login();
    }
}
