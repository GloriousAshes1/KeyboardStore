<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Category List - Legendary Games Administration</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	<div class="content">
	<div align="center">
		<h1>Category Management</h1>
		<div class="d-flex justify-content-between align-items-center mb-3">
			<!-- Search Form -->
			<form method="GET" action="#search_cat" style="margin-bottom: 20px;">
				<input type="text" name="query" placeholder="Search..." style="padding: 10px; width: 300px;">
				<button class="btn-search" type="submit">Search</button>
			</form>
			<!-- Add Category Button -->
			<form method="GET" action="new_category">
				<button type="submit" class="btn-add">+ Add Category</button>
			</form>
		</div>
	</div>
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
		<table class= "custom-table table-hover table-bordered">
		<thead>
			<tr>
				<th>Index</th>
				<th>ID</th>
				<th>Name</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var ="cat" items="${listCategory}" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${cat.categoryId}</td>
					<td>${cat.name}</td>
					<td>
						<a href="edit_category?id=${cat.categoryId}">Edit</a> &nbsp;
						<a href="javascript:confirmDelete(${cat.categoryId})">Delete</a></td>
					</td>
				</tr>
			</c:forEach>
		</table>
	<jsp:directive.include file="footer.jsp"/>
	</div>
	
	<script type="text/javascript">
		function confirmDelete(categoryId) {
			if (confirm('Are you sure you want to delete category with ID '
					+ categoryId + '?')) {
				window.location = 'delete_category?id=' + categoryId;
			}
		}
	</script>
</body>
</html>