<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Category</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="icon" type="image/x-icon" href="../images/Logo.png">
<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div align="center">
		<hr width="60%" />
		<h2 class="page-heading">
			<c:if test="${category != null}">
				Edit Category
			</c:if>
			<c:if test="${category == null}">
				Create New Category
			</c:if>
		</h2>
	</div>
	<div align="center">
		<c:if test="${category != null}">
			<form class="mx-auto" id="categoryForm" action="update_category"
				method="post">
				<input type="hidden" name="categoryId"
					value="${category.categoryId}" />
		</c:if>
		<c:if test="${category == null}">
			<form class="mx-auto" id="categoryForm" action="create_category"
				method="post">
		</c:if>
		<table>
			<tr>
				<td><label>Name:</label></td>
				<td><input type="text" name="name" id="name"
					value="${category.name}" required></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button class="btn btn-primary" type="submit">Save</button>
					<button class="btn btn-secondary" type="button"
						onclick="history.go(-1);">Cancel</button>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<jsp:directive.include file="footer.jsp" />
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#categoryForm").validate({
			rules : {
				name : "required"
			},
			messages : {
				name : "Please enter category name"	
			}
		});
	
	});
	
	function validateFormInput(){
		var fieldName = document.getElementById("name");
		if(fieldName.value.length==0){
			alert("Category name is required!");
			fieldName.focus();
			return false;
			}
		return true;
		}
</script>
</html>