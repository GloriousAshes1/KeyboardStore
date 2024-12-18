package com.keyboardstore.service;

import com.keyboardstore.controller.frontend.shoppingcart.ShoppingCart;
import com.keyboardstore.dao.JpaDAO;
import com.keyboardstore.dao.OrderDAO;
import com.keyboardstore.entity.Customer;
import com.keyboardstore.entity.OrderDetail;
import com.keyboardstore.entity.Product;
import com.keyboardstore.entity.ProductOrder;
import com.keyboardstore.util.NominatimAPI;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.google.gson.Gson;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class OrderServices {

	private OrderDAO orderDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	private void sendEmailToCustomer(){
		//lấy email hiện tại ra
		HttpSession session = request.getSession();
		Customer loggedCustomer = (Customer) session.getAttribute("loggedCustomer");
		String email = loggedCustomer.getEmail();
		String name = loggedCustomer.getFirstname();
		String title = "Order Confirmation from KEYBOARD STORE";
		String body = formEmail(name);
		//gửi mail
		MailServices.SendMail(email,title,body);
	}

	public String formEmail(String name) {
		String form = "KEYBOARD STORE\r\n"
				+ "\r\n"
				+ "Order Confirmation and Thank You\r\n"
				+ "\r\n"
				+ "Dear " + name + ",\r\n"
				+ "\r\n"
				+ "Thank you for placing an order with KEYBOARD STORE. We are excited to process your order and ensure you receive your items as soon as possible.\r\n"
				+ "\r\n"
				+ "Order Details:\r\n"
				+ "\r\n"
				+ "Order Date: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")) + "\r\n"
				+ "Product Details:" + readOrderInfo() + "\r\n"
				+ "We appreciate your trust in us and strive to deliver the highest quality products and services. Your satisfaction is our top priority.\r\n"
				+ "\r\n"
				+ "Next Steps:\r\n"
				+ "\r\n"
				+ "You will receive a notification once your order is shipped, including tracking information.\r\n"
				+ "If you have any special instructions or need to make changes to your order, please contact us promptly.\r\n"
				+ "Customer Support:\r\n"
				+ "If you have any questions or require further assistance, our customer service team is here to help. You can reach us at keyboardstore@gmail.com or call us at 0123456789.\r\n"
				+ "\r\n"
				+ "Thank you once again for your purchase. We look forward to serving you and hope you enjoy your new items!\r\n"
				+ "\r\n"
				+ "Best regards,\r\n"
				+ "\r\n"
				+ "KEYBOARD STORE\r\n"
				+ "\r\n"
				+ "";
		return form;
	}

	public OrderServices(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.orderDAO = new OrderDAO();
	}

	public void listAllOrder() throws ServletException, IOException {
		listAllOrder(null);
	}

	public void listAllOrder(String message) throws ServletException, IOException {
		List<ProductOrder> listOrder = orderDAO.listAll();
		listOrder.sort((c1, c2) -> Integer.compare(c2.getOrderId(), c1.getOrderId()));

		request.setAttribute("listOrder", listOrder);

		if (message != null) {
			request.setAttribute("message", message);
		}

		String listPage = "order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
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
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		String address = customer.getAddressLine1() + ", " + customer.getCity() + ", " + customer.getState() + ", " + customer.getCountry();
		String origin = "Nam Kỳ Khởi Nghĩa, Vo Thi Sau Ward, District 3, Ho Chi Minh City, 70150, Vietnam";
		NominatimAPI api = new NominatimAPI();

		// tax 10%
		float tax = shoppingCart.getTotalAmount() * 0.1f;

		float distance = (float) api.calculateDistance(origin ,address);

		float shippingFee = distance * 0.1f;


		float total = shoppingCart.getTotalAmount() + tax + shippingFee;

		session.setAttribute("tax", tax);
		session.setAttribute("shippingFee", shippingFee);
		session.setAttribute("total", total);

		CommonUtility.generateCountryList(request);
		String checkOutPage = "frontend/checkout.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(checkOutPage);
		dispatcher.forward(request, response);
	}
	public float shipcal(float distance){
		if(distance < 5) {
			return distance * 0f;
		} else if (distance < 10) {
			return distance * 0.1f;
		}else if (distance < 20) {
			return distance * 0.15f;
		}else if (distance < 50) {
			return distance * 0.2f;
		}else if (distance < 100) {
			return distance * 0.25f;
		}else if (distance < 1000) {
			return 30f;
		} else if (distance < 2000) {
			return 50f;
		} else {
			return 100f;
		}
	}

	public void placeOrder() throws ServletException, IOException {
		String paymentMethod=request.getParameter("paymentMethod");
		ProductOrder order=readOrderInfo();
		System.out.println(order.getPaymentMethod());
		
		if(paymentMethod.equals("paypal")) {
			PaymentServices paymentServices = new PaymentServices(request, response);
			request.getSession().setAttribute("order4Paypal", order);
			paymentServices.authorizePayment(order);
			sendEmailToCustomer();
		}else {
			placeOrderCOD(order);
			sendEmailToCustomer();
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
		for(OrderDetail orderDetail : order.getOrderDetails()) {
			new JpaDAO<>().updateStock(orderDetail.getProduct().getProductId(), orderDetail.getQuantity());
		}
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
		order.setPaymentMethod(paymentMethod);
		order.setStatus(orderStatus);

		// order details
		String[] arrayProductId = request.getParameterValues("productId");
		String[] arrayPrice = request.getParameterValues("price");
		String[] arrayQuantity = new String[arrayProductId.length];

		for (int i = 1; i <= arrayQuantity.length; i++) {
			arrayQuantity[i - 1] = request.getParameter("quantity" + i);
		}

		Set<OrderDetail> orderDetails = order.getOrderDetails();
		orderDetails.clear();

		float totalAmount = 0.0f;
		for (int i = 0; i < arrayProductId.length; i++) {
			int gameId = Integer.parseInt(arrayProductId[i]);
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
		listOrderByCustomer();
	}

	public void showSalesReportForSpecificProduct() throws ServletException, IOException {
		Integer productId = Integer.parseInt(request.getParameter("productId"));
		Date startDate = null;
		Date endDate = null;

		// Parse the start and end dates if provided
		try {
			String startDateStr = request.getParameter("startDate");
			String endDateStr = request.getParameter("endDate");

			if (startDateStr != null && !startDateStr.isEmpty()) {
				startDate = java.sql.Date.valueOf(startDateStr);
			}
			if (endDateStr != null && !endDateStr.isEmpty()) {
				endDate = java.sql.Date.valueOf(endDateStr);
			}
		} catch (Exception e) {
			// Handle parsing exceptions
			e.printStackTrace();
		}

		List<Object[]> salesData = orderDAO.getProfitsForSpecificProduct(productId, startDate, endDate);
		request.setAttribute("salesData", salesData);
		request.setAttribute("productId", productId);  // Pass productId
		request.setAttribute("startDate", startDate);  // Pass startDate
		request.setAttribute("endDate", endDate);      // Pass endDate

		String reportPage = "admin/statistics.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(reportPage);
		dispatcher.forward(request, response);
	}

	public void showSalesReportForAllProduct() throws ServletException, IOException {
		Integer productId = null;  // Null for all products
		Date startDate = null;
		Date endDate = null;

		// Parse the start and end dates if provided
		try {
			String startDateStr = request.getParameter("startDate");
			String endDateStr = request.getParameter("endDate");

			if (startDateStr != null && !startDateStr.isEmpty()) {
				startDate = java.sql.Date.valueOf(startDateStr);
			}
			if (endDateStr != null && !endDateStr.isEmpty()) {
				endDate = java.sql.Date.valueOf(endDateStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		List<Object[]> salesData = orderDAO.getProfitsForAllProducts(startDate, endDate);
		request.setAttribute("salesData", salesData);
		request.setAttribute("productId", productId);  // Pass null for all products
		request.setAttribute("startDate", startDate);  // Pass startDate
		request.setAttribute("endDate", endDate);      // Pass endDate

		String reportPage = "admin/statistics.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(reportPage);
		dispatcher.forward(request, response);
	}


	public Double getTotalSales(Date startDate, Date endDate) {
		return orderDAO.totalSales(startDate, endDate);
	}

	public Double getTotalTax(Date startDate, Date endDate) {
		return orderDAO.totalTax(startDate, endDate);
	}

	public Double getTotalShippingFee(Date startDate, Date endDate) {
		return orderDAO.totalShippingFee(startDate, endDate);
	}

	public Double getTotalSubTotal(Date startDate, Date endDate) {
		return orderDAO.totalSubToTal(startDate, endDate);
	}
}
