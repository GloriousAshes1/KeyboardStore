<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="baseUrl" value="/KeyboardStore/admin/list_products" />
<!DOCTYPE html>
<html>
<head>
	<title>Product List - Legendary Keyboard Administration</title>
	<jsp:include page="head.jsp"/>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	<div class="content">
		<h1 align="center">Product Management</h1>
		<jsp:directive.include file="notification.jsp"/>
		<div class="d-flex justify-content-between align-items-center mb-3">
		<!-- Search Form -->
			<input class="form-control" id="myInput" type="text" placeholder="Search..">
		</div>
		<!-- Set Page -->
		<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
		<c:set var="itemsPerPage" value="10" />
		<c:set var="totalItems" value="${listProducts != null ? listProducts.size() : 0}" />
		<c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
		<c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
		<c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />
		<table class="table table-striped table-hover caption-top">
			<thead class="table-primary">
				<tr>
					<th scope="col">Index</th>
					<th scope="col">ID</th>
					<th scope="col">Image</th>
					<th scope="col">Name</th>
					<th scope="col">Brand</th>
					<th scope="col">Code</th>
					<th scope="col">Category</th>
					<th scope="col">Selling Price</th>
					<th scope="col">Import Price</th>
					<th scope="col">Publish date</th>
				</tr>
			</thead>
			<tbody id="myTable">
				<c:forEach var ="product" items="${listProducts}" varStatus="status">
					<c:if test="${status.index >= startIndex && status.index < endIndex}">
						<tr>
							<td>${status.index+1}</td>
							<td>${product.productId}</td>
							<td>
								<img src="${product.image}" style="width: 150px; height: 100px; object-fit: cover;" alt="ProductImage">
							</td>
							<td>${product.productName}</td>
							<td>${product.brand}</td>
							<td>${product.code}</td>
							<td>${product.category.name}</td>
							<td>$${product.sellingPrice}</td>
							<td>$${product.importPrice}</td>
							<td><fmt:formatDate pattern="dd/MM/yyyy" value='${product.publishDate}'/></td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<!-- Page navigation -->
		<jsp:directive.include file="page_navigation.jsp" />
		<jsp:directive.include file="footer.jsp"/>
	</div>

	<script>
		function confirmDelete(productId){
			if(confirm('Are you sure about deleting product with ID '+ productId + '?')){
				window.location = 'delete_product?id=' + productId;
			}
		}

		$(document).ready(function(){
			$("#myInput").on("keyup", function() {
				var value = $(this).val().toLowerCase();
				$("#myTable tr").filter(function() {
					$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
				});
			});
		});

	</script>
</body>
</html>