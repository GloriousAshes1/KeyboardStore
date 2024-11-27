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
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<div class="content">
	<h1 align="center">Product Management</h1>
	<a href="new_product">Create new product</a>

<c:if test="${message != null}">
	<div align="center">
		<h4><i>${message}</i></h4>
	</div>
</c:if>
</div>

<div class="content">
	<table class="table table-hover">
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