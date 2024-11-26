<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Legendary Games</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link rel="icon" type="image/x-icon" href="images/Logo.png">
	<link rel="stylesheet" href="css/home_style.css"/>
	<link rel="stylesheet" href="css/styleguide.css" />
	<link rel="stylesheet" href="css/product_style.css"/>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<section class="product-showcase">
		<h2 class="section-title">New Arrival</h2>
		<div class="product-grid">
<c:forEach items="${listNewProducts}" var="product">
			<article class="product-card">
				<a href="view_product?id=${product.productId}"><img src="${product.image}" alt="Product image" class="product-image" loading="lazy" /></a>
				<div class="product-content">
					<a href="view_product?id=${product.productId}"><h3 class="product-name">${product.productName}</h3></a>
					<p class="product-price"><fmt:formatNumber value="${product.sellingPrice}" type="currency"/></p>
					<p class="product-description">${product.description}</p>
				</div>
			</article>
</c:forEach>
		</div>
		<h2 class="section-title">Best-selling</h2>
		<div class="product-grid">
<c:forEach items="${listBestSellingProducts}" var="product">
	<article class="product-card">
		<a href="view_product?id=${product.productId}"><img src="${product.image}" alt="Product image" class="product-image" loading="lazy" /></a>
		<div class="product-content">
			<a href="view_product?id=${product.productId}"><h3 class="product-name">${product.productName}</h3></a>
			<p class="product-price"><fmt:formatNumber value="${product.sellingPrice}" type="currency"/></p>
			<p class="product-description">${product.description}</p>
		</div>
	</article>
</c:forEach>
		</div>
		<h2 class="section-title">Most-favored</h2>
		<div class="product-grid">
<c:forEach items="${listMostFavoredProducts}" var="product">
	<article class="product-card">
		<a href="view_product?id=${product.productId}"><img src="${product.image}" alt="Product image" class="product-image" loading="lazy" /></a>
		<div class="product-content">
			<a href="view_product?id=${product.productId}"><h3 class="product-name">${product.productName}</h3></a>
			<p class="product-price"><fmt:formatNumber value="${product.sellingPrice}" type="currency"/></p>
			<p class="product-description">${product.description}</p>
		</div>
	</article>
</c:forEach>
		</div>
	</section>
	<jsp:directive.include file="footer.jsp" />
</body>
</html>
