<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Game List - Legendary Games Administration</title>
	<link rel = "stylesheet" href = "../css/style.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<div class="content">
	<h1 align="center">Product Management</h1>
	<div class="d-flex justify-content-between align-items-center mb-3">
		<!-- Search Form -->
		<form method="GET" action="search_product" style="margin-bottom: 20px;">
			<input type="text" name="query" placeholder="Search..." style="padding: 10px; width: 300px;">
			<button class="btn-search" type="submit">Search</button>
		</form>
		<!-- Add User Button -->
		<form method="GET" action="new_product">
			<button type="submit" class="btn-add">+ Add Product</button>
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
	<table class="custom-table table-hover">
		<thead>
			<tr>
				<th>Index</th>
				<th>ID</th>
				<th>Image</th>
				<th>Name</th>
				<th>Brand</th>
				<th>Code</th>
				<th>Category</th>
				<th>Selling Price</th>
				<th>Publish date</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var ="product" items="${listProducts}" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td>${product.productId}</td>
				<td>
					<img src="${product.image}" width="281.35" height="133.92" alt="ProductImage">
				</td>
				<td>${product.productName}</td>
				<td>${product.brand}</td>
				<td>${product.code}</td>
				<td>${product.category.name}</td>
				<td>$${product.sellingPrice}</td>
				<td><fmt:formatDate pattern="dd/MM/yyyy" value='${product.publishDate}'/></td>
				<td>
					<a href="edit_product?id=${product.productId}">Edit</a> &nbsp;
					<a href="javascript:confirmDelete(${product.productId})" id="${product.productId}">Delete</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<jsp:directive.include file="footer.jsp"/>
</div>

<script>
	function confirmDelete(productId){
		if(confirm('Are you sure about deleting product with ID '+ productId + '?')){
			window.location = 'delete_product?id=' + productId;
		}
	}
</script>
</body>
</html>