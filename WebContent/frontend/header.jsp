<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<style type="text/css">
.navbar-custom {
	background-color: #343a40;
}

.nav-link, .navbar-brand {
	color: #ffa500 !important;
}

.nav-link:hover {
	color: #ffffff !important;
}
</style>
<title>Legendary Games</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-custom">
		<div class="container-fluid">
			<a class="navbar-brand" href="${pageContext.request.contextPath}">
				<img src="images/Logo.png" height="40"
				width="40" alt="Store Logo" />
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarScroll"
				aria-controls="navbarScroll" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarScroll">
				<ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll"
					style="--bs-scroll-height: 100px;">
					<c:if test="${loggedCustomer == null}">
						<li class="nav-item"><a class="nav-link" href= "login">Sign in</a></li>
						<li class="nav-item"><a class="nav-link" href= "register">Sign up</a></li>
					</c:if>
					<c:if test="${loggedCustomer != null}">
						<li class="nav-item"><a class="nav-link" href="view_profile">Welcome,
								${loggedCustomer.fullname}</a></li>
						<li class="nav-item"><a class="nav-link" href="view_orders">My
								orders</a></li>
						<li class="nav-item"><a class="nav-link" href="logout">Log
								out</a></li>
					</c:if>
					<li class="nav-item"><a class="nav-link" href="view_cart">Cart</a>
					</li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Categories </a>
						<ul class="dropdown-menu">
							<c:forEach var="category" items="${listCategory}">
								<li><a class="dropdown-item"
									href="view_category?id=${category.categoryId}">${category.name}</a></li>
							</c:forEach>
						</ul></li>
				</ul>
				<form class="d-flex" role="search" action="search" method="get">
					<input class="form-control me-2" type="text" name="keyword"
						placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success" type="submit">Search</button>
				</form>
			</div>
		</div>
	</nav>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
</body>
</html>
