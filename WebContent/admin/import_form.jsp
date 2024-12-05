<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <title>Create Import - Legendary Games Administration</title>
  <jsp:include page="head.jsp"/>
</head>
<body>
<jsp:directive.include file="header.jsp"/>

<div class="content">
  <h1 align="center">Create New Import</h1>
  <!-- Add Notification -->
  <jsp:directive.include file="notification.jsp"/>

  <c:set var="currentUser" value="${sessionScope.currentUser}" />

  <form action="create_import" method="POST">
    <div class="form-group">
      <label for="user">User</label>
      <!-- Pre-fill user field with the current user's ID -->
      <input type="text" class="form-control" id="user" name="userId" value="${currentUser.userId}" readonly>
    </div>

    <div class="form-group">
      <label for="importDate">Import Date</label>
      <input type="date" class="form-control" id="importDate" name="importDate" value="${fn:substring(currentDate, 0, 10)}" required>
    </div>

    <div class="form-group">
      <label for="totalPrice">Total Price</label>
      <input type="number" class="form-control" id="totalPrice" name="totalPrice" step="0.01" min="0" required>
    </div>

    <div class="form-group">
      <label for="products">Products</label>
      <textarea class="form-control" id="products" name="products" rows="5" placeholder="Enter product details (e.g., Product ID, quantity, price)"></textarea>
    </div>

    <div class="form-group text-center">
      <button type="submit" class="btn-submit">Save Import</button>
      <a href="list_import" class="btn-cancel">Cancel</a>
    </div>
  </form>
</div>

<jsp:directive.include file="footer.jsp"/>
</body>
</html>
