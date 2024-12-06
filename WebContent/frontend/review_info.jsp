<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review - Legendary Games</title>
<link rel = "stylesheet" href = "css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
			<table class="normal" width="60%">
				<tr>
					<td><h2>You already wrote review for this product</h2></td>
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
					<td>
						<div id="rateYo"></div>
						<br/>
						<input type="text" name="headline" readonly="readonly" value="${review.headline}"/>
						<br/>
						
						<br/>
						<textarea name="comment" cols="70" rows="10" readonly="readonly"  placeholder="Write your review details..." >${review.comment}</textarea>
					</td>
				</tr>
			</table>
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#rateYo").rateYo({
			starWidth: "40px",
			fullStar: true,
			rating :${review.rating},
			readOnly : true
		});		
	});
</script>	
</body>
</html>