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

</head>
<body onload="window.print();">
	<div>
		<jsp:directive.include file="receipt.jsp" />
	</div>
</body>
</html>