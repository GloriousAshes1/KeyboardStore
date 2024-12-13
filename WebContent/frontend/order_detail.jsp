<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - KeyBoard Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/order1_style.css">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
</head>
<body>
<jsp:directive.include file="header.jsp" />

<div class="container">
    <div class="card-title" onclick="window.history.back()">&lt;Order History</div>
    <form action="change_order_status" method="post">
    <!-- Recipient Information -->
    <div class="information-container">
        <input type="hidden" name="orderId" value="${order.orderId}" />
        <div class="information-card">
            <div class="card-title">Recipient Information</div>
            <div class="information-detail-card">
                <div class="text-wrappers">
                    <div class="text-wrapper">First Name:<input class="input-box" name="firstname" value="${loggedCustomer.firstname}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Last Name:<input class="input-box" name="lastname" value="${loggedCustomer.lastname}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Phone:<input class="input-box" name="phone" value="${loggedCustomer.phone}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Primary Address:<input class="input-box" name="address1" value="${loggedCustomer.addressLine1}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Secondary Address:<input class="input-box" name="address2" value="${loggedCustomer.addressLine2}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">City:<input class="input-box" name="city" value="${loggedCustomer.city}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">State:<input class="input-box" name="state" value="${loggedCustomer.state}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Zip Code:<input class="input-box" name="zipcode" value="${loggedCustomer.zipcode}" disabled id="custom-disabled"></div>
                </div>
                <div class="text-wrappers">
                    <div class="text-wrapper">Country:<input class="input-box" name="country" value="${loggedCustomer.countryName}"disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Order Status:<select name="status" id="custom-disabled" style="margin-right: 125px" ${order.status != 'Processing' ? 'disabled' : ''}>
                        <!-- Các giá trị cố định -->
                        <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>Processing</option>
                        <option value="Canceled" ${order.status == 'Canceled' ? 'selected' : ''}>Canceled</option>

                        <!-- Hiển thị trạng thái hiện tại nếu không thuộc các giá trị cố định -->
                        <c:if test="${order.status != 'Processing' && order.status != 'Cancelled'}">
                            <option value="${order.status}" selected>${order.status}</option>
                        </c:if>
                    </select></div>
                    <div class="text-wrapper">Order Date:<input class="input-box" name="orderDate" value="${order.orderDate}"disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Payment Method:<input class="input-box" name="paymentMethod" value="${order.paymentMethod}" disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Quantities:<input class="input-box" name="quantity" value="${order.productQuantities}"disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Tax:<input class="input-box" name="tax" value="${order.tax}"disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Shipping Fee:<input class="input-box" name="shippingFee" value="${order.shippingFee}"disabled id="custom-disabled"></div>
                    <div class="text-wrapper">Total Amount:<input class="input-box" name="totalAmount" value="${order.total}"disabled id="custom-disabled"></div>
                </div>
            </div>
            <div style="display: flex; justify-content: center; margin-left: auto !important;"><c:if test="${order.status == 'Processing'}">
                <button type="submit" class="btn btn-danger" style="margin-left: auto">Cancel Order</button>
            </c:if></div>
        </div>
    </div>
    </form>
    <!--Product Detail-->
    <section class="orders-table">
        <header class="table-header">
            <span class="table-cell">No</span>
            <span class="table-cell">Product</span>
            <span class="table-cell">Brand</span>
            <span class="table-cell">Quantities</span>
            <span class="table-cell">Price</span>
            <span class="table-cell">Subtotal</span>
        </header>
        <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
            <article class="order-row">
                <span class="table-cell">${status.index + 1}</span>
                <span class="table-cell"><img class="product-image" src="${orderDetail.product.image}" loading="lazy">${orderDetail.product.productName}</span>
                <span class="table-cell">${orderDetail.product.brand}</span>
                <span class="table-cell">
                        <input type="hidden" name="quantity${status.index + 1}" value="${orderDetail.quantity}"/>
                        ${orderDetail.quantity}</span>
                <span class="table-cell">
                    <input type="hidden" name="price" value="${orderDetail.product.sellingPrice}" />
                    <fmt:formatNumber value="${orderDetail.product.sellingPrice}" type="currency"/>
                </span>
                <span class="table-cell"><fmt:formatNumber value="${orderDetail.subtotal}" type="currency"/></span>
            </article>
        </c:forEach>
    </section>
</div>
<jsp:directive.include file="footer.jsp" />
</body>
</html>
