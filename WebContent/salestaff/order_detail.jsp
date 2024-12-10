<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Order Detail Administration</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="icon" type="image/x-icon" href="../images/Logo.png">
<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>

</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
	<div align="center">
		<h2 class="pageheading">Detail of Order Id: ${order.orderId}</h2>
	</div>
	<c:if test="${message != null}">
		<div align="center">
			<h4 class="message">${message}</h4>
		</div>
	</c:if>

	<div align="center">
		<h2>Order Information:</h2>
		<table>
			<tr>
				<td><b>Ordered By: </b></td>
				<td>${order.customer.fullname}</td>
			</tr>
			<tr>
				<td><b>Payment Method: </b></td>
				<td>${order.paymentMethod}</td>
			</tr>
			<tr>
				<td><b>Quantity: </b></td>
				<td>${order.productQuantities}</td>
			</tr>
			<tr>
				<td><b>Total Amount: </b></td>
				<td><fmt:formatNumber value="${order.total}" type="currency" /></td>
			</tr>
			<tr>
				<td><b>Order Status: </b></td>
				<td>${order.status}</td>
			</tr>
			<tr>
				<td><b>Order Date: </b></td>
				<td>${order.orderDate}</td>
			</tr>
		</table>
		<h2>Recipient Information:</h2>
		<table>
			<tr>
				<td><b>First Name: </b></td>
				<td>${order.firstname}</td>
			</tr>
			<tr>
				<td><b>Last Name: </b></td>
				<td>${order.lastname}</td>
			</tr>
			<tr>
				<td><b>Phone: </b></td>
				<td>${order.phone}</td>
			</tr>

			<tr>
				<td><b>Primary Address: </b></td>
				<td>${order.addressLine1}</td>
			</tr>
			<tr>
				<td><b>Secondary Address: </b></td>
				<td>${order.addressLine2}</td>
			</tr>
			<tr>
				<td><b>City: </b></td>
				<td>${order.city}</td>
			</tr>
			<tr>
				<td><b>State: </b></td>
				<td>${order.state}</td>
			</tr>
			<tr>
				<td><b>Country: </b></td>
				<td>${order.countryName}</td>
			</tr>
			<tr>
				<td><b>Zip Code: </b></td>
				<td>${order.zipcode}</td>
			</tr>
		</table>
	</div>
	<div>
		<h2 align = "center">Order Item(s):</h2>
		<table
			class="table custom-table caption-top table-success table-hover table-bordered">
			<tr>
				<th>No</th>
				<th colspan="2">Product</th>
				<th>Developer</th>
				<th>Publisher</th>
				<th>Quantity</th>
				<th>Price</th>
				<th>Subtotal</th>
			</tr>
			<c:forEach items="${order.orderDetails}" var="orderDetail"
				varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>
						<img src="${orderDetail.product.image}" style="width: 150px; height: 100px; object-fit: cover;">
					</td>
					<td>${orderDetail.product.productName}</td>
					<td>${orderDetail.product.brand}</td>
					<td>${orderDetail.product.code}</td>
					<td>${orderDetail.quantity}</td>
					<td><fmt:formatNumber value="${orderDetail.product.sellingPrice}"
							type="currency" /></td>

					<td><fmt:formatNumber value="${orderDetail.subtotal}"
							type="currency" /></td>
				</tr>
			</c:forEach>
			<tr align = "right">
				<td colspan="8" align="right">
					<p align = "right">
						Subtotal:
						<fmt:formatNumber value="${order.subtotal}" type="currency" />
					</p>
					<p align = "right">
						Tax:
						<fmt:formatNumber value="${order.tax}" type="currency" />
					</p>
					<p align = "right">
						Shipping Fee:
						<fmt:formatNumber value="${order.shippingFee}" type="currency" />
					</p>
					<p align = "right">
						Total:
						<fmt:formatNumber value="${order.total}" type="currency" />
					</p>
				</td>
			</tr>
		</table>
	</div>
	<div align="center">
		<a href="edit_order?id=${order.orderId}">Edit</a> &nbsp; <a
			href="javascript:void(0);" class="deleteLink" id="${order.orderId}">Delete</a>
	</div>
	<jsp:directive.include file="footer.jsp" />
	</div>
	<script>
		$(document)
				.ready(
						function() {
							$(".deleteLink")
									.each(
											function() {
												$(this)
														.on(
																"click",
																function() {
																	reviewId = $(
																			this)
																			.attr(
																					"id");
																	if (confirm('Are you sure you want to delete the review with ID '
																			+ reviewId
																			+ '?')) {
																		window.location = 'delete_review?id='
																				+ reviewId;
																	}
																});
											});
						});
	</script>
</body>
</html>