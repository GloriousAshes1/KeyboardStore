<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<title>User List - Legendary Games Administration</title>
	<jsp:include page="head.jsp"/>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="content">
	<h1 align="center">User Management</h1>
	<!-- Add Notification -->
	<jsp:directive.include file="notification.jsp"/>

	<div class="d-flex justify-content-between align-items-center mb-3">
		<!-- Add Search -->
		<input class="form-control" id="myInput" type="text" placeholder="Search..">

		<!-- Add Category Button -->
		<form method="GET" action="new_user">
			<button type="submit" class="btn-add">+ Add User</button>
		</form>
	</div>

	<!-- Table -->
	<table class="table table-hover table-striped caption-top">
		<thead class="table-primary">
		<c:if test="${empty listUsers}">
			<tr>
				<td colspan="6" class="text-center">No users found.</td>
			</tr>
		</c:if>
		<tr>
			<th scope="col">Index</th>
			<th scope="col">ID</th>
			<th scope="col">Email</th>
			<th scope="col">Full Name</th>
			<th scope="col">Role</th>
			<th scope="col">Actions</th>
		</tr>
		</thead>
		<tbody id="myTable">
		<c:forEach var="user" items="${listUsers}" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td>${user.userId}</td>
				<td>${user.email}</td>
				<td>${user.fullName}</td>
				<td>${user.role}</td>
				<td>
					<!-- Always allow editing -->
					<a href="edit_user?id=${user.userId}"><i class="fa-solid fa-pen-to-square" style="color: mediumslateblue;"></i></a> &nbsp;

					<!-- Set current user for comparison -->
					<c:set var="currentUser" value="${sessionScope.currentUser}" />

					<!-- Conditionally show or disable delete link -->
					<c:choose>
						<c:when test="${user.role == 'Manager' || user.userId == currentUser.userId}">
							<a href="javascript:void(0)" class="disabled-link" title="Cannot delete">
								<i class="fa-solid fa-trash" style="color: dimgray;"></i>
							</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:confirmDelete(${user.userId})">
								<i class="fa-solid fa-trash" style="color: mediumslateblue;"></i>
							</a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<jsp:directive.include file="page_navigation.jsp"/>
	<jsp:directive.include file="footer.jsp"/>
</div>

<!-- Confirm Delete Script -->
<script>
	function confirmDelete(userId) {
		if (confirm('Are you sure you want to delete user with ID: ' + userId + '?')) {
			window.location = 'delete_user?id=' + userId;
		}
	}

	$(document).ready(function () {
		$("#myInput").on("keyup", function () {
			var value = $(this).val().toLowerCase();
			$("#myTable tr").filter(function () {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
			});
		});
	});
</script>
</body>
</html>
