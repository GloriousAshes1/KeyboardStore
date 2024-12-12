<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Search - Keyboard Store</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	<div class ="container my-4">
		<div class="text-center mb-4">
            <c:if test="${fn:length(result) == 0}">
				<h2>No Results for "${keyword}"</h2>
			</c:if>
			<c:if test="${fn:length(result) > 0}">
				<h2>Results for "${keyword}"</h2>
			<div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${result}" var="product">
                <div class="col">
                    <div class="card h-100">
                    	<a href="view_product?id=${product.productId}">
                    		<img src="${product.image}" class="card-img-top" alt="${product.productName}" style="width: 354px; height: 555px; object-fit: contain">
                    	</a>
                        <div class="card-body">
                            <h5 class="card-title"><a href="view_product?id=${product.productId}"> <b>${product.productName}</b></a></h5>
                            <p class="card-text product-description" data-product-id="${product.productId}">
                                ${product.description}
                            </p>
                            <p class="card-text"><strong>$${product.sellingPrice}</strong></p>
                            <jsp:directive.include file="product_rating.jsp" />
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        </c:if>
        </div>
	</div>
	<jsp:directive.include file="footer.jsp"/>
</body>
</html>