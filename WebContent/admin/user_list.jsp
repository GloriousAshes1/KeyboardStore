<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User List - Legendary Games Administration</title>
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<script type="text/javascript" src="/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	<div align="center">
		<h2 class="page-heading">User Management</h2>
		<a href="user_form.jsp">Create new user</a>
	</div>
	
	<c:if test="${message != null}">
	<div align="center">
		<h4 class="message">${message}</h4>
	</div>
	</c:if>
	
	<div align="center">
		<table class= "table custom-table caption-top table-success table-hover table-bordered" border="1" cellpadding="5">
		<caption>List of users</caption>
			<thread>
			<tr>
				<th>Index</th>
				<th>ID</th>
				<th>Email</th>
				<th>Full Name</th>
				<th>Actions</th>
			</tr>
			</thread>
			<c:forEach var ="user" items="${listUsers}" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${user.userId}</td>
					<td>${user.email}</td>
					<td>${user.fullName}</td>
					<td>
						<a href="edit_user?id=${user.userId}">Edit</a> &nbsp;
						<a href="javascript:confirmDelete(${user.userId})">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<jsp:directive.include file="footer.jsp"/>
	
	<script>
		function confirmDelete(userId){
			if(confirm('Are you sure you want to delete user with ID: '+userId+'?')){
					window.location ='delete_user?id='+userId;
				}		
		}
	</script>
</body>
</html>