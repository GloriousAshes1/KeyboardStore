<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Posted - Legendary Games</title>
<link rel = "stylesheet" href = "css/style.css">
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		
			<table class="normal" width="60%">
				<tr>
					<td><h2>Your Reviews</h2></td>
					<td>&nbsp;</td>
					<td><h2>${loggedCustomer.fullname}</h2></td>
				</tr>
				<tr>
					<td colspan="3"><hr/></td>
				</tr>
				<tr>
					<td>
						<span id="product-title">${product.productName}</span><br/>
						<img class="product-large" src="${product.image}" />
					</td>
					<td colspan="2">
						<h3>Your review has been posted. Thank you!</h3>
					</td>
				</tr>
			</table>
		
	</div>
	
	<jsp:directive.include file="footer.jsp" />
</body>
</html>