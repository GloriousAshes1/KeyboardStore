<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="read_message.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Create New User</title>
	<jsp:directive.include file="head.jsp"/>
</head>
<body>
<jsp:directive.include file="notification.jsp"/>
<jsp:directive.include file="header.jsp"/>

<div class ="content">
	<!-- Dynamic Form Title -->
	<h2 class="page-heading" align="center">
		${user != null ? 'Edit User' : 'Create New User'}
	</h2>
	<form id="userForm" action="${user != null ? 'update_user' : 'create_user'}" method="post">
		<table align="center">
			<!-- Hidden input for userId, only set when updating -->
			<c:if test="${user.userId != null}">
				<input type="hidden" name="userId" value="${user.userId}">
			</c:if>
			<tr>
				<td><label for="email">Email:</label></td>
				<td>
					<input type="email" name="email" id="email"
						   value="${email != null ? email : (user != null ? user.email : '')}">
				</td>
			</tr>
			<tr>
				<td><label for="fullname">Full Name:</label></td>
				<td>
					<input type="text" name="fullname" id="fullname"
						   value="${fullname != null ? fullname : (user != null ? user.fullName : '')}">
				</td>
			</tr>
			<tr>
				<td><label for="role">Role:</label></td>
				<td>
					<input type="text" name="role" id="role"
						   value="${role != null ? role : (user != null ? user.role : '')}">
				</td>
			</tr>
			<tr>
				<td><label for="password">Password:</label></td>
				<td>
					<input type="password" name="password" id="password" value="">
					<!-- Note: Do not pre-fill the password for security reasons -->
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button class="btn btn-primary" type="submit">Save</button>
					<button class="btn btn-secondary" type="button" onclick="history.go(-1);">Cancel</button>
				</td>
			</tr>
		</table>
	</form>
	<jsp:directive.include file="footer.jsp"/>
</div>
</body>
<script>
	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;
	var isEditMode = false;

	// Kiểm tra chế độ Edit/Create từ JSP
	<%
        Object userObj = request.getAttribute("user");
        if (userObj != null) {
    %>
	isEditMode = true;
	<%
        }
    %>

	$(document).ready(function() {
		$("#userForm").on("submit", function(event) {
			if (!validateFormInput()) {
				event.preventDefault(); // Chặn gửi form nếu có lỗi
			}
		});
	});

	function validateFormInput() {
		// List of field IDs to validate
		var fields = [
			{ id: 'email', label: 'E-mail' },
			{ id: 'fullname', label: 'Full Name' },
			{ id: 'role', label: 'Role' },
		];
		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var fieldName = document.getElementById(field.id);
			var inputValue = fieldName.value.trim();

			// Check for empty value
			if (inputValue.length === 0) {
				showError(field.label, "NULL_INPUT");
				fieldName.focus();
				return false;
			}

			if (field.id !== 'password' && inputValue.length > 50) {
				showError(field.label, "OVER_LENGTH_ERROR");
				fieldName.focus();
				return false;
			}

			if (field.id === 'fullname' && !/^[a-zA-Z]+(?:\s[a-zA-Z]+)*$/.test(inputValue)) {
				showError(field.label, "INVALID_INPUT");
				fieldName.focus();
				return false;
			}
		}
		var password = document.getElementById('password').value;
		if (password.length === 0 && !isEditMode) {
			showError("Password", "NULL_INPUT");
			password.focus();
			return false;
		}
		if (password.length < 6 && password.length > 0) {
			showError("Password", "SHORT_LENGTH_ERROR");
			fieldName.focus;
			return false;
		} else if (password.length > 16) {
			showError("Password", "OVER_LENGTH_ERROR");
			fieldName.focus;
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