<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - Product Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/order_style.css">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
</head>
<body>
    <jsp:directive.include file="header.jsp" />

    <div class="container my-4">
        <c:choose>
            <c:when test="${order == null}">
                <div class="alert alert-danger text-center">
                    <h2 class="pageheading">Sorry, You are not authorized to view this order.</h2>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center mb-4">
                    <h2 class="pageheading">Your Order ID: ${order.orderId}</h2>
                </div>

                <!-- Order Overview Section -->
                <div class="card mb-4">
                    <div class="card-header text-center">
                        <h3>Order Overview</h3>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th scope="row">Ordered By</th>
                                    <td>${order.customer.fullname}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Order Status</th>
                                    <td>${order.status}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Order Date</th>
                                    <td>${order.orderDate}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Payment Method</th>
                                    <td>${order.paymentMethod}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Quantities</th>
                                    <td>${order.productQuantities}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Total Amount</th>
                                    <td><fmt:formatNumber value="${order.total}" type="currency" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Recipient Information Section -->
                <div class="card mb-4">
                    <div class="card-header text-center">
                        <h3>Recipient Information</h3>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tbody>
                                <tr>
                                    <th scope="row">First Name</th>
                                    <td>${order.firstname}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Last Name</th>
                                    <td>${order.lastname}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Phone</th>
                                    <td>${order.phone}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Address Line 1</th>
                                    <td>${order.addressLine1}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Address Line 2</th>
                                    <td>${order.addressLine2}</td>
                                </tr>
                                <tr>
                                    <th scope="row">City</th>
                                    <td>${order.city}</td>
                                </tr>
                                <tr>
                                    <th scope="row">State</th>
                                    <td>${order.state}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Country</th>
                                    <td>${order.countryName}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Zipcode</th>
                                    <td>${order.zipcode}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Ordered Games Section -->
                <div class="card mb-4">
                    <div class="card-header text-center">
                        <h3>Ordered Games</h3>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th>No</th>
                                    <th>Product</th>
                                    <th>Developer</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td class="d-flex align-items-center">
                                            <img src="data:image/jpg;base64,${orderDetail.product.base64Image}" width="48" height="64" alt="${orderDetail.product.title}" class="me-2 img-fluid" />
                                            ${orderDetail.product.title}
                                        </td>
                                        <td>${orderDetail.product.developer}</td>
                                        <td><fmt:formatNumber value="${orderDetail.product.price}" type="currency" /></td>
                                        <td>${orderDetail.quantity}</td>
                                        <td><fmt:formatNumber value="${orderDetail.subtotal}" type="currency" /></td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td colspan="6" class="text-end">
                                        <p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency" /></p>
                                        <p>Tax: <fmt:formatNumber value="${order.tax}" type="currency" /></p>
                                        <p>Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type="currency" /></p>
                                        <p>Total: <fmt:formatNumber value="${order.total}" type="currency" /></p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:directive.include file="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
