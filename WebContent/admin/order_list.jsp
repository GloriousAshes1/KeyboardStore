<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="head.jsp"/>
	<title>Manage Order - Legendary Games Administration</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
		<h1 align="center">Orders Management</h1>
		<!-- Add Notificaiton -->
		<jsp:directive.include file="notification.jsp"/>

		<div class="d-flex justify-content-between align-items-center mb-3">
			<!-- Add Search -->
			<input class="form-control" id="myInput" type="text" placeholder="Search..">

		</div>

		<!-- Set Page -->
		<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
		<c:set var="itemsPerPage" value="10" />
		<c:set var="totalItems" value="${listOrder != null ? listOrder.size() : 0}" />
		<c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
		<c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
		<c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />

		<!-- Table -->
		<table id="orderTable" class="table table-hover table-striped caption-top">
			<thead class="table-primary">
			<tr>
				<th scope="col">No</th>
				<th scope="col">Order ID</th>
				<th scope="col">Ordered by</th>
				<th scope="col">Total</th>
				<th scope="col">Payment method</th>
				<th scope="col">Status</th>
				<th scope="col">Order Date</th>
				<th scope="col">Actions</th>
			</tr>
			</thead>
			<tbody id="myTable">
			<c:forEach var="order" items="${listOrder}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${order.orderId}</td>
					<td>${order.customer.fullname}</td>
					<td><fmt:formatNumber value="${order.total}" type="currency" /></td>
					<td>${order.paymentMethod}</td>
					<td>${order.status}</td>
					<td>${order.orderDate}</td>
					<td>
						<a href="view_order?id=${order.orderId}"><i class="fa-solid fa-circle-info" style="color: mediumslateblue;"></i></a>&nbsp;
						<a href="edit_order?id=${order.orderId}"><i class="fa-solid fa-pen-to-square" style="color: mediumslateblue;"></i></a>&nbsp;
						<a href="javascript:void(0);" class="deleteLink" id="${order.orderId}"><i class="fa-solid fa-trash" style="color: mediumslateblue;"></i></a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<!-- Page navigation -->
		<jsp:directive.include file="page_navigation.jsp" />
		<jsp:directive.include file="footer.jsp" />
	</div>
	<script>
		$(document).ready(function() {
			$(".deleteLink").each(function() {
				$(this).on("click", function() {
					orderId = $(this).attr("id");
					if (confirm('Are you sure you want to delete the order with ID ' +  orderId + '?')) {
						window.location = 'delete_order?id=' + orderId;
					}
				});
			});
		});

		$(document).ready(function () {
			$('#orderTable').DataTable({
				"pageLength": 10, // Số dòng hiển thị mỗi trang
				"lengthMenu": [5, 10, 25, 50], // Các tùy chọn hiển thị
				"order": [[0, "asc"]] // Sắp xếp theo cột đầu tiên
			});

			// Xử lý sự kiện xóa
			$(".deleteLink").on("click", function () {
				const orderId = $(this).attr("id");
				if (confirm('Are you sure you want to delete the order with ID ' + orderId + '?')) {
					window.location = 'delete_order?id=' + orderId;
				}
			});
		});

		$(document).ready(function(){
			$("#myInput").on("keyup", function() {
				var value = $(this).val().toLowerCase();
				$("#myTable tr").filter(function() {
					$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
				});
			});
		});
	</script>
</body>
</html>