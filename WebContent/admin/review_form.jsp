<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit Review</title>
	<link rel = "stylesheet" href = "../css/style.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
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
				<td align="left"><b>${review.product.title}</b></td>
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
					<input type="text" size="60" name="headline" value="${review.headline}" />
				</td>
			</tr>
			<tr>
				<td align="right">Comment:</td>
				<td align="left">
					<textarea rows="5" cols="70" name="comment" required>${review.comment}</textarea>
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
</body>
<script type="text/javascript">
$(document).ready(function() {
	$("#reviewForm").validate({
		rules: {	
			headline: "required",
			comment: "required"
		},
		
		messages: {
			headline: "Please enter headline",
			comment: "Please enter comment",
		}
	});
	
	$("#buttonCancel").click(function() {
		history.go(-1);
	});	
});
</script>
</html>