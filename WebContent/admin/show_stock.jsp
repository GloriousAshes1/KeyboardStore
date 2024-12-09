<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>Show Stock - Legendary Games Administration</title>
  <jsp:include page="head.jsp"/>
  <style>
    .low-stock {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="content">
  <h1 align="center">Stock List</h1>
  <!-- Add Notification -->
  <jsp:directive.include file="notification.jsp"/>

  <div class="d-flex justify-content-between align-items-center mb-3">
    <!-- Add Search -->
    <input class="form-control" id="myInput" type="text" placeholder="Search..">

    <form method="GET" action="list_import">
      <button type="submit" class="btn-add">+ View Import</button>
    </form>
    
  </div>
  <!-- Set Page -->
  <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
  <c:set var="itemsPerPage" value="10" />
  <c:set var="totalItems" value="${listProducts != null ? listProducts.size() : 0}" />
  <c:set var="totalPages" value="${(totalItems / itemsPerPage) + (totalItems % itemsPerPage > 0 ? 1 : 0)}" />
  <c:set var="startIndex" value="${(currentPage - 1) * itemsPerPage}" />
  <c:set var="endIndex" value="${startIndex + itemsPerPage > totalItems ? totalItems : startIndex + itemsPerPage}" />
  <!-- Product Table -->
  <table class="table table-striped table-hover caption-top">
    <thead class="table-primary">
    <tr>
      <th>Product ID</th>
      <th>Product Name</th>
      <th>Brand</th>
      <th>Stock</th>
    </tr>
    </thead>
    <tbody>
    <!-- Sort and display the product list -->
    <c:forEach var="product" items="${listProducts}">
      <tr>
        <td>${product.productId}</td>
        <td>${product.productName}</td>
        <td>${product.brand}</td>
        <td class="${product.stock < 10 ? 'low-stock' : ''}">
            ${product.stock}
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <jsp:directive.include file="footer.jsp"/>
</div>

<script>
  $(document).ready(function () {
    $("#myInput").on("keyup", function () {
      var value = $(this).val().toLowerCase();
      $("table tbody tr").filter(function () {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });
  });
</script>
</body>
</html>
