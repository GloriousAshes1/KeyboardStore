<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="baseUrl" value="/KeyboardStore/admin/list_category" />
<!DOCTYPE html>
<html>
<head>
	<title>Category List - Legendary Games Administration</title>
	<jsp:include page="head.jsp"/>
</head>

<body>
	<jsp:directive.include file="header.jsp"/>
	<div class="content">
	<div align="center">
		<h1>Category Management</h1>
		<!-- Add Notificaiton -->
		<jsp:directive.include file="notification.jsp"/>

		<div class="d-flex justify-content-between align-items-center mb-3">
		<!-- Add Search -->
		<input class="form-control" id="myInput" type="text" placeholder="Search..">

		<!-- Add Category Button -->
		<form method="GET" action="new_category">
			<button type="submit" class="btn-add">+ Add Category</button>
		</form>
	</div>

		<!-- Set Page -->
		<c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
		<c:set var="itemsPerPage" value="10" />
		<c:set var="totalItems" value="${listCategory != null ? listCategory.size() : 0}" />
		<c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
		<c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
		<c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />

		<!-- Table -->
		<table class="table table-striped table-hover caption-top">
			<thead class="table-primary">
				<tr>
					<th scope="col">Index</th>
					<th scope="col">ID</th>
					<th scope="col">Name</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody id="myTable">
				<c:forEach var="cat" items="${listCategory}" varStatus="status">
					<c:if test="${status.index >= startIndex && status.index < endIndex}">
						<tr>
							<td>${status.index + 1}</td>
							<td>${cat.categoryId}</td>
							<td>${cat.name}</td>
							<td>
								<a href="edit_category?id=${cat.categoryId}"><i class="fa-solid fa-pen-to-square" style="color: mediumslateblue;"></i></a> &nbsp;
								<a href="javascript:confirmDelete(${cat.categoryId})"><i class="fa-solid fa-trash" style="color: mediumslateblue;"></i></a>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>

		<!-- Page navigation -->
		<jsp:directive.include file="page_navigation.jsp" />
		<jsp:directive.include file="footer.jsp"/>
	</div>
	</div>

	<script type="text/javascript">
		function confirmDelete(categoryId) {
			if (confirm('Are you sure you want to delete category with ID '
					+ categoryId + '?')) {
				window.location = 'delete_category?id=' + categoryId;
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