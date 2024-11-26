<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Receipt - Legendary Games</title>
<link rel="stylesheet" href="css/style.css">
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<style type="text/css">
	.payment-success{
		color:#00ff7f;
	}
</style>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div align="center">
		<h2 id="payment-success"><i>You have made Payment successfully. Thanks for choosing us.</i></h2>
		<jsp:directive.include file="receipt.jsp" />
		<div>
			<br/>
			<input type="button" value="Print Receipt" onclick="javascript:showPrintReceiptPopup()" />
		</div>
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
	<script>
		function showPrintReceiptPopup(){
			var width = 600;
			var height = 250;
			var left = (screen.width - width)/2;
			var top = (screen.width - width)/2;
			
			window.open('frontend/print_receipt.jsp', '_blank',
					'width=' + width + ', hieght=' + height +
					', top=' + top + 'left=' + left);
		}
	</script>

</body>
</html>