<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create New User</title>
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<c:if test="${message != null}">
	<script type="text/javascript">
		$(document).ready(function() {
			var messageType = '${messageType}';
			var message = '${message}';

			// Ensure that the message and messageType are properly escaped in JavaScript context
			message = message.replace(/'/g, "\\'");
			messageType = messageType.replace(/'/g, "\\'");
			toastr.options = {
				"closeButton": true,
				"debug": false,
				"newestOnTop": true,
				"progressBar": true,
				"positionClass": "toast-top-right",
				"preventDuplicates": true,
				"showDuration": "300",
				"hideDuration": "1000",
				"timeOut": "5000",
				"extendedTimeOut": "1000",
				"showEasing": "swing",
				"hideEasing": "linear",
				"showMethod": "fadeIn",
				"hideMethod": "fadeOut"
			};
			if (messageType === 'success') {
				toastr.success(message);
			} else if (messageType === 'error') {
				toastr.error(message);
			} else if (messageType === 'warning') {
				toastr.warning(message);
			} else if (messageType === 'info') {
				toastr.info(message);
			}
		});
	</script>
</c:if>
<div class ="content">
	<!-- Dynamic Form Title -->
	<h2 class="page-heading" align="center">
		${user != null ? 'Edit User' : 'Create New User'}
	</h2>
	<form id="userForm" action="${user != null ? 'update_user' : 'create_user'}" method="post">
		<table>
			<!-- Hidden input for userId, only set when updating -->
			<c:if test="${user != null}">
				<input type="hidden" name="userId" value="${user.userId}">
			</c:if>
			<tr>
				<td><label for="email">Email:</label></td>
				<td>
					<input type="email" name="email" id="email"
						   value="${email != null ? email : (user != null ? user.email : '')}"
						   required>
				</td>
			</tr>
			<tr>
				<td><label for="fullname">Full Name:</label></td>
				<td>
					<input type="text" name="fullname" id="fullname"
						   value="${fullname != null ? fullname : (user != null ? user.fullName : '')}"
						   required>
				</td>
			</tr>
			<tr>
				<td><label for="role">Role:</label></td>
				<td>
					<input type="text" name="role" id="role"
						   value="${fullname != null ? fullname : (user != null ? user.fullName : '')}"
						   required>
				</td>
			</tr>
			<tr>
				<td><label for="password">Password:</label></td>
				<td>
					<input type="password" name="password" id="password"
						   value=""
						   required minlength="3">
					<!-- Note: Do not pre-fill the password for security reasons -->
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button class="btn btn-primary" type="submit">Save</button>
					<button class="btn btn-secondary" type="button" onclick="window.location.href='list_users';">Cancel</button>
				</td>
			</tr>
		</table>
	</form>
	<jsp:directive.include file="footer.jsp"/>
</div>
</body>
</html>