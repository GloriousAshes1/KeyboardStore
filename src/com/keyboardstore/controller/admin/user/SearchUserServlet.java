package com.keyboardstore.controller.admin.user;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.UserServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/search_user")
public class SearchUserServlet extends BaseServlet {
    private static final long serialVersionUID = 1L;

    public SearchUserServlet() {}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        try {
            // Call the search method from UserServices
            userServices.searchUsers();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error while searching for users.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("user_list.jsp").forward(request, response);
        }
    }
}
