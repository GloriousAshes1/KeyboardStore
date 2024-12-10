<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="baseUrl" value="/KeyboardStore/admin/list_review" />
<!DOCTYPE html>
<html>
<head>
	<title>Review Management</title>
	<jsp:include page="head.jsp"/>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
		<h1 align="center">Review Management</h1>
		<!-- Add Notificaiton -->
		<jsp:directive.include file="notification.jsp"/>

		<div class="d-flex justify-content-between align-items-center mb-3">
			<!-- Add Search -->
			<input class="form-control" id="myInput" type="text" placeholder="Search..">
		</div>

		<!-- Set Page -->
		<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
		<c:set var="itemsPerPage" value="10" />
		<c:set var="totalItems" value="${listReviews != null ? listReviews.size() : 0}" />
		<c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
		<c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
		<c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />

		<table class="table table-hover table-striped caption-top">
			<thead class="table-primary">
			<tr>
				<th scope="col">Index</th>
				<th scope="col">ID</th>
				<th scope="col">Product</th>
				<th scope="col">Rating</th>
				<th scope="col">Headline</th>
				<th scope="col">Customer</th>
				<th scope="col">Review On</th>
			</tr>
			</thead>
			<tbody id="myTable">
			<c:forEach var="review" items="${listReviews}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${review.reviewId}</td>
					<td>${review.product.productName}</td>
					<td>${review.rating}</td>
					<td>${review.headline}</td>
					<td>${review.customer.fullname}</td>
					<td>${review.reviewTime}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<!-- Page navigation -->
		<jsp:directive.include file="page_navigation.jsp" />
		<jsp:directive.include file="footer.jsp" />
		</div>

	<script>
		function confirmDelete(reviewId){
			if(confirm('Are you sure about deleting review with ID '+ reviewId + '?')){
				window.location = 'delete_product?id=' + reviewId;
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