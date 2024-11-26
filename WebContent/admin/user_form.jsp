<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create New User</title>
	<link rel = "stylesheet" href = "../css/style.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	<div align="center">
		<hr width="60%"/>
		<h2 class="page-heading">
			<c:if test="${user != null}">
				Edit User
			</c:if>
			<c:if test="${user == null}">
				Create New User
			</c:if>
		</h2>	
	</div>
	<div>
		<c:if test="${user != null}">
			<form class="mx-auto" id="userForm" action="update_user" method="post">
		</c:if>
		<c:if test="${user == null}">
			<form class="mx-auto" id="userForm" action="create_user" method="post">
		</c:if>
		<table>
				<tr>
                    <input type="hidden" name="userId" value="${user.userId}"/>
                </tr>
                <tr>
                    <td><label for="email">Email:</label></td>
                    <td><input type="email" name="email" id="email" value="${user.email}" required></td>
                </tr>
                <tr>
                    <td><label for="fullname">Full Name:</label></td>
                    <td><input type="text" name="fullname" id="fullname" value="${user.fullName}" required></td>
                </tr>
                <tr>
                    <td><label for="password">Password:</label></td>
                    <td><input type="password" name="password" id="password" value="${user.password}" required minlength="3"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <button class="btn btn-primary" type="submit"> Save</button>
                        <button class="btn btn-secondary" type = "button" onclick="history.go(-1);">Cancel</button>
                    </td>
                </tr>
          </table>
	</form>
	</div>
	<jsp:directive.include file="footer.jsp"/>
</body>

</html>