<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"rel="stylesheet">
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="../css/menu.css">
	<link rel="stylesheet" href="../css/management_content.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<meta charset="UTF-8">

</head>
<body>
<div class="sidebar">
	<a class="navbar-brand" href="${pageContext.request.contextPath}/admin/">
		<img src="../images/Logo.png" height="40" width = "40" alt="Store Logo" />
	</a>
	<div class="menu-item">
		<img src="../images/user.png" alt="User Icon">
		<a href="list_users">User</a>
	</div>
	<div class="menu-item">
		<img src="../images/category.png" alt="Category Icon">
		<a href="list_category">Category</a>
	</div>
	<div class="menu-item">
		<img src="../images/product.png" alt="Product Icon">
		<a href="list_games">Product</a>
	</div>
	<div class="menu-item">
		<img src="../images/customer.png" alt="Customer Icon">
		<a href="list_customer">Customer</a>
	</div>
	<div class="menu-item">
		<img src="../images/review.png" alt="Review Icon">
		<a href="list_review">Review</a>
	</div>
	<div class="menu-item">
		<img src="../images/order.png" alt="Order Icon">
		<a href="list_order">Order</a>
	</div>
	<div class="menu-item">
		<img src="../images/import.png" alt="Import Icon">
		<a href="#import">Import</a>
	</div>
	<div class="menu-item">
		<img src="../images/import.png" alt="Statistic Icon">
		<a href="#statistic">Statistic</a>
	</div>
	<div >
		Welcome, <c:out value="${sessionScope.useremail}" />
	</div>
	<div class="logout">
		<a href="logout">Log Out</a>
	</div>
</div>
</body>
