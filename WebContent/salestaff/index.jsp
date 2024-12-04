<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Legendary Games Administration</title>
	<link rel="stylesheet" href="../css/style.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
</head>
<body>
<jsp:directive.include file="header.jsp" />
<div class="content">
<div align="center">
	<hr width="60%" />
	<h2>SaleStaff Dashboard</h2>
</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="page-heading">Recent Sales:</h2>
		<table
				class="table custom-table caption-top table-success table-hover table-bordered"
				border="1" cellpadding="5">
			<thread>
				<tr>
					<th>Order ID</th>
					<th>Ordered By</th>
					<th>Quantity</th>
					<th>Total</th>
					<th>Payment Method</th>
					<th>Status</th>
					<th>Order Date</th>
				</tr>
			</thread>
			<c:forEach var="order" items="${listMostRecentSales}"
					   varStatus="status">
				<tr>
					<td><a href="view_order?id=${order.orderId}">${order.orderId}</a></td>
					<td>${order.customer.fullname}</td>
					<td>${order.productQuantities}</td>
					<td><fmt:formatNumber value="${order.total}" type="currency" /></td>
					<td>${order.paymentMethod}</td>
					<td>${order.status}</td>
					<td>${order.orderDate}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="page-heading">Recent Reviews:</h2>
		<table
				class="table custom-table caption-top table-success table-hover table-bordered"
				border="1" cellpadding="5">
			<thread>
				<tr>
					<th>Product</th>
					<th>Rating</th>
					<th>Headline</th>
					<th>Customer</th>
					<th>Review On</th>
				</tr>
			</thread>
			<c:forEach var="review" items="${listMostRecentReview}"
					   varStatus="status">
				<tr>
					<td>${review.product.productName}</td>
					<td>${review.rating}</td>
					<td><a href="edit_review?id=${review.reviewId}">${review.headline}</a></td>
					<td>${review.customer.fullname}</td>
					<td>${review.reviewTime}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</div>
<jsp:directive.include file="footer.jsp" />
</div>
</body>
</html>