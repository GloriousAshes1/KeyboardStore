<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="read_message.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title>Create New Category</title>
	<jsp:directive.include file="head.jsp" />
</head>
<body>
<jsp:directive.include file="header.jsp" />
<div class="content">
	<h2 class="page-heading" align="center">
		${category != null ? 'Edit Category' : 'Create New Category'}
	</h2>
	<form id="categoryForm" action="${category != null ? 'update_category' : 'create_category'}" method="post">
		<input type="hidden" name="categoryId" value="${category.categoryId}" />
		<table align="center">
			<tr>
				<td><label>Name:</label></td>
				<td><input type="text" name="name" id="name" value="${name != null ? name : (category != null ? category.name : '')}"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button class="btn btn-primary" type="submit">Save</button>
					<button class="btn btn-secondary" type="button" onclick="history.go(-1);">Cancel</button>
				</td>
			</tr>
		</table>
	</form>
	<jsp:directive.include file="footer.jsp" />
</div>
</body>

<script>
	// Passing error messages to JavaScript
	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;

	$(document).ready(function() {
		$("#categoryForm").on("submit", function(event) {
			if (!validateFormInput()) {
				event.preventDefault();
			}
		});
	});

	function validateFormInput() {
		var fieldName = document.getElementById("name");
		var inputValue = fieldName.value.trim();
		var label = fieldName.closest("tr").querySelector("label").textContent.trim();  // Lấy giá trị của label
		if (inputValue.length === 0) {
			showError(label,"NULL_INPUT");
			return false;
		}
		if (inputValue.trim().length > 30) {
			showError(label,"OVER_LENGTH_ERROR")
			return false;
		}
		return true;
	}

	function showError(name, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(name + " " + message);
			fieldName.focus();
		}
	}
</script>

</html>
