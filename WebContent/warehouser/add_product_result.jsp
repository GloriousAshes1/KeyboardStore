<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Product to Order</title>
<link rel="icon" type="image/x-icon" href="../images/Logo.png">
</head>
<body>
	<div align="center">
		<h2>
			The product <i>${product.title}</i> has been added to the order ID <b>${order.orderId}</b>
		</h2>
		<input type="button" value="Close" onclick="javascript: self.close();" />
	</div>
	<script>
		window.onunload = function() {
			window.opener.location.reload();
		}
	</script>
</body>
</html>