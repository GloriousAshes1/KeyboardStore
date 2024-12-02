<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create New Category</title>
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
	<div class = "content">
		<h2 class="page-heading" align="center">
			${category != null ? 'Edit Category' : 'Create New Category'}
		</h2>
		<form id="categoryForm" action="${category != null ? 'update_category' : 'create_category'}" method="post">
			<input type="hidden" name="categoryId"
				   value="${category.categoryId}" />
		<table align="center">
			<tr>
				<td><label>Name:</label></td>
				<td><input type="text" name="name" id="name"
					value="${category.name}" required></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<button class="btn btn-primary" type="submit">Save</button>
					<button class="btn btn-secondary" type="button"
						onclick="history.go(-1);">Cancel</button>
				</td>
			</tr>
		</table>
		</form>
	<jsp:directive.include file="footer.jsp" />
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#categoryForm").validate({
			rules : {
				name : "required"
			},
			messages : {
				name : "Please enter category name"	
			}
		});
	
	});
	
	function validateFormInput(){
		var fieldName = document.getElementById("name");
		if(fieldName.value.length==0){
			alert("Category name is required!");
			fieldName.focus();
			return false;
			}
		return true;
		}
</script>
</html>