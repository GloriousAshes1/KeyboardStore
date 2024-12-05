<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Create New Import</title>
  <script>
    function calculateSumPrice() {
      var totalSumPrice = 0;
      var rows = document.getElementById("productTable").rows;

      for (var i = 0; i < rows.length - 3; i++) { // Exclude 'Add More' and 'Submit' rows
        var quantity = parseInt(document.getElementById("quantityInput" + i).value) || 0;
        var importPrice = parseFloat(document.getElementById("importPrice" + i).value) || 0;

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

    function addProductRow() {
      var table = document.getElementById("productTable");
      var rowCount = table.rows.length;
      var newRow = table.insertRow(rowCount - 1);  // Insert before the submit row

      var index = rowCount - 1;

      newRow.innerHTML = `
      <tr>
        <td>Product:</td>
        <td>
          <select name="productId" id="productSelect${index}" onchange="updateQuantity(${index})">
            <c:forEach items="${listProduct}" var="product" varStatus="status">
              <option value="${product.productId}" data-stock="${product.stock}">
                  ${product.productName} - ${product.brand} (In Stock: ${product.stock})
              </option>
            </c:forEach>
          </select>
        </td>
      </tr>
      <tr>
        <td>Quantity:</td>
        <td><input type="number" name="quantity" id="quantityInput${index}" required onchange="calculateSumPrice()"></td>
      </tr>
      <tr>
        <td>Import Price:</td>
        <td><input type="text" name="importPrice" id="importPrice${index}" required onchange="calculateSumPrice()"></td>
      </tr>
    `;
    }
  </script>
</head>
<body>
<h2>Create New Import</h2>

<form action="create_import" method="post">
  <p><c:out value="${sessionScope}" /></p>
  <table id="productTable">
    <tr>
      <td>Product:</td>
      <td>
        <select name="productId" id="productSelect0" onchange="updateQuantity(0)">
          <c:forEach items="${listProduct}" var="product" varStatus="status">
            <option value="${product.productId}" data-stock="${product.stock}">
                ${product.productName} - ${product.brand} (In Stock: ${product.stock})
            </option>
          </c:forEach>
        </select>
      </td>
    </tr>
    <tr>
      <td>Quantity:</td>
      <td><input type="number" name="quantity" id="quantityInput0" required onchange="calculateSumPrice()"></td>
    </tr>
    <tr>
      <td>Import Price:</td>
      <td><input type="text" name="importPrice" id="importPrice0" required onchange="calculateSumPrice()"></td>
    </tr>

    <!-- Placeholder for more product rows -->
    <tr id="addProductRow">
      <td colspan="2">
        <button type="button" onclick="addProductRow()">Add More Products</button>
      </td>
    </tr>
    <tr>
      <td>Sum Price:</td>
      <td><input type="number" id="sumPrice" name="sumPrice"/></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="submit" value="Create Import"></td>
    </tr>
  </table>
</form>

<a href="${pageContext.request.contextPath}/admin/list_import">Back to Import List</a>

<script>
  window.onload = function() {
    updateQuantity(0);
    calculateSumPrice();
  };
</script>
</body>
</html>
