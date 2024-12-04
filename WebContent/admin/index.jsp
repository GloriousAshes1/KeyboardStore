<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>Legendary Games Administration</title>
	<jsp:include page="head.jsp"/>
</head>
<body>
<jsp:directive.include file="header.jsp" />
<div class="content">
<div align="center">
	<hr width="60%" />
	<h1><b>Administrative Dashboard</b></h1>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<h3>Total Product: ${totalProducts}</h3>
		<h3>Total Customer: ${totalCustomers}</h3>
		<h3>Total Order: ${totalOrders}</h3>
	</div>
</div>
<div align="center">
	<div class="row mb-5 ">
		<div class="col-md-7 text-center"></div>
		<div class="col-md-15 text-left">
			<h2 class="page-heading">Revenue</h2>
			<hr class="w-50 mx-auto">
			<div id="chart"></div>
			<div> <h3>Gross Revenue: ${totalSales}</h3></div>
		</div>
	</div>

	<div align="center">
		<hr width="60%" />
		<h2 class="page-heading">Recent Sales:</h2>
		<table class="table table-hover table-striped caption-top">
			<thead class="table-primary">
			<tr>
				<th scope="col">Order ID</th>
				<th scope="col">Ordered By</th>
				<th scope="col">Quantity</th>
				<th scope="col">Total</th>
				<th scope="col">Payment Method</th>
				<th scope="col">Status</th>
				<th scope="col">Order Date</th>
			</tr>
			</thead>
			<tbody id="myTable">
			<c:forEach var="order" items="${listMostRecentSales}" varStatus="status">
				<tr>
					<td>
						<a href="view_order?id=${order.orderId}" class="text-decoration-none">
								${order.orderId}
						</a>
					</td>
					<td>${order.customer.fullname}</td>
					<td>${order.productQuantities}</td>
					<td>
						<fmt:formatNumber value="${order.total}" type="currency" />
					</td>
					<td>${order.paymentMethod}</td>
					<td>${order.status}</td>
					<td>${order.orderDate}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div align="center">
		<hr width="60%" />
		<h2 class="page-heading">Recent Reviews:</h2>
		<table class="table table-hover table-striped caption-top">
			<thead class="table-primary">
				<tr>
					<th scope="col">Product</th>
					<th scope="col">Rating</th>
					<th scope="col">Headline</th>
					<th scope="col">Customer</th>
					<th scope="col">Review On</th>
				</tr>
			</thead>
			<c:forEach var="review" items="${listMostRecentReview}" varStatus="status">
				<tbody id="myTable">
				<tr>
					<td>${review.product.productName}</td>
					<td>${review.rating}</td>
					<td><a href="edit_review?id=${review.reviewId}">${review.headline}</a></td>
					<td>${review.customer.fullname}</td>
					<td>${review.reviewTime}</td>
				</tr>
				</tbody>
			</c:forEach>
		</table>
	</div>

</div>
<jsp:directive.include file="footer.jsp" />
</div>
<script>

	// Cấu hình cho biểu đồ
	var options = {
		series: [${totalSubToTal}, ${totalTax}, ${totalShippingFee}],
		chart: {
			width: 380,
			type: 'pie',
		},
		labels: ['Net Revenue', 'Tax', 'Shipping Fee'],
		responsive: [{
			breakpoint: 480,
			options: {
				chart: {
					width: 320
				},
				legend: {
					position: 'bottom'
				}
			}
		}]
	};
	// Vẽ biểu đồ
	var chart = new ApexCharts(document.querySelector("#chart"), options);
	chart.render();
</script>
</body>
</html>