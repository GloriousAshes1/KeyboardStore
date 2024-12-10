
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="read_message.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Order - Administration</title>
<jsp:directive.include file="head.jsp"/>
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
				<td><input type="text" name="firstname" id="firstname" value="${order.firstname}" /></td>
			</tr>
			<tr>
				<td><b>Last Name: </b></td>
				<td><input type="text" name="lastname" id="lastname" value="${order.lastname}"/></td>
			</tr>
			<tr>
				<td><b>Phone: </b></td>
				<td><input type="text" name="phone" id="phone" value="${order.phone}"/></td>
			</tr>
			<tr>
				<td><b>Address Line 1: </b></td>
				<td><input type="text" name="address1" id="address1" value="${order.addressLine1}"/></td>
			</tr>
			<tr>
				<td><b>Address Line 2: </b></td>
				<td><input type="text" name="address2" id="address2" value="${order.addressLine2}" /></td>
			</tr>
			<tr>
				<td><b>City: </b></td>
				<td><input type="text" name="city" id="city" value="${order.city}" /></td>
			</tr>
			<tr>
				<td><b>State: </b></td>
				<td><input type="text" name="state" id="state" value="${order.state}" /></td>
			</tr>
			<tr>
				<td><b>Zipcode: </b></td>
				<td><input type="text" name="zipcode" id="zipcode" value="${order.zipcode}" /></td>
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
			<h2>Ordered Products</h2>
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
						<input type="hidden" name="price" id="price" value="${orderDetail.product.sellingPrice}" />
						<fmt:formatNumber value="${orderDetail.product.sellingPrice}" type="currency" />
					</td>
                <td>
                    <input type="hidden" name="productId" value="${orderDetail.product.productId}" />
                    <input type="text" name="quantity${status.index + 1}" id="quantity" value="${orderDetail.quantity}" size="5" />
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
                <p>Tax: <fmt:formatNumber value="${order.tax}" type="currency" /></p>
                <p>Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type="currency" /></p>
                <p>Total: <fmt:formatNumber value="${order.total}" type="currency" /></p>
            </td>
            <td colspan="1"></td>
        </tr>
    </tbody>
</table>
</div>

		<div align="center">
			<br /> 
			<button class="btn btn-info" onclick="javascript:showAddGamePopup()"><b>Add Products</b></button>
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
	        <iframe src="add_product_form" width="100%" height="250px" frameborder="0"></iframe>
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

	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;
	$(document).ready(function () {
		$("#orderForm").on("submit", function (event) {
			if (!validateRecipientInfo()) {
				event.preventDefault();
			}
		});
	});

	function validateRecipientInfo() {
		// First Name validation
		var firstName = $("#firstname").val().trim();
		if (firstName === "") {
			showError("First Name", "NULL_INPUT");
			$("#firstname").focus();
			return false;
		}

		if (firstName.length > 50) {
			showError("First Name", "OVER_LENGTH_ERROR")
			$("firstName").focus();
			return false;
		}

		if (!/^[a-zA-Z]+$/.test(firstName)) {
			showError("First Name", "INVALID_INPUT");
			$("#firstname").focus();
			return false;
		}

		// Last Name validation
		var lastName = $("#lastname").val().trim();
		if (lastName === "") {
			showError("Last Name", "NULL_INPUT");
			$("#lastname").focus();
			return false;
		}

		if (lastName.length > 50) {
			showError("Last Name", "OVER_LENGTH_ERROR")
			$("lastname").focus();
			return false;
		}

		if (!/^[a-zA-Z]+$/.test(lastName)) {
			showError("Last Name", "INVALID_INPUT");
			$("#lastname").focus();
			return false;
		}

		// Phone validation
		var phone = $("#phone").val().trim();
		if (phone === "") {
			showError("Phone", "NULL_INPUT");
			$("#phone").focus();
			return false;
		}

		if (!/^\d{10,11}$/.test(phone)) {
			showError("Phone", "INVALID_INPUT");
			$("#phone").focus();
			return false;
		}

		// Address Line 1 validation
		var address1 = $("#address1").val().trim();
		if (address1 === "") {
			showError("Address Line 1", "NULL_INPUT");
			$("#address1").focus();
			return false;
		}

		// Address Line 2 validation
		var address2 = $("#address2").val().trim();
		if (address2 === "") {
			showError("Address Line 2", "NULL_INPUT");
			$("#address2").focus();
			return false;
		}

		// City validation
		var city = $("#city").val().trim();
		if (city === "") {
			showError("City", "NULL_INPUT");
			$("#city").focus();
			return false;
		}

		// State validation
		var state = $("#state").val().trim();
		if (state === "") {
			showError("State", "NULL_INPUT");
			$("#state").focus();
			return false;
		}

		// Zipcode validation
		var zipcode = $("#zipcode").val().trim();
		if (zipcode === "") {
			showError("Zipcode", "NULL_INPUT");
			$("#zipcode").focus();
			return false;
		}

		if (!/^\d{5}$/.test(zipcode)) {
			showError("Zipcode", "INVALID_INPUT");
			$("#zipcode").focus();
			return false;
		}

		//Quantity validation
		var quantity = $("#quantity").val().trim();
		if (quantity === "") {
			showError("Quantity", "NULL_INPUT");
			$("#quantity").focus();
			return false;
		}
		if (!/^\d+$/.test(quantity) || parseInt(quantity) < 1) {
			showError("Quantity", "INVALID_INPUT");
			$("#quantity").focus();
			return false;
		}

		return true;
	}

	function showError(fieldName, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(fieldName + ": " + message);
		}
	}
	</script>
</body>
</html>
