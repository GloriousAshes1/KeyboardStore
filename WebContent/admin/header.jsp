<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<meta charset="UTF-8">
	<style>
		.custom-table {
			width: 70%;
			table-layout: auto;
			margin: 0 auto;
		}
		.custom-table th, .custom-table td {
			text-align: center;
		}
		.page-heading {
			margin-top: 20px;
		}
		.message {
			margin-top: 10px;
			color: green;
		}
		.navbar-custom {
			background-color: #343a40;
		}

		.nav-link, .navbar-brand {
			color: #ffa500 !important;
		}

		.nav-link:hover {
			color: #ffffff !important;
		}
		.form-control {
            height: 45px;
        }
        <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .container h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }
        .container h2 {
            margin: 10px 0;
            font-size: 18px;
            color: #555;
        }
        .message {
            color: red;
            font-size: 14px;
        }
        form {
            margin-top: 20px;
        }
        table {
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 10px;
        }
        td {
            text-align: left;
            padding: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 200px;
            padding: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</style>
</head>
	<body>
	<div align="center">
	<nav class="navbar navbar-expand-lg navbar-custom">
		<div class="container-fluid">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/admin/">
				<img src="../images/Logo.png" height="40" width = "40" alt="Store Logo" />
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
      			<span class="navbar-toggler-icon"></span>
   	 		</button>
			<div class="collapse navbar-collapse" id="navbarScroll">
				<ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px;">
						<li class="nav-item"><div class="nav-link">Welcome, <c:out value="${sessionScope.useremail}" /></div></li>
						 <li class="nav-item"><a class="nav-link" href="logout">Log out</a></li>
						 </ul>
			</div>
		</div>
	</nav>
	<div id="header-menu">
		<div class ="menu-items">
			<a href="list_users">
				<img src ="../images/user.jpg"/><br>Users
			</a>
		</div>
		<div class ="menu-items">
			<a href="list_category">
				<img src ="../images/category.jpg"/><br>Categories
			</a>
		</div>
		<div class ="menu-items">
			<a href="list_games">
				<img src ="../images/product.jpg"/><br>Games
			</a>
		</div>
		<div class ="menu-items">
			<a href="list_customer">
				<img src ="../images/customer.jpg"/><br>Customers
			</a>
		</div>
		<div class ="menu-items">
			<a href="list_review">
				<img src ="../images/review.png"/><br>Reviews
			</a>
		</div>
		<div class ="menu-items">
			<a href="list_order">
				<img src ="../images/order.jpg"/><br>Orders
			</a>
		</div>
	</div>
	</div>
	</body>
