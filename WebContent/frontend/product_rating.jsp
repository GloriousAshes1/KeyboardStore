<c:forTokens items="${product.ratingStars}" delims="," var="star">
	<c:if test="${star eq 'on' }">
		<img alt="*" src="images/full-star.png" />
	</c:if>
	<c:if test="${star eq 'off' }">
		<img alt="*" src="images/no-star.png" />
	</c:if>
	<c:if test="${star eq 'half' }">
		<img alt="*" src="images/half-star.png" />
	</c:if>
</c:forTokens>