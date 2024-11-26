<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer List - Legendary Product Store Administration</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="icon" type="image/x-icon" href="../images/Logo.png">
<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div align="center">
		<h2 class="page-heading">Customer Management</h2>
		<a href="new_customer">Create new customer</a>
	</div>

	<c:if test="${message != null}">
		<div align="center">
			<h4 class="message">${message}</h4>
		</div>
	</c:if>

	<div align="center">
		<table class="table custom-table caption-top table-success table-hover table-bordered" border="1" cellpadding="5">
			<caption>List of customers</caption>
			<thread>
			<tr>
				<th>Index</th>
				<th>ID</th>
				<th>E-mail</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>City</th>
				<th>State</th>
				<th>Country</th>
				<th>Register Date</th>
				<th>Actions</th>
			</tr>
			</thread>
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
					<td><a href="edit_customer?id=${customer.customerId}">Edit</a>
						&nbsp; <a href="javascript:confirmDelete(${customer.customerId})">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<jsp:directive.include file="footer.jsp" />

	<script type="text/javascript">
		function confirmDelete(customerId) {
			if (confirm('Are you sure you want to delete cusgtomer with ID '
					+ customerId + '?')) {
				window.location = 'delete_customer?id=' + customerId;
			}
		}
	</script>
</body>
</html>