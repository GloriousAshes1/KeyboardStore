<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Create New Product</title>
	<link rel="stylesheet" href="../css/style.css">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
	<link rel="stylesheet" href="..//css/richtext.min.css">
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	
	<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="../js/jquery.richtext.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
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
			<form action="update_product" method="post" id="productForm" enctype='multipart/form-data' style="max-width: 400px; margin:0 auto;">
			<input type="hidden" name="productId" value="${product.productId}"/>
		</c:if>
		<c:if test="${product == null}">
			<form action="create_product" method="post" id="productForm" enctype='multipart/form-data' style="max-width: 400px; margin:0 auto;">
		</c:if>
				<table>
					<tr>
						<td align="right">Category:</td>
						<td align="left">
							<select name="category">
								<c:forEach items="${listCategory}" var="category">
									<c:if test="${category.categoryId eq product.category.categoryId}">
										<option value="${category.categoryId}" selected>
									</c:if>
									<c:if test="${category.categoryId ne product.category.categoryId}">
										<option value="${category.categoryId}">
									</c:if>
										${category.name}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">Product Name:</td>
						<td align="left"><input type="text" name = "productName" id="productName" value= "${product.productName}" required size="20"/></td>
					</tr>
					<tr>
						<td align="right">Brand</td>
						<td align="left"><input type="text" name = "brand" id="brand" value= "${product.brand}" required size="20"/></td>
					</tr>
					<tr>
						<td align="right">Code:</td>
						<td align="left"><input type="text" name = "code"  id="code" value= "${product.code}" required size="20"/></td>
					</tr>					
					<tr>
						<td align="right">Publish Date:</td>
						<td align="left"><input type="date" name = "publishDate"  id="publishDate" 
							value="<fmt:formatDate pattern="yyyy-MM-dd" value='${product.publishDate}'/>" required size="20"/></td>
					</tr>
					<tr>
						<td align="right">Image:</td>
						<td align="left">
						<c:if test="${product == null}">
								<input type="file" name = "image"  id="image" size="20" required/><br/>
								<img id="thumbnail" alt="Image Preview" style="width:20%; margin-top:10px"
									src="data:image/jpg;base64,${product.base64Image}"/>
						</c:if>
						<c:if test="${product != null}">
							<input type="hidden" name="existingImage" value="${product.image}"/>
								<input type="file" name = "image"  id="image" size="20"/><br/>
								<img id="thumbnail" alt="Image Preview" style="width:20%; margin-top:10px"
									src="${product.image}"/>
						</c:if>
						</td>
					</tr>
					<tr>
						<td align="right">Price:</td>
						<td align="left"><input type="text" name = "sellingPrice"  id="sellingPrice" value= "${product.sellingPrice}" required size="20"/></td>
					</tr>
					<tr>
						<td align="right">Description:</td>
						<td align="left">
							<textarea rows="5" cols="50" name="description" id="description" required>${product.description}</textarea>
						</td>
					</tr>

					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" style="text-align: center;">
                        <button class="btn btn-primary" type="submit"> Save</button>
                        <button class="btn btn-secondary" type = "button" onclick="history.go(-1);">Cancel</button>
                    </td>
					</tr>
				</table>
			</form>
		<jsp:directive.include file="footer.jsp"/>
	</div>

</body>
<script type="text/javascript">
	$(document).ready(function() {
		
		$('#description').richText();
		
		$('#image').change(function() {
			showImageThumbnail(this);
		});
	});
	
	function showImageThumbnail(fileInput) {
		var file = fileInput.files[0];
		
		var reader = new FileReader();
		
		reader.onload = function(e) {
			$('#thumbnail').attr('src', e.target.result);
		};
		
		reader.readAsDataURL(file);
	}
</script>
</html>