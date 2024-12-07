<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<%@ include file="read_message.jsp" %>
<html>
<head>
  <title>Create New Import</title>
  <jsp:directive.include file="head.jsp"/>
  <script>
    // Function to calculate the sum price
    function calculateSumPrice() {
      var totalSumPrice = 0;
      var rows = document.getElementById("productTable").rows;

      // Loop through each row to calculate sum
      for (var i = 0; i < rows.length - 3; i++) { // Exclude 'Add More' and 'Submit' rows
        var quantity = parseInt(document.getElementById("quantityInput" + i).value) || 0;
        var importPrice = parseFloat(document.getElementById("importPrice" + i).value) || 0;

        // Add subtotal for this row to the total sum price
        totalSumPrice += quantity * importPrice;
      }

      // Update the sumPrice field
      var sumPriceField = document.getElementById("sumPrice");
      sumPriceField.value = totalSumPrice.toFixed(2);  // Ensure 2 decimal places

      // Check if sumPrice is valid before form submission
      if (isNaN(totalSumPrice) || totalSumPrice <= 0) {
        sumPriceField.setCustomValidity("Invalid sum price. Please check the values.");
      } else {
        sumPriceField.setCustomValidity(""); // Reset any custom validity message
      }
    }

    // Function to update the quantity and stock info
    function updateQuantity(index) {
      var productSelect = document.getElementById("productSelect" + index);
      var selectedOption = productSelect.options[productSelect.selectedIndex];
      var stock = selectedOption.getAttribute("data-stock");

      var quantityInput = document.getElementById("quantityInput" + index);
      quantityInput.value = 1; // Reset quantity to 1 or any default value
      document.getElementById("stockInfo" + index).innerText = "Max Quantity: " + stock;

      // Recalculate sumPrice whenever quantity is updated
      calculateSumPrice();
    }

    // Function to add a new product row dynamically
    function addProductRow() {
      var table = document.getElementById("productTable");
      var rowCount = table.rows.length;
      var index = rowCount - 3; // Adjust for Add More and Submit rows

      // Create a new row for the product details
      var newRow = table.insertRow(rowCount - 2); // Insert before the "Add More Products" row
      newRow.innerHTML = `
    <td>
      <select name="productId" id="productSelect${index}" onchange="updateQuantity(${index})">
        <c:forEach items="${listProduct}" var="product" varStatus="status">
          <option value="${product.productId}" data-stock="${product.stock}">
              ${product.productName} - ${product.brand} (In Stock: ${product.stock})
          </option>
        </c:forEach>
      </select>
    </td>
    <td><input type="number" name="quantity" id="quantityInput${index}" required onchange="calculateSumPrice()" value="1"></td>
    <td><input type="text" name="importPrice" id="importPrice${index}" required onchange="calculateSumPrice()"></td>
  `;
      // After adding the new row, recalculate the sum price
      calculateSumPrice();
    }
  </script>
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<div class="content">
<h2 align="center">Create New Import</h2>

<form action="create_import" method="post">
<%--  <p><c:out value="${sessionScope}" /></p>--%>
  <table id="productTable" align="center" border="1" style="border-collapse: collapse; width: 80%;">
    <tr>
      <th>Product</th>
      <th>Quantity</th>
      <th>Import Price</th>
    </tr>
    <tr>
      <td>
        <select name="productId" id="productSelect0" onchange="updateQuantity(0)">
          <c:forEach items="${listProduct}" var="product" varStatus="status">
            <option value="${product.productId}" data-stock="${product.stock}">
                ${product.productName} - ${product.brand} (In Stock: ${product.stock})
            </option>
          </c:forEach>
        </select>
      </td>
      <td><input type="number" name="quantity" id="quantityInput0" required onchange="calculateSumPrice()" value="1"></td>
      <td><input type="text" name="importPrice" id="importPrice0" required onchange="calculateSumPrice()"></td>
    </tr>
    <!-- Placeholder for more product rows -->
    <tr id="addProductRow">
      <td colspan="3" style="text-align: center;">
        <button class="btn btn-primary" type="button" onclick="addProductRow()">Add More Products</button>
      </td>
    </tr>
    <tr>
      <td colspan="3" style="text-align: center;">
        <button class="btn btn-primary" type="submit">Save</button>
        <button class="btn btn-secondary" type="button" onclick="history.go(-1);">Cancel</button>
      </td>
    </tr>
  </table>
</form>

</div>
<script>
  // Initialize the calculation when the page loads
  window.onload = function() {
    updateQuantity(0);
    calculateSumPrice();
  };
</script>
</body>
</html>
