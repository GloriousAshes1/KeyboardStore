<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KeyBoard Store</title>
<link rel="icon" type="image/x-icon" href="images/Logo.png">
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
	<jsp:directive.include file="header.jsp"/>

	<div align="center">
		<h3>${message}</h3>
	</div>
	<jsp:directive.include file="footer.jsp" />

</body>
</html>