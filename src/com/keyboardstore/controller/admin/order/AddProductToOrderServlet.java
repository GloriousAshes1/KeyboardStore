package com.keyboardstore.controller.admin.order;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.entity.Product;
import com.keyboardstore.entity.ProductOrder;
import com.keyboardstore.entity.OrderDetail;

@WebServlet("/admin/add_product_to_order")
public class AddProductToOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddProductToOrderServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		Integer productId = Integer.parseInt(request.getParameter("productId"));
		Integer quantity = Integer.parseInt(request.getParameter("quantity"));

		ProductDAO gameDAO = new ProductDAO();
		Product product = gameDAO.get(productId);

		HttpSession session = request.getSession();
		ProductOrder order = (ProductOrder) session.getAttribute("order");

		float subTotal = quantity * product.getSellingPrice();

		OrderDetail orderDetail = new OrderDetail();
		orderDetail.setProduct(product);
		orderDetail.setQuantity(quantity);
		orderDetail.setSubtotal(subTotal);

		float newTotal = order.getTotal() + subTotal;
		order.setTotal(newTotal);
		order.getOrderDetails().add(orderDetail);
		request.setAttribute("product", product);
		session.setAttribute("NewGamePendingToAddToOrder", true);

		String resultPage = "add_product_result.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultPage);
		requestDispatcher.forward(request, response);
	}
}
