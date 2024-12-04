
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Order - Administration</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="icon" type="image/x-icon" href="../images/Logo.png">
<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>

<style>
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 600px;
    height: 300px;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
</style>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="content">
	<div align="center">
		<h2 class="page-heading">Edit Order ID: ${order.orderId}</h2>
	</div>

	<c:if test="${message != null}">
		<div align="center">
			<h4 class="message">${message}</h4>
		</div>
	</c:if>

	<form action="update_order" method="post" id="orderForm">
		<div align="center">

			<table>
				<tr>
					<td><b>Ordered By: </b></td>
					<td>${order.customer.fullname}</td>
				</tr>
				<tr>
					<td><b>Order Date: </b></td>
					<td>${order.orderDate}</td>
				</tr>
				<tr>
					<td><b>Payment Method: </b></td>
					<td><select name="paymentMethod">
							<option value="Cash On Delivery" <c:if test="${order.paymentMethod eq 'Cash On Delivery'}">selected='selected'</c:if>>Cash On Delivery</option>
							<option value="paypal" <c:if test="${order.paymentMethod eq 'paypal'}">selected='selected'</c:if>>Pay Pal</option>
					</select></td>
				</tr>

				<tr>
					<td><b>Order Status: </b></td>
					<td><select name="orderStatus">
							<option value="Processing"
								<c:if test="${order.status eq 'Processing' }">selected='selected'</c:if>>Processing</option>
							<option value="Shipping"
								<c:if test="${order.status eq 'Shipping' }">selected='selected'</c:if>>Shipping</option>
							<option value="Delivered"
								<c:if test="${order.status eq 'Delivered' }">selected='selected'</c:if>>Delivered</option>
							<option value="Completed"
								<c:if test="${order.status eq 'Completed' }">selected='selected'</c:if>>Completed</option>
							<option value="Cancelled"
								<c:if test="${order.status eq 'Cancelled' }">selected='selected'</c:if>>Cancelled</option>
					</select></td>
				</tr>
				</table>
				<h2>Recipient Information</h2>
				<table>
			<tr>
				<td><b>First Name: </b></td>
				<td><input type="text" name="firstname" id="firstname" value="${order.firstname}" size="45" /></td>
			</tr>
			<tr>
				<td><b>Last Name: </b></td>
				<td><input type="text" name="lastname" id="lastname" value="${order.lastname}" size="45" /></td>
			</tr>
			<tr>
				<td><b>Phone: </b></td>
				<td><input type="text" name="phone" value="${order.phone}" size="45" /></td>
			</tr>
			<tr>
				<td><b>Address Line 1: </b></td>
				<td><input type="text" name="address1" id="address1" value="${order.addressLine1}" size="45" /></td>
			</tr>
			<tr>
				<td><b>Address Line 2: </b></td>
				<td><input type="text" name="address2" id="address2" value="${order.addressLine2}" size="45" /></td>
			</tr>
			<tr>
				<td><b>City: </b></td>
				<td><input type="text" name="city" value="${order.city}" size="45" /></td>
			</tr>
			<tr>
				<td><b>State: </b></td>
				<td><input type="text" name="state" value="${order.state}" size="45" /></td>
			</tr>
			<tr>
				<td><b>Zipcode: </b></td>
				<td><input type="text" name="zipcode" value="${order.zipcode}" size="45" /></td>
			</tr>
			<tr>
				<td><b>Country:</b></td>
				<td>
					<select name="country" id="country">
						<c:forEach items="${mapCountries}" var="country">
							<option value="${country.value}"
								<c:if test='${order.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		</div>
		<div align="center">
			<h2>Ordered Games</h2>
			<table class="table custom-table caption-top table-success table-hover table-bordered" border="1">
    <thead>
        <tr>
            <th>No</th>
            <th>Product</th>
            <th>Developer</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${orderDetail.product.productName}</td>
                <td>${orderDetail.product.brand}</td>
                <td>
						<input type="hidden" name="price" value="${orderDetail.product.sellingPrice}" />
						<fmt:formatNumber value="${orderDetail.product.sellingPrice}" type="currency" />
					</td>
                <td>
                    <input type="hidden" name="gameId" value="${orderDetail.product.productId}" />
                    <input type="text" name="quantity${status.index + 1}" value="${orderDetail.quantity}" size="5" />
                </td>
                <td>
                    <fmt:formatNumber value="${orderDetail.subtotal}" type="currency" />
                </td>
                <td>
                    <a href="remove_game_from_order?id=${orderDetail.product.productId}">Remove</a>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="5"></td>
            <td colspan="1">
                <p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency" /></p>
                <p>Tax: <input type="text" size="5" name="tax" id="tax" value="${order.tax}" /></p>
                <p>Shipping Fee: <input type="text" size="5" name="shippingFee" id="shippingFee" value="${order.shippingFee}" /></p>
                <p>Total: <fmt:formatNumber value="${order.total}" type="currency" /></p>
            </td>
            <td colspan="1"></td>
        </tr>
    </tbody>
</table>
</div>

		<div align="center">
			<br /> 
			<button class="btn btn-info" onclick="javascript:showAddGamePopup()"><b>Add Games</b></button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button class="btn btn-primary" type="submit">Save</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			<button class="btn btn-secondary" type="button" onclick="javascript:window.location.href='list_order';"> Cancel</button>
		</div>
	</form>

	<jsp:directive.include file="footer.jsp" />

	<div id="addGameModal" class="modal">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <iframe src="add_game_form" width="100%" height="250px" frameborder="0"></iframe>
	    </div>
	</div>
	</div>
	<script>
	function showAddGamePopup() {
		event.preventDefault();
	    var modal = document.getElementById("addGameModal");
	    modal.style.display = "block";
	}

	function closeModal() {
	    var modal = document.getElementById("addGameModal");
	    modal.style.display = "none";
	}

	// Close modal when clicking on the close button
	document.querySelector(".close").onclick = closeModal;

	// Close modal when clicking outside the modal
	window.onclick = function(event) {
	    var modal = document.getElementById("addGameModal");
	    if (event.target == modal) {
	        modal.style.display = "none";
	    }
	}
	$(document).ready(function(){
		$("#orderForm").validate({
			rules: {
				firstname: "required",
				lastname: "required",
				phone: "required",
				address1: "required",
				address2: "required",
				city: "required",
				state: "required",
				zipcode: "required",
				country: "required",
				
				<c:forEach items="${order.orderDetails}" var="product" varStatus="status">
					quantity${status.index+1} : {
						required:true,
						number:true,
						min: 1
					},
				</c:forEach>
				
				shippingFee: {required: true, number: true,min: 0},
				tax: {required: true, number: true,min: 0},
			},
			
			messages: {
				firstname: "First Name is required!",
				lastname: "Last Name is required!",
				phone: "Phone is required!",
				address1: "Address Line 1 is required!",
				address2: "Address Line 2 is required!",
				city: "City is required!",
				state: "State is required!",
				zipcode: "zipcode is required!",
				country: "Country is required!",
				
				<c:forEach items="${order.orderDetails}" var="product" varStatus="status">
					quantity${status.index+1} : {
						required: "Please Enter Quantity",
						number: "Quantity must be a number",
						min: "Quantity must be greater than 0"
					},
				</c:forEach>
					
				shippingFee:{
					required: "Please enter shipping fee",
					number: "Shipping Fee must be a number",
					min: "Shipping fee must be greater than equal to 0"
				},
				tax:{
					required: "Please enter Tax",
					number: "Tax must be a number",
					min: "Tax must be greater than equal to 0"
				}
			}
		});
		});		
	</script>
</body>
</html>
