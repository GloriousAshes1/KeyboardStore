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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<c:if test="${message != null}">
		<script type="text/javascript">
			$(document).ready(function() {
				var messageType = '${messageType}';
				var message = '${message}';

				// Ensure that the message and messageType are properly escaped in JavaScript context
				message = message.replace(/'/g, "\\'");
				messageType = messageType.replace(/'/g, "\\'");
				toastr.options = {
					"closeButton": true,
					"debug": false,
					"newestOnTop": true,
					"progressBar": true,
					"positionClass": "toast-top-right",
					"preventDuplicates": true,
					"showDuration": "300",
					"hideDuration": "1000",
					"timeOut": "5000",
					"extendedTimeOut": "1000",
					"showEasing": "swing",
					"hideEasing": "linear",
					"showMethod": "fadeIn",
					"hideMethod": "fadeOut"
				};
				if (messageType === 'success') {
					toastr.success(message);
				} else if (messageType === 'error') {
					toastr.error(message);
				} else if (messageType === 'warning') {
					toastr.warning(message);
				} else if (messageType === 'info') {
					toastr.info(message);
				}
			});
		</script>
	</c:if>
	<div class="content">
		<h1 align="center">Customer Management</h1>
		<div class="d-flex justify-content-between align-items-center mb-3">
			<!-- Search Form -->
			<form method="GET" action="#search_user" style="margin-bottom: 20px;">
				<input type="text" name="query" placeholder="Search..." style="padding: 10px; width: 300px;">
				<button class="btn-search" type="submit">Search</button>
			</form>
			<!-- Add User Button -->
			<form method="GET" action="new_customer">
				<button type="submit" class="btn-add">+ Add Customer</button>
			</form>
		</div>

		<table class="custom-table table-hover table-bordered">
			<thead>
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
			</thead>
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
	<jsp:directive.include file="footer.jsp" />
	</div>
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