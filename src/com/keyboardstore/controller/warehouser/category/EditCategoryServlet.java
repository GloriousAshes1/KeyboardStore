package com.keyboardstore.controller.warehouser.category;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.CategoryServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/warehouser/edit_category")
public class EditCategoryServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public EditCategoryServlet() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoryServices categoryServices = new CategoryServices(request, response);
		categoryServices.editCategory();
	}

}
