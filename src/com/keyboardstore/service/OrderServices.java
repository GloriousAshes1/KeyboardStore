package com.keyboardstore.service;

import com.keyboardstore.controller.frontend.shoppingcart.ShoppingCart;
import com.keyboardstore.dao.JpaDAO;
import com.keyboardstore.dao.OrderDAO;
import com.keyboardstore.entity.Customer;
import com.keyboardstore.entity.OrderDetail;
import com.keyboardstore.entity.Product;
import com.keyboardstore.entity.ProductOrder;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

public class OrderServices {

	private OrderDAO orderDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public void listAllOrder() throws ServletException, IOException {
		listAllOrder(null);
	}

	public void listAllOrder(String message) throws ServletException, IOException {
		List<ProductOrder> listOrder = orderDAO.listAll();

		request.setAttribute("listOrder", listOrder);

		if (message != null) {
			request.setAttribute("message", message);
		}

		String listPage = "order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}

	public OrderServices(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.orderDAO = new OrderDAO();
	}

	public void viewOrderDetailForAdmin() throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("id"));

		ProductOrder order = orderDAO.get(orderId);
		request.setAttribute("order", order);

		String detailPage = "order_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
		dispatcher.forward(request, response);
	}

	public void showCheckOutForm() throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");

		// tax 10%
		float tax = shoppingCart.getTotalAmount() * 0.1f;
		// shipping 0.1$ per copy
		float shippingFee = shoppingCart.getTotalQuantity() * 1.0f;


		float total = shoppingCart.getTotalAmount() + tax + shippingFee;

		session.setAttribute("tax", tax);
		session.setAttribute("shippingFee", shippingFee);
		session.setAttribute("total", total);

		CommonUtility.generateCountryList(request);
		String checkOutPage = "frontend/checkout.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(checkOutPage);
		dispatcher.forward(request, response);
	}

	public void placeOrder() throws ServletException, IOException {
		String paymentMethod=request.getParameter("paymentMethod");
		ProductOrder order=readOrderInfo();
		System.out.println(order.getPaymentMethod());
		
		if(paymentMethod.equals("paypal")) {
			PaymentServices paymentServices = new PaymentServices(request, response);
			
			request.getSession().setAttribute("order4Paypal", order);
			paymentServices.authorizePayment(order);
		}else {
			placeOrderCOD(order);
		}
	}

	public void listOrderByCustomer() throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		List<ProductOrder> listOrders = orderDAO.listByCustomer(customer.getCustomerId());

		request.setAttribute("listOrders", listOrders);

		String historyPage = "frontend/order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(historyPage);
		dispatcher.forward(request, response);
	}

	public void showOrderDetailForCustomer() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");

		ProductOrder order = orderDAO.get(orderId, customer.getCustomerId());

		request.setAttribute("order", order);
		String detailpage = "frontend/order_detail.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(detailpage);
		requestDispatcher.forward(request, response);
	}

	public void deleteOrder() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));

		ProductOrder order = orderDAO.get(orderId);

		if (order != null) {
			orderDAO.delete(orderId);

			String message = "The order ID " + orderId + " has been deleted.";
			listAllOrder(message);
		} else {
			String message = "Could not find order with ID " + orderId
					+ ", or it might have been deleted by another admin.";
		}
	}

	public void showEditOrderForm() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		CommonUtility.generateCountryList(request);
		HttpSession session = request.getSession();
		ProductOrder order = orderDAO.get(orderId);
		session.setAttribute("order", order);
		String editPage = "order_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}


	private Integer saveOrder(ProductOrder order) {
		ProductOrder savedOrder = orderDAO.create(order);

		ShoppingCart shoppingCart = (ShoppingCart) request.getSession().getAttribute("cart");
		shoppingCart.clear(); // clear cart as order placed

		return savedOrder.getOrderId();
	}

	private ProductOrder readOrderInfo() {
		String paymentMethod = request.getParameter("paymentMethod");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipcode = request.getParameter("zipcode");
		String country = request.getParameter("country");

		ProductOrder order = new ProductOrder();
		order.setFirstname(firstname);
		order.setLastname(lastname);
		order.setPhone(phone);
		order.setAddressLine1(address1);
		order.setAddressLine2(address2);
		order.setCity(city);
		order.setState(state);
		order.setCountry(country);
		order.setZipcode(zipcode);
		order.setPaymentMethod(paymentMethod);

		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		order.setCustomer(customer);

		ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
		Map<Product, Integer> items = shoppingCart.getItems();

		Iterator<Product> iterator = items.keySet().iterator();

		Set<OrderDetail> orderDetails = new HashSet<>();

		while (iterator.hasNext()) {
			Product product = iterator.next();
			Integer quantity = items.get(product);
			float subtotal = quantity * product.getSellingPrice();

			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setProduct(product);
			orderDetail.setProductOrder(order);
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);

			orderDetails.add(orderDetail);
		}

		order.setOrderDetails(orderDetails);

		float tax = (Float) session.getAttribute("tax");
		float shippingFee = (Float) session.getAttribute("shippingFee");
		float total = (Float) session.getAttribute("total");

		order.setSubtotal(shoppingCart.getTotalAmount());
		order.setTax(tax);
		order.setShippingFee(shippingFee);
		order.setTotal(total);

		return order;
	}

	private void placeOrderCOD(ProductOrder order) throws ServletException, IOException {
		saveOrder(order);
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		String email = customer.getEmail();
		String title = "Order Successfully !!!";
        String body = "Thank you. We have received your order!\n" +
                "Your order will be delivered soon!\n" +
                "Have a great day!\n" +
                "Best regards.";
      //gửi mail
		MailServices mailServices = new MailServices();
		mailServices.SendMail(email, title, body);

		String message = "Your order have been recieved. Thanks for shopping with us.";
		request.setAttribute("message", message);

		String messagePage = "frontend/message.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(messagePage);
		dispatcher.forward(request, response);
	}
	
	public Integer placeOrderPaypal(Payment payment) {
		ProductOrder order = (ProductOrder) request.getSession().getAttribute("order4Paypal");
		ItemList itemList = payment.getTransactions().get(0).getItemList();
		ShippingAddress shippingAddress = itemList.getShippingAddress();
		String shippingPhoneNumber = itemList.getShippingPhoneNumber();
		
		String recipientName = shippingAddress.getRecipientName();
		String [] names = recipientName.split(" ");
		
		order.setFirstname(names[0]);
		order.setLastname(names[1]);
		order.setAddressLine1(shippingAddress.getLine1());
		order.setAddressLine2(shippingAddress.getLine2());
		order.setCity(shippingAddress.getCity());
		order.setState(shippingAddress.getState());
		order.setCountry(shippingAddress.getCountryCode());
		order.setPhone(shippingPhoneNumber);
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		String email = customer.getEmail();
		String title = "Order Successfully !!!";
        String body = "Thank you. We have received your order!\n" +
                "Your order will be delivered soon!\n" +
                "Have a great day!\n" +
                "Best regards.";
      //gửi mail
		MailServices mailServices = new MailServices();
		mailServices.SendMail(email, title, body);
		
		return saveOrder(order);
	}

	public void updateOrder() throws ServletException, IOException {
		HttpSession session = request.getSession();
		ProductOrder order = (ProductOrder) session.getAttribute("order");

		// general info
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String country = request.getParameter("country");
		String zipcode = request.getParameter("zipcode");

		float shippingFee = Float.parseFloat(request.getParameter("shippingFee"));
		float tax = Float.parseFloat(request.getParameter("tax"));

		String paymentMethod = request.getParameter("paymentMethod");
		String orderStatus = request.getParameter("orderStatus");

		order.setFirstname(firstname);
		order.setLastname(lastname);
		order.setPhone(phone);
		order.setAddressLine1(address1);
		order.setAddressLine2(address2);
		order.setCity(city);
		order.setState(state);
		order.setCountry(country);
		order.setZipcode(zipcode);
		order.setShippingFee(shippingFee);
		order.setTax(tax);
		order.setPaymentMethod(paymentMethod);
		order.setStatus(orderStatus);

		// order details
		String[] arrayGameId = request.getParameterValues("gameId");
		String[] arrayPrice = request.getParameterValues("price");
		String[] arrayQuantity = new String[arrayGameId.length];

		for (int i = 1; i <= arrayQuantity.length; i++) {
			arrayQuantity[i - 1] = request.getParameter("quantity" + i);
		}

		Set<OrderDetail> orderDetails = order.getOrderDetails();
		orderDetails.clear();

		float totalAmount = 0.0f;
		for (int i = 0; i < arrayGameId.length; i++) {
			int gameId = Integer.parseInt(arrayGameId[i]);
			int quantity = Integer.parseInt(arrayQuantity[i]);
			float price = Float.parseFloat(arrayPrice[i]);

			float subTotal = price * quantity;

			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setProduct(new Product(gameId));
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subTotal);
			orderDetail.setProductOrder(order);

			orderDetails.add(orderDetail);

			totalAmount += subTotal;
		}

		order.setSubtotal(totalAmount);
		totalAmount += shippingFee;
		totalAmount += tax;

		order.setTotal(totalAmount);

		orderDAO.update(order);

		String message = "The order " + order.getOrderId() + " has been updated sucessfully.";

		listAllOrder(message);
	}
	public void changeOrderStatus(String status, String path, String message) throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("orderId"));
		ProductOrder order = orderDAO.get(orderId);

		order.setStatus(status);
		orderDAO.update(order);

		for(OrderDetail orderDetail : order.getOrderDetails()) {
			new JpaDAO<>().updateSize(orderDetail.getProduct().getProductId(), orderDetail.getQuantity());
		}

		request.setAttribute("message", message);
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(path);
		requestDispatcher.forward(request, response);
	}
}
