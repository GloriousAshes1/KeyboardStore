<%@ page contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Your Shopping Cart - KeyBoard Store</title>
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<link rel="stylesheet" href="css/globals.css" />
	<link rel="stylesheet" href="css/styleguide.css" />
	<link rel="stylesheet" href="css/shopping_cart_style.css">
</head>
<body>
<header><jsp:directive.include file="header.jsp" /></header>
<div class="shopping-cart">
	<!-- message null-->
	<c:if test="${message != null}">
	</c:if>
	<!-- tạo session 'Cart' -->
	<c:set var="cart" value="${sessionScope['cart']}" />
	<!-- Empty Cart -->
	<c:if test="${cart.totalItems == 0}">
		<div class="div">
			<div class="main-cart">
				<div class="container">
					<div class="empty-cart-container">
						<p class="empty-cart-message">
							Nothing here yet!<br>
							Time to add a little something to your cart.
						</p>
						<a href="${pageContext.request.contextPath}" type="hidden"><img src="css/images/shopping-bag.svg" class="empty-cart-image" loading="lazy"></a>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<!-- Cart -->
	<c:if test="${cart.totalItems > 0}">
	<div class="div">
		<div class="main-cart">
			<div class="overlap-group">
				<div class="title">Shopping cart<img class="svg" src="css/images/shopping-cart.svg"/> </div>
				<p class="p">${cart.totalQuantity} item(s)</p>
			</div>
			<div class="container">
				<!-- Cart Form -->
				<form action="update_cart" method="post" id="cart-form">
					<c:forEach items="${cart.items}" var="items" varStatus="status">
						<div class="item-container">
							<div class="item-card">
								<div class="item-detail-card">
									<div class="rectangle">
										<a href="view_product?id=${items.key.productId}" type="hidden"><img src="d${items.key.image}" width="80px" height="80px" border="1px" alt="${items.key.productName}"></a>
									</div>
									<div class="item-detail">
										<div class="item-card-text">${items.key.productName}</div>
										<div>
											<div class="item-status-text">Status:<div class="item-status">Available</div></div>
										</div>
									</div>

										<input type="hidden" name="productId" value="${items.key.productId}">
										<div class="inc-dec-value">
											<button type="button" class="dec" onclick="updateQuantity('${items.key.productId}', 'decrease')">-</button>
											<input type="text" name="quantity${status.index + 1}" class="quantity" value="${items.value}" id="${items.key.productId}" readonly required>
											<button type="button" class="inc" onclick="updateQuantity('${items.key.productId}', 'increase')">+</button>
										</div>
									<div class="subtotal-text"><fmt:formatNumber
											value="${items.value * items.key.sellingPrice}" type="currency" /></div>
									<div class="trash-bin"><a href="remove_from_cart?product_id=${items.key.productId}"
									><img class="trash-bin" src="css/images/trash-bin.png"></a></div>
								</div>
							</div>
						</div>
					</c:forEach>
				</form>
				<!-- Checkout Card -->
				<div class="checkout-container">
					<div class="checkout-card">
						<div class="checkout-detail-card">
							<div class="checkout-title">Checkout Infomation<img class="svg" src="css/images/detail.svg"/></div>
							<div class="text-wrappers">
								<div class="text-wrapper">Subtotal: <div><fmt:formatNumber value="${cart.totalAmount}" type="currency"/></div></div>
								<div class="text-wrapper">Tax: <div><fmt:formatNumber value="${cart.tax}" type="currency"/></div></div>
								<div class="text-wrapper">Shipping Fee: <div><fmt:formatNumber value="${cart.shippingFee}" type="currency"/></div></div>
								<div class="text-wra	pper">Total: <div><fmt:formatNumber value="${cart.totalPrice}" type="currency"/></div></div>
							</div>
							<div class="checkout" onclick="window.location='checkout'">Checkout &gt;</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
</div>
<footer><jsp:directive.include file="footer.jsp" /></footer>
<script type="text/javascript">
	const decreaseNumber = (productId) => {
		let itemval = document.getElementById(productId);
		if(itemval.value <= 0){
			itemval.value = 0;
		}
		else{
			itemval.value = parseInt(itemval.value) - 1;
		}
	}
	const increaseNumber = (productId) => {
		let itemval = document.getElementById(productId);
		itemval.value = parseInt(itemval.value) + 1;
	}
	const updateQuantity = (productId, action) => {
		console.log("Updating quantity for productId:", productId);

		const quantityInput = document.getElementById(productId);
		if (!quantityInput) {
			console.error("Quantity input not found for productId:", productId);
			return;
		}

		let currentQuantity = parseInt(quantityInput.value);
		if (action === 'increase') {
			currentQuantity += 1;
		} else if (action === 'decrease' && currentQuantity > 0) {
			currentQuantity -= 1;
		}

		quantityInput.value = currentQuantity;

		const form = document.getElementById(`cart-form`);
		if (form) {
			form.submit();
		} else {
			console.error("Form not found for productId:", productId);  // Thông báo lỗi nếu form không tồn tại
		}
	};
</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>