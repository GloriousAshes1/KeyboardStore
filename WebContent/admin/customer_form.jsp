<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="read_message.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Lengendary Games Administration</title>
	<jsp:directive.include file="head.jsp" />
</head>
<body>
	<jsp:directive.include file="notification.jsp"/>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
		<h1 align="center">
			<c:if test="${customer != null}">
				Edit Customer
			</c:if>
			<c:if test="${customer == null}">
				Create New Customer
			</c:if>
		</h1>

	<div align="center">
		<c:if test="${customer != null}">
			<form action="update_customer" method="post" id="customerForm"
				style="max-width: 400px; margin: 0 auto;">
				<input type="hidden" name="customerId"
					value="${customer.customerId}">
		</c:if>
		<c:if test="${customer == null}">
			<form action="create_customer" method="post" id="customerForm"
				style="max-width: 400px; margin: 0 auto;">
		</c:if>
	<jsp:directive.include file="../common/customer_form.jsp" />
		</form>
	</div>
	<jsp:directive.include file="footer.jsp" />
	</div>
</body>
</html>
