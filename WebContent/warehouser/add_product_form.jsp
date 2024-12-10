<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Add Product to Order</title>
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<script>
		function updateQuantity() {
			var productSelect = document.getElementById("productSelect");
			var selectedOption = productSelect.options[productSelect.selectedIndex];
			var stock = selectedOption.getAttribute("data-stock");

			var quantityInput = document.getElementById("quantityInput");
			quantityInput.max = stock; // Set max value based on stock
			quantityInput.value = 1; // Reset quantity to 1 or any default value
			document.getElementById("stockInfo").innerText = "Max Quantity: " + stock;
		}
	</script>
</head>
<body>
<div align="center">
	<h2>Add product to Order ID: ${order.orderId}</h2>
	<form action="add_product_to_order" method="post">
		<table>
			<tr>
				<td>Select a product: </td>
				<td>
					<select name="productId" id="productSelect" onchange="updateQuantity()">
						<c:forEach items="${listProduct}" var="product" varStatus="status">
							<option value="${product.productId}" data-stock="${product.stock}">
									${product.productName} - ${product.brand} (In Stock: ${product.stock})
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>Quantities</td>
				<td>
					<input type="number" name="quantity" id="quantityInput" value="1" min="1" required>
					<p id="stockInfo">Max Quantity: 0</p> <!-- Info about available stock -->
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td colspan="2" align="center">
					<button class="btn btn-success" type="submit">Add</button>
					<button class="btn btn-warning" type="button" onclick="javascript: self.close();">Cancel</button>
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- Initialize quantity field with the first product's stock -->
<script>
	window.onload = function() {
		updateQuantity();
	};
</script>
</body>
</html>
