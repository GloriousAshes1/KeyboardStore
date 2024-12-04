<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/order_style.css">
</head>
<body>
    <header><jsp:directive.include file="header.jsp" /></header>

    <div class="container">
        <h2 class="pageheading">Order History</h2>

        <c:if test="${fn:length(listOrders) == 0}">
            <div class="empty-cart-message">
                <p>You have not placed any order.<br>Time to shopping!</p>
                <a href="${pageContext.request.contextPath}" type="hidden"><img src="css/images/shopping-bag.svg" class="empty-cart-image" loading="lazy"></a>
            </div>
        </c:if>
        
        <c:if test="${fn:length(listOrders) > 0}">
        <section class="orders-table">
            <header class="table-header">
                <span class="table-cell">ID</span>
                <span class="table-cell">Customer</span>
                <span class="table-cell">Date</span>
                <span class="table-cell">Amount</span>
                <span class="table-cell">Payment Mode</span>
                <span class="table-cell">Status</span>
                <span class="table-cell">Action</span>
            </header>
                <c:forEach var="order" items="${listOrders}" varStatus="status">
            <article class="order-row">
                <span class="table-cell">${order.orderId}</span>
                <span class="table-cell">${order.customer.fullname}</span>
                <span class="table-cell">${order.orderDate}</span>
                <span class="table-cell"><fmt:formatNumber value="${order.total}" type="currency" /></span>
                <span class="table-cell">${order.paymentMethod}</span>
                <div class="table-cell">
                    <span class="status-badge
                        ${order.status == 'Delivered' ? 'status-delivered' :
                          order.status == 'Canceled' ? 'status-canceled' :
                          order.status == 'Processing' ? 'status-processing' : ''}">
                        ${order.status}
                    </span>
                </div>
                <div class="action-cell">
                    <div class="action-button" aria-label="View order details" onclick=window.location="show_order_detail?id=${order.orderId}">
                        <img src="css/images/detail_action.png" alt="" class="action-icon" />
                    </div>
                </div>
            </article>
            </c:forEach>
        </c:if>
    </div>

    <jsp:directive.include file="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
