<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Admin Login</title>
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<meta charset="UTF-8">
	<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .container h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }
        .container h2 {
            margin: 10px 0;
            font-size: 18px;
            color: #555;
        }
        .message {
            color: red;
            font-size: 14px;
        }
        form {
            margin-top: 20px;
        }
        table {
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 10px;
        }
        td {
            text-align: left;
            padding: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 200px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #0056b3;
        }
        button#registerButton {
            background-color: #28a745;
        }
        button#registerButton:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
	<div class="container">
		<img src="../images/Logo.png" height="200" width = "200" alt="Store Logo" />
		<h1>Legendary Product Store Administration</h1>
		<h2>GameStore Admin Login</h2>

		<c:if test="${message != null}">
				<div class="message">${message}</div>
		</c:if>

		<form id="formLogin" action="login" method="post">
			<table>
				<tr>
					<td><label for="email">Email:</label></td>
					<td><input type="email" name="email" id="email"
					required minlength="5" maxlength="30"></td>
				</tr>
				<tr>
					 <td><label for="password">Password:</label></td>
					<td><input type="password" name="password" id="password"
					required minlength="3" maxlength="30"></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="3" align="center">
						<button type="submit">Login</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>