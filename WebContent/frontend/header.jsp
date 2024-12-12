<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

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
	<link rel="stylesheet" href="css/mystyle.css">
<meta charset="UTF-8">

<title>KeyBoard Store</title>
</head>
<style>
	img {
		object-fit: cover;
	}
</style>
<body>
	<nav class="navbar navbar-expand-lg nav-link" style="background-color: #2579f2;">
		<div class="container-fluid">
			<a class="home" title="Trang chủ" href="${pageContext.request.contextPath}">
				<img src="images/Logo.png" height="49"
				width="49" alt="Store Logo" />
				<h4 class="mg">KeyBoard Store</h4>
			</a>
			<div class="search">
				<form role="search" action="search" method="get">
					<div class="z">
						<div class="z va">
							<input type="search" class="g input-search bd" name="keyword" placeholder="Tìm kiếm sản phẩm" autocomplete="off" value="">
							<button type="submit" class="btn-search border1" aria-label="Search"><img class="format-svg" src="css/images/search.svg"></button>
						</div>
					</div>
				</form>
			</div>
			<c:if test="${loggedCustomer == null}">
			<div class="big-ctn">
				<div class="ctn">
					<button type="button" class="profile-btn"><img class="format-svg" src="css/images/user.svg"/></button>
					<div class="login">
						<div onclick="window.location='login'">Đăng nhập</div>
						<div> / </div>
						<div onclick="window.location='register'">Đăng ký</div>
					</div>
				</div>
			</div>
			</c:if>
			<c:if test="${loggedCustomer != null}">
				<div class="big-ctn">
					<div class="ctn">
						<div class="profile-ctn">
							<button type="button" class="profile-btn" onclick="window.location='view_profile'">
								<img class="format-svg" src="css/images/user.svg"/>
							</button>
							<div class="mg" onclick="window.location='view_profile'">${loggedCustomer.fullname}</div>
						</div>
						<div><div class="mg" onclick="window.location='view_orders'">My Order</div></div>
						<div class="mg" onclick="window.location='logout'">Log out</div>
					</div>

				</div>
			</c:if>
			<div class="Xb">
				<a class="cart" href="view_cart">
						<img class="format-svg" src="css/images/cart.svg"/>
						<div class="txt">Giỏ hàng</div>
				</a>
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
