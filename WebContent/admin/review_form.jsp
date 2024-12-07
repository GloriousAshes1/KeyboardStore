<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="read_message.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Edit Review</title>
	<jsp:directive.include file="head.jsp"/>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class ="content">
	<div align="center">
	<hr width="60%"/>
		<h2 class="page-heading">Edit Review</h2>
	</div>
	
	<div align="center">
		<form action="update_review" method="post" id="reviewForm" style="max-width: 400px; margin:0 auto;">
		<input type="hidden" name="reviewId" value="${review.reviewId}">

		
		<table class="form">
			<tr>
				<td align="right">Product:</td>
				<td align="left"><b>${review.product.productName}</b></td>
			</tr>
			<tr>
				<td align="right">Rating:</td>
				<td align="left"><b>${review.rating}</b></td>
			</tr>
			<tr>
				<td align="right">Customer:</td>
				<td align="left"><b>${review.customer.fullname}</b></td>
			</tr>
			<tr>
				<td align="right">Headline:</td>
				<td align="left">
					<input type="text" id="headline" size="60" name="headline" value="${review.headline}" />
				</td>
			</tr>
			<tr>
				<td align="right">Comment:</td>
				<td align="left">
					<textarea rows="5" cols="70" name="comment" id="comment">${review.comment}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
                        <button class="btn btn-primary" type="submit"> Save</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button class="btn btn-secondary" type = "button" onclick="history.go(-1);">Cancel</button>
                    </td>
				</td>
			</tr>				
		</table>
		</form>
	</div>

	<jsp:directive.include file="footer.jsp" />
	</div>
</body>
<script>
	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;
	// Xử lý khi form được submit
	$(document).ready(function() {
		$("#reviewForm").on("submit", function(event) {
			if (!validateFormInput()) {
				event.preventDefault(); // Chặn gửi form nếu có lỗi
			}
		});
	});

	// Hàm validate form
	function validateFormInput() {
		var fields = [
			{ id: "headline", label: "Headline" },
			{ id: "comment", label: "Comment" }
		];

		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var fieldName = $("#" + field.id);
			var inputValue = fieldName.val().trim();

			if (inputValue.length === 0) {
				showError(field.label, "NULL_INPUT");
				fieldName.focus();
				return false;
			}

			if ((fieldName === "headline" && inputValue.length > 128) || (fieldName === "comment" && inputValue.length > 500)) {
				showError(field.label, "OVER_LENGTH_ERROR")
				fieldName.focus();
				return false;
			}

			if ((fieldName === "headline" && inputValue.length < 1) || (fieldName === "comment" && inputValue.length < 3)) {
				showError(field.label, "SHORT_LENGTH_ERROR")
				fieldName.focus();
				return false;
			}
		}
		return true; // Tất cả các kiểm tra đều hợp lệ
	}

	// Hàm hiển thị lỗi
	function showError(name, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(name + " " + message);
		}
	}
</script>
</html>