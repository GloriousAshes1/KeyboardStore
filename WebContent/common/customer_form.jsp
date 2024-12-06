<table class="form">
	<tr>
		<td align="right">E-mail:</td>
		<td align="left">
			<input type="text" id="email" name="email" size="45"
				   value="${email != null ? email : (customer != null ? customer.email : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">First Name:</td>
		<td align="left">
			<input type="text" id="firstName" name="firstName" size="45"
				   value="${firstName != null ? firstName : (customer != null ? customer.firstname : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Last Name:</td>
		<td align="left">
			<input type="text" id="lastName" name="lastName" size="45"
				   value="${lastName != null ? lastName : (customer != null ? customer.lastname : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Password:</td>
		<td align="left">
			<input type="password" id="password" name="password" size="45"
				   value="${password != null ? password : (customer != null ? customer.password : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Confirm Password:</td>
		<td align="left">
			<input type="password" id="confirmPassword" name="confirmPassword" size="45"
				   value="${confirmPassword != null ? confirmPassword : (customer != null ? customer.password : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Phone Number:</td>
		<td align="left">
			<input type="text" class="phone" name="phone" size="45"
				   value="${phone != null ? phone : (customer != null ? customer.phone : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Address Line 1:</td>
		<td align="left">
			<input type="text" id="address1" name="address1" size="45"
				   value="${address1 != null ? address1 : (customer != null ? customer.addressLine1 : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Address Line 2:</td>
		<td align="left">
			<input type="text" id="address2" name="address2" size="45"
				   value="${address2 != null ? address2 : (customer != null ? customer.addressLine2 : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">City:</td>
		<td align="left">
			<input type="text" id="city" name="city" size="45"
				   value="${city != null ? city : (customer != null ? customer.city : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">State:</td>
		<td align="left">
			<input type="text" id="state" name="state" size="45"
				   value="${state != null ? state : (customer != null ? customer.state : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Zip Code:</td>
		<td align="left">
			<input type="text" id="zipCode" name="zipCode" size="45"
				   value="${zipCode != null ? zipCode : (customer != null ? customer.zipcode : '')}" />
		</td>
	</tr>
	<tr>
		<td align="right">Country:</td>
		<td align="left">
			<select class="form-select" name="country" id="country">
				<c:forEach items="${mapCountries}" var="country">
					<option value="${country.value}"
							<c:if test='${country.value == countryCode}'>selected='selected'</c:if>>${country.key}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="submit" class="btn btn-primary">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-secondary" onclick="history.go(-1);">Cancel</button>
		</td>
	</tr>
</table>

<script>
	var errorMessages = <%= new com.google.gson.Gson().toJson(errorMessages) %>;

	$(document).ready(function() {
		$("#customerForm").on("submit", function(event) {
			event.preventDefault();
			if (!validateFormInput()) {
				return false;
			}
		});
	});

	function validateFormInput() {
		// List of field IDs you want to validate
		var fields = [
			{ id: 'email', label: 'E-mail' },
			{ id: 'firstName', label: 'First Name' },
			{ id: 'lastName', label: 'Last Name' },
			{ id: 'password', label: 'Password' },
			{ id: 'confirmPassword', label: 'Confirm Password' },
			{ id: 'phone', label: 'Phone Number' },
			{ id: 'address1', label: 'Address Line 1' },
			{ id: 'address2', label: 'Address Line 2' },
			{ id: 'city', label: 'City' },
			{ id: 'state', label: 'State' },
			{ id: 'zipCode', label: 'Zip Code' },
			{ id: 'country', label: 'Country' }
		];

		for (var i = 0; i < fields.length; i++) {
			var field = fields[i];
			var fieldName = document.getElementById(field.id);
			var inputValue = fieldName.value.trim();

			// Check for empty value
			if (inputValue.length === 0) {
				showError(field.label, "NULL_INPUT");
				fieldName.focus();
				return false;
			}

			// Check for value exceeding max length
			if (inputValue.length > 30) {
				showError(field.label, "OVER_LENGTH_ERROR");
				fieldName.focus();
				return false;
			}
		}

		return true;  // Return true if all validations passed
	}

	function showError(name, code) {
		var message = errorMessages[code];
		if (message) {
			toastr.error(name + " " + message);
		}
	}
</script>

