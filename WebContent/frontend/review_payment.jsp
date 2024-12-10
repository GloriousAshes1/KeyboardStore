<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Payment - KeyBoard Store</title>
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
<body style="background-color: #ffffff; color: #333; font-family: 'Roboto', sans-serif; line-height: 1.6;">
<jsp:directive.include file="header.jsp" />

<div class="container" style="max-width: 900px; margin: 30px auto; padding: 20px; text-align: center;">
    <!-- Header -->
    <div style="margin-bottom: 30px; border-bottom: 2px solid #000; padding-bottom: 10px;">
        <h3 style="font-size: 24px; color: #000; font-weight: bold;">Review Information Before Payment</h3>
    </div>

    <!-- Payer Information -->
    <section style="margin-bottom: 40px;">
        <h4 style="font-size: 20px; font-weight: bold; color: #000;">Payer Information</h4>
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #f9f9f9; text-align: center;">
            <tbody>
            <tr style="border-bottom: 1px solid #ccc;">
                <td style="padding: 12px; font-weight: bold; color: #555;">First Name</td>
                <td style="padding: 12px;">${payer.firstName}</td>
            </tr>
            <tr style="border-bottom: 1px solid #ccc;">
                <td style="padding: 12px; font-weight: bold; color: #555;">Last Name</td>
                <td style="padding: 12px;">${payer.lastName}</td>
            </tr>
            <tr>
                <td style="padding: 12px; font-weight: bold; color: #555;">Email</td>
                <td style="padding: 12px;">${payer.email}</td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Recipient Information -->
    <section style="margin-bottom: 40px;">
        <h4 style="font-size: 20px; font-weight: bold; color: #000;">Recipient Information</h4>
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #f9f9f9; text-align: center;">
            <tbody>
            <tr style="border-bottom: 1px solid #ccc;">
                <td style="padding: 12px; font-weight: bold; color: #555;">Recipient Name</td>
                <td style="padding: 12px;">${recipient.recipientName}</td>
            </tr>
            <tr style="border-bottom: 1px solid #ccc;">
                <td style="padding: 12px; font-weight: bold; color: #555;">Address Line 1</td>
                <td style="padding: 12px;">${recipient.line1}</td>
            </tr>
            <tr style="border-bottom: 1px solid #ccc;">
                <td style="padding: 12px; font-weight: bold; color: #555;">City</td>
                <td style="padding: 12px;">${recipient.city}</td>
            </tr>
            <tr>
                <td style="padding: 12px; font-weight: bold; color: #555;">Postal Code</td>
                <td style="padding: 12px;">${recipient.postalCode}</td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Transaction Details -->
    <section>
        <h4 style="font-size: 20px; font-weight: bold; color: #000;">Transaction Details</h4>
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #f9f9f9; text-align: center;">
            <thead style="background-color: #000; color: #fff;">
            <tr>
                <th style="padding: 12px;">No.</th>
                <th style="padding: 12px;">Name</th>
                <th style="padding: 12px;">Quantity</th>
                <th style="padding: 12px;">Price</th>
                <th style="padding: 12px;">Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${transaction.itemList.items}" var="item" varStatus="status">
                <tr style="border-bottom: 1px solid #ccc;">
                    <td style="padding: 12px;">${status.index + 1}</td>
                    <td style="padding: 12px;">${item.name}</td>
                    <td style="padding: 12px;">${item.quantity}</td>
                    <td style="padding: 12px;">${item.price}</td>
                    <td style="padding: 12px;">${item.price * item.quantity}</td>
                </tr>
            </c:forEach>
            <tr style="border-top: 2px solid #000;">
                <td colspan="4" style="text-align: right; padding: 12px; font-weight: bold;">Total:</td>
                <td style="padding: 12px;">${transaction.amount.total}</td>
            </tr>
            </tbody>
        </table>
    </section>

    <!-- Buttons -->
    <div style="margin-top: 30px;">
        <form action="execute_payment" method="post" style="display: inline-block;">
            <input type="hidden" name="paymentId" value="${param.paymentId}" />
            <input type="hidden" name="PayerID" value="${param.PayerID}" />
            <button type="submit" style="background-color: #000; color: #fff; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px; border-radius: 5px;">Pay Now</button>
        </form>
        <button type="button" onclick="history.go(-1);" style="background-color: #ccc; color: #000; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px; border-radius: 5px; margin-left: 10px;">Cancel</button>
    </div>
</div>

<jsp:directive.include file="footer.jsp" />
</body>

</html>
