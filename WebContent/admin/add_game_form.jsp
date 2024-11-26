<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Product to Order</title>
<link rel="icon" type="image/x-icon" href="../images/Logo.png">
</head>
<body>
	<div align="center">
		<h2>Add product to Order ID: ${order.orderId}</h2>
		<form action="add_game_to_order" method="post">
		<table>
			<tr>
				<td>Select a product: </td>
				<td>
					<select name="gameId">
						<c:forEach items="${listProduct}" var="product" varStatus="status">
							<option value="${product.gameId}">${product.title} - ${product.developer}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>Quantities</td>
				<td>
					<select name="quantity">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<button class="btn btn-success" type="submit">Add</button>
					<button class="btn btn-warning" type = "button" onclick="javascript: self.close();">Cancel</button>
				</td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>