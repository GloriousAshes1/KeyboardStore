<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="read_message.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Create New Product</title>
	<jsp:directive.include file="head.jsp"/>
</head>
<jsp:directive.include file="table_config.jsp"/>
<body>
<jsp:directive.include file="header.jsp"/>
<jsp:directive.include file="notification.jsp"/>

<div class="content">
	<h2 class="page-heading" align="center">
		<c:if test="${product != null}">
			Edit Product
		</c:if>
		<c:if test="${product == null}">
			Create New Product
		</c:if>
	</h2>

	<c:if test="${product != null}">
	<form action="update_product" method="post" id="productForm" enctype='multipart/form-data' style="max-width: 600px; margin:0 auto;">
		<input type="hidden" name="productId" value="${product.productId}"/>
		</c:if>

		<c:if test="${product == null}">
		<form action="create_product" method="post" id="productForm" enctype='multipart/form-data' style="max-width: 600px; margin:0 auto;">
			</c:if>

			<table class="form">
				<!-- Category -->
				<tr>
					<td align="right">Category:</td>
					<td align="left">
						<select name="category" id="category">
							<c:forEach items="${listCategory}" var="category">
								<option value="${category.categoryId}" ${category.categoryId == product.category.categoryId ? 'selected' : ''}>
										${category.name}
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>

				<!-- Product Name -->
				<tr>
					<td align="right">Product Name:</td>
					<td align="left">
						<input type="text" name="productName" id="productName" value="${product.productName}"/>
					</td>
				</tr>

				<!-- Brand -->
				<tr>
					<td align="right">Brand:</td>
					<td align="left">
						<input type="text" name="brand" id="brand" value="${product.brand}"/>
					</td>
				</tr>

				<!-- Code -->
				<tr>
					<td align="right">Code:</td>
					<td align="left">
						<input type="text" name="code" id="code" value="${product.code}"/>
					</td>
				</tr>

				<!-- Publish Date -->
				<tr>
					<td align="right">Publish Date:</td>
					<td align="left">
						<input type="date" name="publishDate" id="publishDate"
							   value="<fmt:formatDate pattern='yyyy-MM-dd' value='${product.publishDate}'/>"/>
					</td>
				</tr>

				<!-- Image -->
				<tr>
					<td align="right">Image:</td>
					<td align="left">
						<c:if test="${product == null}">
							<input type="file" name="image" id="image" class="form-control" />
							<img id="thumbnail" alt="Image Preview" class="image-preview" src="" />
						</c:if>

						<c:if test="${product != null}">
							<input type="hidden" name="existingImage" value="${product.image}" />
							<input type="file" name="image" id="image" class="form-control" />
							<img id="thumbnail" alt="Image Preview" class="image-preview" src="${product.image}" />
						</c:if>
					</td>
				</tr>

				<!-- Selling Price -->
				<tr>
					<td align="right">Price:</td>
					<td align="left">
						<input type="number" name="sellingPrice" id="sellingPrice" step="0.01" value="${product.sellingPrice}" oninput="if(this.value<1){this.value=1}" value="1.00" min="1" step="0.01"/>
					</td>
				</tr>

				<!-- Description -->
				<tr>
					<td align="right">Description:</td>
					<td align="left">
						<textarea rows="5" cols="50" name="description" id="description">${product.description}</textarea>
					</td>
				</tr>

				<!-- Spacer -->
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div align="center">
				<button type="submit" class="btn btn-primary">Save</button>
				<button type="button" class="btn btn-secondary" onclick="history.go(-1);">Cancel</button>
			</div>
		</form>

		<jsp:directive.include file="footer.jsp"/>
</div>
</body>



<script>
	$(document).ready(function () {
		// Hiển thị preview ảnh và kiểm tra định dạng
		$("#image").on("change", function () {
			const file = this.files[0];
			const thumbnail = $("#thumbnail");

			if (file) {
				const validExtensions = ["png", "jpg", "jpeg"];
				const fileExtension = file.name.split(".").pop().toLowerCase();

				if (!validExtensions.includes(fileExtension)) {
					showError("Image", "INVALID_INPUT");
					this.value = ""; // Xóa file đã chọn
					thumbnail.attr("src", ""); // Xóa preview
					return;
				}

				// Kiểm tra kích thước file (giới hạn 2MB)
				const maxSize = 2 * 1024 * 1024; // 2MB
				if (file.size > maxSize) {
					showError("Image", "FILE_TOO_LARGE");
					this.value = ""; // Xóa file đã chọn
					thumbnail.attr("src", ""); // Xóa preview
					return;
				}

				// Hiển thị preview nếu hợp lệ
				const reader = new FileReader();
				reader.onload = function (e) {
					thumbnail.attr("src", e.target.result);
				};
				reader.readAsDataURL(file);
			} else {
				thumbnail.attr("src", ""); // Xóa preview nếu không chọn file
				showError("Image","INVALID_INPUT")
			}
		});
	});

	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;
	// Xử lý khi form được submit
		$(document).ready(function() {
			$("#productForm").on("submit", function(event) {
				if (!validateFormInput()) {
					event.preventDefault(); // Chặn gửi form nếu có lỗi
				}
			});
		});

	// Hàm validate form
	function validateFormInput() {
		var fields = [
			{ id: "productName", label: "Product Name" },
			{ id: "brand", label: "Brand" },
			{ id: "code", label: "Code" },
			{ id: "publishDate", label: "Publish Date" },
			{ id: "sellingPrice", label: "Price" },
		];

		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var fieldName = $("#" + field.id);
			var inputValue = fieldName.val().trim();

			if (inputValue.length === 0) {
				showError(field.label, "NULL_INPUT");
				fieldName.focus();
				return false;
			}

			if (field.id === "productName" || field.id === "brand") {
				if (inputValue.length > 50) {
					showError(field.label, "OVER_LENGTH_ERROR");
					fieldName.focus();
					return false;
				}
			}

			if (field.id === "code" && inputValue.length > 13) {
				showError(field.label, "OVER_LENGTH_ERROR");
				fieldName.focus();
				return false;
			}
			if (field.id === "code" && (!/^\d{12,13}$/.test(inputValue))) {
				showError(field.label, "INVALID_INPUT");
				fieldName.focus();
				return false;
			}

			if (field.id === "sellingPrice") {
				var price = parseFloat(inputValue);

				// Kiểm tra nếu không phải là số hoặc <= 0
				if (isNaN(price) || price <= 0 || !/^\d+(\.\d{1,2})?$/.test(inputValue)) {
					showError(field.label, "INVALID_INPUT");
					fieldName.focus();
					return false;
				}
			}
		}

		// Kiểm tra hình ảnh
		var imageField = $("#image");
		if (imageField.length > 0 && imageField[0].files.length === 0) {
			showError("Image", "NULL_INPUT");
			imageField.focus();
			return false;
		}
		return true; // Tất cả các kiểm tra đều hợp lệ
	}

	// Hàm hiển thị lỗi
	function showError(name, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(name + " " + message);
		}
	}
</script>
</html>