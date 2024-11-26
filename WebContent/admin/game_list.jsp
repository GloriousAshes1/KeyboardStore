<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Product List - Legendary Games Administration</title>
		<link rel = "stylesheet" href = "../css/style.css">
		<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	</head>
	<body>
		<jsp:directive.include file="header.jsp"/>
		<div align="center">
			<h2 class="page-heading">Games Management</h2>
			<a href="new_game">Create new product</a>
		</div>
		
		<c:if test="${message != null}">
			<div align="center">
				<h4><i>${message}</i></h4>
			</div>
		</c:if>
		
		<div align="center">
			<table class="table custom-table caption-top table-success table-hover table-bordered" border="1" cellpadding="5">
			<caption>List of products</caption>
			<thread>
				<tr>
					<th>Index</th>
					<th>ID</th>
					<th>Image</th>
					<th>Title</th>
					<th>Developer</th>
					<th>Publisher</th>
					<th>Category</th>
					<th>Price</th>
					<th>Publish date</th>
					<th>Last Updated</th>
					<th>Actions</th>
				</tr>
				</thread>
				<c:forEach var ="product" items="${listProducts}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>${product.gameId}</td>
						<td>
							<img src="data:image/jpg;base64,${product.base64Image}" width="281.35" height="133.92">
						</td>
						<td>${product.title}</td>
						<td>${product.developer}</td>
						<td>${product.publisher}</td>
						<td>${product.category.name}</td>
						<td>$${product.price}</td>
						<td><fmt:formatDate pattern="dd/MM/yyyy" value='${product.publishDate}'/></td>
						<td><fmt:formatDate pattern="dd/MM/yyyy hh:mm" value='${product.lastUpdateTime}'/></td>
						<td>
							<a href="edit_game?id=${product.gameId}">Edit</a> &nbsp;
							<a href="javascript:confirmDelete(${product.gameId})" id="${product.gameId}">Delete</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<jsp:directive.include file="footer.jsp"/>
		
		<script>
		function confirmDelete(gameId){
			if(confirm('Are you sure about deleting product with ID '+ gameId + '?')){
				window.location = 'delete_game?id=' + gameId;
				}
		}
		</script>
	</body>
</html>