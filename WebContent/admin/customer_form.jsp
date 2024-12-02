<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Lengendary Games Administration</title>
	<link rel="stylesheet" href="../css/style.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<c:if test="${message != null}">
		<script type="text/javascript">
			$(document).ready(function() {
				var messageType = '${messageType}';
				var message = '${message}';

				// Ensure that the message and messageType are properly escaped in JavaScript context
				message = message.replace(/'/g, "\\'");
				messageType = messageType.replace(/'/g, "\\'");
				toastr.options = {
					"closeButton": true,
					"debug": false,
					"newestOnTop": true,
					"progressBar": true,
					"positionClass": "toast-top-right",
					"preventDuplicates": true,
					"showDuration": "300",
					"hideDuration": "1000",
					"timeOut": "5000",
					"extendedTimeOut": "1000",
					"showEasing": "swing",
					"hideEasing": "linear",
					"showMethod": "fadeIn",
					"hideMethod": "fadeOut"
				};
				if (messageType === 'success') {
					toastr.success(message);
				} else if (messageType === 'error') {
					toastr.error(message);
				} else if (messageType === 'warning') {
					toastr.warning(message);
				} else if (messageType === 'info') {
					toastr.info(message);
				}
			});
		</script>
	</c:if>
	<div class="content">
		<h1 align="center">
			<c:if test="${customer != null}">
				Edit Customer
			</c:if>
			<c:if test="${customer == null}">
				Create New Customer
			</c:if>
		</h2>

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
<script type="text/javascript" src = "../js/customer-form.js"></script>
</html>
