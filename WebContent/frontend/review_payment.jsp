<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Payment - Legendary Games</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <style>
        .message {
            color: red;
        }
        .form-control {
            height: 45px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .content-section {
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .btn-primary, .btn-secondary {
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <jsp:directive.include file="header.jsp" />

    <div class="container my-4 content-section">
        <div class="text-center mb-4">
            <h3>Please review the information before payment</h3>
        </div>
        
        <h4 class="text-center">Payer Information</h4>
        <table class="table table-bordered table-striped mb-4">
            <tbody>
                <tr>
                    <td><strong>First Name:</strong></td>
                    <td>${payer.firstName}</td>
                </tr>
                <tr>
                    <td><strong>Last Name:</strong></td>
                    <td>${payer.lastName}</td>
                </tr>
                <tr>
                    <td><strong>Email:</strong></td>
                    <td>${payer.email}</td>
                </tr>
            </tbody>
        </table>

        <h4 class="text-center">Recipient Information</h4>
        <table class="table table-bordered table-striped mb-4">
            <tbody>
                <tr>
                    <td><strong>Recipient Name:</strong></td>
                    <td>${recipient.recipientName}</td>
                </tr>
                <tr>
                    <td><strong>Address Line 1:</strong></td>
                    <td>${recipient.line1}</td>
                </tr>
                <tr>
                    <td><strong>Address Line 2:</strong></td>
                    <td>${recipient.line2}</td>
                </tr>
                <tr>
                    <td><strong>City:</strong></td>
                    <td>${recipient.city}</td>
                </tr>
                <tr>
                    <td><strong>State:</strong></td>
                    <td>${recipient.state}</td>
                </tr>
                <tr>
                    <td><strong>Country Code:</strong></td>
                    <td>${recipient.countryCode}</td>
                </tr>
                <tr>
                    <td><strong>Zipcode:</strong></td>
                    <td>${recipient.postalCode}</td>
                </tr>
            </tbody>
        </table>

        <h4 class="text-center">Transaction Details</h4>
        <table class="table table-bordered table-striped mb-4">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${transaction.itemList.items}" var="item" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${item.name}</td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.price}" type="currency" /></td>
                        <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" /></td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="4" class="text-end"><strong>Subtotal:</strong></td>
                    <td><fmt:formatNumber value="${transaction.amount.details.subtotal}" type="currency" /></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><strong>Tax:</strong></td>
                    <td><fmt:formatNumber value="${transaction.amount.details.tax}" type="currency" /></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><strong>Shipping Fee:</strong></td>
                    <td><fmt:formatNumber value="${transaction.amount.details.shipping}" type="currency" /></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><strong>Total:</strong></td>
                    <td><fmt:formatNumber value="${transaction.amount.total}" type="currency" /></td>
                </tr>
            </tbody>
        </table>

        <div class="text-center">
            <form action="execute_payment" method="post">
                <input type="hidden" name="paymentId" value="${param.paymentId}" />
                <input type="hidden" name="PayerID" value="${param.PayerID}" />
                <button type="submit" class="btn btn-primary">Pay Now</button>
                <button type="button" class="btn btn-secondary" onclick="history.go(-1);">Cancel</button>
            </form>
        </div>
    </div>

    <jsp:directive.include file="footer.jsp" />
</body>
</html>
