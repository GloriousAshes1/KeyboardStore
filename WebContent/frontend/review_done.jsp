<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Posted - Legendary Games</title>
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<style>
		footer {
			width: 100%;
			position: fixed; /* Hoặc `fixed` nếu muốn footer luôn nằm ở dưới */
			bottom: 0;
			left: 0;
			z-index: 10;
			background-color: #f8f9fa;
		}
	</style>
</head>
<body>
<header><%@ include file="header.jsp" %></header>

<div style="margin: 20px auto; width: 80%; text-align: center;">
	<h2>Your Review</h2>
	<div style="border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
		<table style="width: 100%; border-spacing: 20px;">
			<tr>
				<td style="text-align: left; font-weight: bold;">Your Reviews</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3"><hr/></td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<span id="product-title" style="display: block; font-weight: bold;">${product.productName}</span><br/>
					<img class="product-large" src="${product.image}" style="width: 200px; height: 200px; border: 1px solid #ddd; border-radius: 4px;"/>
				</td>
				<td colspan="2" style="text-align: center;">
					<h3>Your review has been posted. Thank you!</h3>
				</td>
			</tr>
		</table>
	</div>
</div>

<footer><%@ include file="footer.jsp" %></footer>
</body>

</html>