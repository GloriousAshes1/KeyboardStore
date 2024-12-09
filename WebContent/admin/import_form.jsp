<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <title>Create New Import</title>
  <jsp:directive.include file="head.jsp"/>
  <script>
    function updateTotals() {
      const rows = document.getElementById("productTable").getElementsByTagName('tbody')[0].rows;
      let totalItems = 0;
      let totalPrice = 0;

      for (let i = 0; i < rows.length; i++) {
        const quantityInput = rows[i].cells[1].querySelector('input[type="number"]');
        const importPriceInput = rows[i].cells[2].querySelector('input[type="number"]');

        let quantity = parseInt(quantityInput.value) || 0;
        let importPrice = parseFloat(importPriceInput.value) || 0;

        totalItems += quantity;
        totalPrice += quantity * importPrice;
      }

      document.getElementById("totalItems").textContent = "Total Items: " + totalItems;
      document.getElementById("totalPrice").textContent = "Total Price: $" + totalPrice.toFixed(2);
    }

    function addProductRow() {
      const table = document.getElementById("productTable").getElementsByTagName('tbody')[0];
      const index = table.rows.length;

      const newRow = table.insertRow();

      newRow.innerHTML = `
        <td>
          <select class="form-select" name="productId" id="productSelect${index}" onchange="updateProductOptions()" required>
            <option value="" selected="false">Chọn sản phẩm</option>
            <c:forEach items="${listProduct}" var="product">
              <option value="${product.productId}" data-stock="${product.stock}">
                ${product.productName} - ${product.brand} (In Stock: ${product.stock})
              </option>
            </c:forEach>
          </select>
        </td>
        <td>
          <input type="number" class="form-control" name="quantity" id="quantityInput${index}" required onchange="updateTotals()" value="1" min="1">
        </td>
        <td>
            <input type="number" class="form-control" name="importPrice" id="importPrice" required onchange="updateTotals()" oninput="if(this.value<1){this.value=1}" value="1.00" min="1" step="0.01">
        </td>
        <td class="d-flex justify-content-center align-items-center">
          <button class="btn btn-danger" type="button" onclick="deleteProductRow(this)">
            <i class="fa-solid fa-trash" style="color: white;"></i>
          </button>
        </td>
      `;
      updateProductOptions();
    }

    function updateProductOptions() {
      const selects = document.querySelectorAll('select[name="productId"]');
      const selectedValues = new Set();

      selects.forEach(select => {
        if (select.value) {
          selectedValues.add(select.value);
        }
      });

      selects.forEach(select => {
        const options = select.options;
        for (let i = 0; i < options.length; i++) {
          if (selectedValues.has(options[i].value) && select.value !== options[i].value) {
            options[i].style.display = 'none';
          } else {
            options[i].style.display = '';
          }
        }
      });

      updateTotals();
    }

    function deleteProductRow(button) {
      const row = button.parentNode.parentNode;
      row.parentNode.removeChild(row);
      updateProductOptions();
    }


    window.onload = function() {
      updateTotals();
      updateProductOptions();
    };
  </script>
</head>
<body>
<jsp:directive.include file="header.jsp"/>
<div class="content">
  <div class="text-center mb-4">
    <h2 class="text-dark">Create New Import</h2>
  </div>
  <div class="mb-4 text-center">
    <h5>Created By: ${requestScope.fullName} (UserID: ${sessionScope.userId})</h5>
    <h5>Created Date: <%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %></h5>
  </div>
  <form action="create_import" method="post">
    <div class="table-responsive mb-4">
      <table class="table table-striped table-hover" id="productTable">
        <thead class="table-primary text-center">
        <tr>
          <th>Product</th>
          <th>Quantity</th>
          <th>Import Price</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>
            <select class="form-select" name="productId" id="productSelect0" onchange="updateProductOptions()">
              <c:forEach items="${listProduct}" var="product">
                <option value="${product.productId}" data-stock="${product.stock}">
                    ${product.productName} - ${product.brand} (In Stock: ${product.stock})
                </option>
              </c:forEach>
            </select>
          </td>
          <td>
            <input type="number" class="form-control" name="quantity" id="quantityInput0" required onchange="updateTotals()" value="1" min="1">
          </td>
          <td>
            <input type="number" class="form-control" name="importPrice" id="importPrice" required onchange="updateTotals()" oninput="if(this.value<1){this.value=1}" value="1.00" min="1" step="0.01">
          </td>
          <td class="d-flex justify-content-center align-items-center">
            <button class="btn btn-danger" type="button" onclick="deleteProductRow(this)">
              <i class="fa-solid fa-trash" style="color: white;"></i>
            </button>
          </td>
        </tr>
        </tbody>
        <tfoot>
        <tr>
          <td></td>
          <td class="text-right fw-bold fs-5" id="totalItems"></td>
          <td class="text-right fw-bold fs-5" id="totalPrice"></td>
          <td></td>
        </tr>
        </tfoot>
      </table>
    </div>
    <div class="text-center mb-4">
      <button class="btn btn-success" type="button" onclick="addProductRow()">Add More Products</button>
    </div>
    <div class="d-flex justify-content-center gap-3">
      <button class="btn btn-primary" type="submit" onclick="validateProductSelection()">Save</button>
      <button class="btn btn-secondary" type="button" onclick="history.go(-1);">Cancel</button>
    </div>
  </form>
  <jsp:directive.include file="footer.jsp" />
</div>
</body>
</html>