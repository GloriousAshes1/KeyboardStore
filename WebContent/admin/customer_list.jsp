<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Customer List - Legendary Product Store Administration</title>
	<jsp:include page="head.jsp"/>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
		<h1 align="center">Customer Management</h1>
		<!-- Add Notificaiton -->
		<jsp:directive.include file="notification.jsp"/>

		<div class="d-flex justify-content-between align-items-center mb-3">
			<!-- Add Search -->
			<input class="form-control" id="myInput" type="text" placeholder="Search..">

			<!-- Add Category Button -->
			<form method="GET" action="new_customer">
				<button type="submit" class="btn-add">+ Add Customer</button>
			</form>
		</div>
		<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
		<c:set var="itemsPerPage" value="10" />
		<c:set var="totalItems" value="${listCustomer != null ? listCustomer.size() : 0}" />
		<c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
		<c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
		<c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />

		<table class="table table-hover table-striped caption-top">
			<thead class="table-primary">
			<tr>
				<th scope="col">Index</th>
				<th scope="col">ID</th>
				<th scope="col">E-mail</th>
				<th scope="col">First Name</th>
				<th scope="col">Last Name</th>
				<th scope="col">City</th>
				<th scope="col">State</th>
				<th scope="col">Country</th>
				<th scope="col">Register Date</th>
				<th scope="col">Actions</th>
			</tr>
			</thead>
			<tbody id="myTable">
			<c:forEach var="customer" items="${listCustomer}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${customer.customerId}</td>
					<td>${customer.email}</td>
					<td>${customer.lastname}</td>
					<td>${customer.firstname}</td>
					<td>${customer.city}</td>
					<td>${customer.state}</td>
					<td>${customer.countryName}</td>
					<td>${customer.registerDate}</td>
					<td><a href="edit_customer?id=${customer.customerId}"><i class="fa-solid fa-pen-to-square" style="color: mediumslateblue;"></i></a> &nbsp;
						&nbsp; <a href="javascript:confirmDelete(${customer.customerId})"><i class="fa-solid fa-trash" style="color: mediumslateblue;"></i></a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	<!-- Page Navigation -->
	<jsp:directive.include file="page_navigation.jsp"/>
	<jsp:directive.include file="footer.jsp" />
	</div>

	<script type="text/javascript">
		function confirmDelete(customerId) {
			if (confirm('Are you sure you want to delete cusgtomer with ID '
					+ customerId + '?')) {
				window.location = 'delete_customer?id=' + customerId;
			}
		}

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