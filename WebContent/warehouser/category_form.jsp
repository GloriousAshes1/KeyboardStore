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
<jsp:directive.include file="table_config.jsp" />
<body>
<jsp:directive.include file="header.jsp" />
<div class="content">
	<h2 class="page-heading" align="center">
		${category != null ? 'Edit Category' : 'Create New Category'}
	</h2>
	<form id="categoryForm" action="${category != null ? 'update_category' : 'create_category'}" method="post">
		<input type="hidden" name="categoryId" value="${category.categoryId}" />
		<table class="form">
			<tr>
				<td align="right"> Name:</td>
				<td align="left"> <input type="text" name="name" id="name" value="${name != null ? name : (category != null ? category.name : '')}"></td>
			</tr>
		</table>
		<div align="center">
			<button type="submit" class="btn btn-primary">Save</button>
			<button type="button" class="btn btn-secondary" onclick="history.go(-1);">Cancel</button>
		</div>
	</form>
	<jsp:directive.include file="footer.jsp" />
</div>
</body>

<script>
	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;
	console.log("Error Messages: ", errorMessages);

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

		if (inputValue === "") {
			showError("Name:", "NULL_INPUT");
			fieldName.focus();
			return false;
		}

		if (inputValue.length > 30) {
			showError("Name:", "OVER_LENGTH_ERROR");
			fieldName.focus();
			return false;
		}

		return true;
	}

	function showError(name, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(name + " " + message);
		}
	}
</script>
</html>
