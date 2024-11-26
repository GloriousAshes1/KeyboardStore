<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div style="display: inline-block; margin: 20px;">
	<div>
		<a href="view_product?id=${product.productId}"> <img
			src="${product.image}" width="128"
			hieght="164" />
		</a>
	</div>
	<div>
		<a href="view_product?id=${product.productId}"> <b>${product.productName}</b>
		</a>
	</div>
	<div>
 		<jsp:directive.include file="product_rating.jsp" />
 	</div>
	<div>
		${product.code}
	</div>
	<div>
		<b><c:formatNumber value="${product.sellingPrice}" type="currency"/> </b>
	</div>
</div>