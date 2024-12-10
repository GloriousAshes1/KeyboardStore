<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Receipt - KeyBoard Store</title>
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<style type="text/css">
	.payment-success{
		color:#00ff7f;
	}
</style>
</head>
<body>
<%@ include file="header.jsp" %>

<div style="margin: 20px auto; width: 80%; text-align: center;">
	<h2 id="payment-success" style="font-style: italic;">You have made Payment successfully. Thanks for choosing us.</h2>
	<%@ include file="receipt.jsp" %>
	<div style="margin-top: 20px;">
		<input
				type="button"
				value="Print Receipt"
				onclick="javascript:showPrintReceiptPopup()"
				style="padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;"/>
	</div>
</div>

<%@ include file="footer.jsp" %>

<script>
	function showPrintReceiptPopup() {
		var width = 600;
		var height = 250;
		var left = (screen.width - width) / 2;
		var top = (screen.height - height) / 2;

		window.open('frontend/print_receipt.jsp', '_blank',
				'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
	}
</script>
</body>

</html>