<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Manage Order - Legendary Games Administration</title>
	<link rel="stylesheet" href="../css/style.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
		<h1 align="center">Orders Management</h1>

		<c:if test="${message != null}">
			<div align="center">
				<h4 class="message">${message}</h4>
			</div>
		</c:if>

		<c:if test="${message != null}">
			<script>
				$(document).ready(function() {
					toastr.options = {
						closeButton: true,
						debug: false,
						newestOnTop: true,
						progressBar: true,
						positionClass: "toast-top-right",
						preventDuplicates: true,
						showDuration: "300",
						hideDuration: "1000",
						timeOut: "5000",
						extendedTimeOut: "1000",
						showEasing: "swing",
						hideEasing: "linear",
						showMethod: "fadeIn",
						hideMethod: "fadeOut"
					};

					const messageType = "${messageType}";
					const message = "${message}";

					if (messageType === "success") toastr.success(message);
					else if (messageType === "error") toastr.error(message);
					else if (messageType === "warning") toastr.warning(message);
					else if (messageType === "info") toastr.info(message);
				});
			</script>
		</c:if>

			<table class="custom-table table-hover table-bordered">
				<thead>
				<tr>
					<th>No</th>
					<th>Order ID</th>
					<th>Ordered by</th>
<%--					<th>Quantity</th>--%>
					<th>Total</th>
					<th>Payment method</th>
					<th>Status</th>
					<th>Order Date</th>
					<th>Actions</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="order" items="${listOrder}" varStatus="status">
					<tr>
						<td>${status.index +1}</td>
						<td>${order.orderId}</td>
						<td>${order.customer.fullname}</td>
<%--						<td>${order.gameQuantities}</td>--%>
						<td><fmt:formatNumber value="${order.total}" type="currency" /></td>
						<td>${order.paymentMethod}</td>
						<td>${order.status}</td>
						<td>${order.orderDate}</td>
						<td><a href="view_order?id=${order.orderId}">Details</a>&nbsp;
							<a href="edit_order?id=${order.orderId}">Edit</a> &nbsp;
					</tr>
				</c:forEach>
				</tbody>
			</table>
		<jsp:directive.include file="footer.jsp" />
	</div>
</body>
</html>