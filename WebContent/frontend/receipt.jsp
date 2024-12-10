<div style="border: 1px solid #ccc; padding: 20px; border-radius: 8px; margin-top: 20px;">
	<h3>Your Payment Receipt</h3>

	<div style="border: 1px solid #ddd; border-radius: 8px; padding: 10px; margin-bottom: 20px;">
		<h2 style="text-align: center; border-bottom: 1px solid #ccc; padding-bottom: 10px;">Seller Information</h2>
		<table style="width: 100%; margin-bottom: 20px; border-collapse: collapse; text-align: center;">
			<tr>
				<td style="width: 30%; padding: 8px;"><b>Email:</b></td>
				<td style="padding: 8px;">sales@keyboardstore.com</td>
			</tr>
			<tr>
				<td style="padding: 8px;"><b>Phone:</b></td>
				<td style="padding: 8px;">+84 123456789</td>
			</tr>
		</table>
	</div>

	<div style="border: 1px solid #ddd; border-radius: 8px; padding: 10px; margin-bottom: 20px;">
		<h2 style="text-align: center; border-bottom: 1px solid #ccc; padding-bottom: 10px;">Buyer Information</h2>
		<table style="width: 100%; margin-bottom: 20px; border-collapse: collapse; text-align: center;">
			<tr>
				<td style="width: 30%; padding: 8px;"><b>First Name:</b></td>
				<td style="padding: 8px;">${payer.firstName}</td>
			</tr>
			<tr>
				<td style="padding: 8px;"><b>Last Name:</b></td>
				<td style="padding: 8px;">${payer.lastName}</td>
			</tr>
			<tr>
				<td style="padding: 8px;"><b>E-mail:</b></td>
				<td style="padding: 8px;">${payer.email}</td>
			</tr>
		</table>
	</div>

	<div style="border: 1px solid #ddd; border-radius: 8px; padding: 10px; margin-bottom: 20px;">
		<h2 style="text-align: center; border-bottom: 1px solid #ccc; padding-bottom: 10px;">Order Details</h2>
		<table style="width: 100%; margin-bottom: 20px; border-collapse: collapse; text-align: center;">
			<tr>
				<td style="width: 30%; padding: 8px;"><b>Order ID:</b></td>
				<td style="padding: 8px;">${orderId}</td>
			</tr>
			<tr>
				<td style="padding: 8px;"><b>Ordered By:</b></td>
				<td style="padding: 8px;">${loggedCustomer.fullname}</td>
			</tr>
			<tr>
				<td style="padding: 8px;"><b>Transaction Description:</b></td>
				<td style="padding: 8px;">${transaction.description}</td>
			</tr>
		</table>
	</div>

	<div style="border: 1px solid #ddd; border-radius: 8px; padding: 10px; margin-bottom: 20px;">
		<h2 style="text-align: center; border-bottom: 1px solid #ccc; padding-bottom: 10px;">Items</h2>
		<table style="width: 100%; border: 1px solid #ddd; border-collapse: collapse; text-align: center;">
			<tr style="background-color: #f9f9f9;">
				<th style="border: 1px solid #ddd; padding: 8px;">No.</th>
				<th style="border: 1px solid #ddd; padding: 8px;">Name</th>
				<th style="border: 1px solid #ddd; padding: 8px;">Quantity</th>
				<th style="border: 1px solid #ddd; padding: 8px;">Price</th>
				<th style="border: 1px solid #ddd; padding: 8px;">Subtotal</th>
			</tr>
			<c:forEach items="${transaction.itemList.items}" var="item" varStatus="var">
				<tr>
					<td style="border: 1px solid #ddd; padding: 8px;">${var.index + 1}</td>
					<td style="border: 1px solid #ddd; padding: 8px;">${item.name}</td>
					<td style="border: 1px solid #ddd; padding: 8px;">${item.quantity}</td>
					<td style="border: 1px solid #ddd; padding: 8px;">${item.price}</td>
					<td style="border: 1px solid #ddd; padding: 8px;"><fmt:formatNumber value="${item.price * item.quantity}" /></td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5" style="border: 1px solid #ddd; padding: 8px; text-align: right;">
					<p>Subtotal: <fmt:formatNumber value="${transaction.amount.details.subtotal}" type="currency" /></p>
					<p>Tax: <fmt:formatNumber value="${transaction.amount.details.tax}" type="currency" /></p>
					<p>Shipping Fee: <fmt:formatNumber value="${transaction.amount.details.shipping}" type="currency" /></p>
					<p><b>Total: <fmt:formatNumber value="${transaction.amount.total}" type="currency" /></b></p>
				</td>
			</tr>
		</table>
	</div>
</div>