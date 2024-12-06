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
<script type="text/javascript" src = "../js/customer-form.js">
	// Passing error messages to JavaScript
	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;

	$(document).ready(function() {
		$("#categoryForm").on("submit", function(event) {
			event.preventDefault();
			validateFormInput();
		});
	});

	function validateFormInput() {
		var fieldName = document.getElementById("email");
		var inputValue = fieldName.value.trim();
		var label = fieldName.closest("tr").querySelector("label").textContent.trim();  // Lấy giá trị của label
		if (inputValue.length === 0) {
			showError(label,"NULL_INPUT");
			return false;
		}
		if (inputValue.trim().length > 30) {
			showError(label,"OVER_LENGTH_ERROR")
			return false;
		}
		return true;
	}

	function showError(name, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(name + " " + message);
			fieldName.focus();
		}
	}
</script>
</html>
