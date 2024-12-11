<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<head>
  <title>Import Details</title>
  <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<div class = "content">
  <h2 align="center">Import Details</h2>

  <!-- Display the user information -->
  <h3><strong>Created by:</strong> ${fullName} (User ID: ${userId})</h3>

  <!-- Display the list of products in the import -->
  <table class="table table-hover table-striped caption-top">
    <thead class="table-primary">
    <tr>
      <th scope="col">Product ID</th>
      <th scope="col">Product Name</th>
      <th scope="col">Image</th>
      <th scope="col">Import Price</th>
      <th scope="col">Quantity</th>
      <th scope="col">Total</th>
    </tr>
    </thead>
    <tbody id="myTable">
    <c:forEach var="detail" items="${importDetails}">
      <tr>
        <td>${detail.product.productId}</td>
        <td>${detail.product.productName}</td>
        <td><img src="${detail.product.image}" style="width: 150px; height: 100px; object-fit: cover;"></td>
        <td>${detail.importPrice}</td>
        <td>${detail.quantity}</td>
        <td>${detail.quantity * detail.importPrice}</td>
      </tr>
    </c:forEach>
    <!-- Add the total row -->
    <tr>
      <td colspan="4">Total:</td>
      <td>${totalQuantity}</td>
      <td>${totalSumPrice}</td>
    </tr>
    </tbody>
  </table>
  <button class="btn btn-secondary" type="button" onclick="history.go(-1);">Back</button>
  <jsp:directive.include file="footer.jsp"/>
</div>
</body>