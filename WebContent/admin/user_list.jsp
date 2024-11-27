<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>User List - Legendary Games Administration</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="content">
	<h1 align="center">User Management</h1>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<!-- Search Form -->
		<form method="GET" action="search_user" style="margin-bottom: 20px;">
			<input type="text" name="query" placeholder="Search..." style="padding: 10px; width: 300px;">
			<button class="btn-search" type="submit">Search</button>
		</form>
		<!-- Add User Button -->
		<form method="GET" action="new_user">
			<button type="submit" class="btn-add">+ Add User</button>
		</form>
	</div>
	<!-- Toastr Notifications -->
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

	<!-- User List Table -->
	<table class="table table-hover">
		<thead>
		<tr>
			<th>Index</th>
			<th>ID</th>
			<th>Email</th>
			<th>Full Name</th>
			<th>Role</th>
			<th>Actions</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="user" items="${listUsers}" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td>${user.userId}</td>
				<td>${user.email}</td>
				<td>${user.fullName}</td>
				<td>Staff</td>
				<td>
					<a href="edit_user?id=${user.userId}">Edit</a> &nbsp;
					<a href="javascript:confirmDelete(${user.userId})">Delete</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<jsp:directive.include file="footer.jsp"/>
</div>

<!-- Confirm Delete Script -->
<script>
	function confirmDelete(userId) {
		if (confirm('Are you sure you want to delete user with ID: ' + userId + '?')) {
			window.location = 'delete_user?id=' + userId;
		}
	}
</script>
</body>
</html>