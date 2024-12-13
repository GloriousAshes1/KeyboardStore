<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review - Key Board Store</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
<link rel="icon" type="image/x-icon" href="images/Logo.png">
<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
	<link rel="stylesheet" href="css/review_info.css">
</head>
<body>
<jsp:directive.include file="header.jsp" />

<div class="review-wrapper">
	<h2 class="review-header">You already wrote a review for this product</h2>
	<h3 class="review-username">${loggedCustomer.fullname}</h3>
	<h3 class="product-title">${product.productName}</h3>
	<div class="product-review">

		<div class="product-info">
			<img class="product-image" src="${product.image}" alt="${product.productName}" style="object-fit: " />
		</div>

		<div class="review-details">
			<input type="text" class="review-headline" readonly value="${review.headline}" />
			<textarea class="review-comment" readonly placeholder="Write your review details...">${review.comment}</textarea>
		</div>
	</div>
</div>

<jsp:directive.include file="footer.jsp" />

<script type="text/javascript">
	$(document).ready(function () {
		$("#rateYo").rateYo({
			starWidth: "40px",
			fullStar: true,
			rating: ${review.rating},
			readOnly: true,
		});
	});
</script>
</body>

</html>