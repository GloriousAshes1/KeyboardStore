package com.keyboardstore.controller.admin.product;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.ProductServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/update_product")
@MultipartConfig(
		fileSizeThreshold = 1024 * 10, // 10 KB
		maxFileSize = 1024 *100,	   // 100 KB
		maxRequestSize = 1024 * 1024   // 1 MB
)
public class UpdateProductServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public UpdateProductServlet() {
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ProductServices productServices = new ProductServices(request, response);
		productServices.updateProduct();
	}

}
