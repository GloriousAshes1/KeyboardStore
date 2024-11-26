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

@WebServlet("/admin/add_game_to_order")
public class AddGameToOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddGameToOrderServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		Integer gameId = Integer.parseInt(request.getParameter("gameId"));
		Integer quantity = Integer.parseInt(request.getParameter("quantity"));

		ProductDAO gameDAO = new ProductDAO();
		Product product = gameDAO.get(gameId);

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
		request.setAttribute("game", product);
		session.setAttribute("NewGamePendingToAddToOrder", true);

		String resultPage = "add_game_result.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultPage);
		requestDispatcher.forward(request, response);
	}
}
