<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"rel="stylesheet">
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="../css/toastr_noti.css">
	<link rel="stylesheet" href="../css/menu.css">
	<link rel="stylesheet" href="../css/management_content.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<meta charset="UTF-8">

</head>
<body>
<div class="sidebar">
<div class="logo">
	<a class="d-flex align-items-center" href="${pageContext.request.contextPath}/admin/" ><img src="../images/Logo.png" height="40" width = "40" alt="Store Logo" />Keyboard Store</a>
</div>
	<div class="menu-title">Quick Access</div>
	<div class="quick-access">
		<ul>
			<li><a href="list_users" class="d-flex align-items-center"><img src="../images/user.png" alt="User Icon">User</a></li>
			<li><a href="list_category" class="d-flex align-items-center"><img src="../images/category.png" alt="Category Icon">Category</a></li>
			<li><a href="list_products" class="d-flex align-items-center"><img src="../images/product.png" alt="Product Icon">Product</a></li>
			<li><a href="list_customer" class="d-flex align-items-center"><img src="../images/customer.png" alt="Customer Icon">Customer</a></li>
			<li><a href="list_review" class="d-flex align-items-center"><img src="../images/review.png" alt="Review Icon">Review</a></li>
			<li><a href="list_order" class="d-flex align-items-center"><img src="../images/order.png" alt="Order Icon">Order</a></li>
			<li><a href="#import" class="d-flex align-items-center"><img src="../images/import.png" alt="Import Icon">Import</a></li>
			<li><a href="#statistic" class="d-flex align-items-center"><img src="../images/review.png" alt="Statistic Icon">Statistic</a></li>
		</ul>
		<p>Welcome, <c:out value="${sessionScope.useremail}" /></p>
	</div>
	<div class="sidebar-footer">
		<a href="logout">Log Out</a>
	</div>
</div>
</body>
