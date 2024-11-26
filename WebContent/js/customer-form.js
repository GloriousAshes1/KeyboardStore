$(document).ready(function() {
		var phonePattern = /^0\d{9}$/
		$("#customerForm").validate({
			rules : {
				email : {
					required : true,
					email : true
				},
				firstName : "required",
				lastName : "required",
				password : "required",

				confirmPassword : {
					required : true,
					equalTo : "#password"
				},

				phone : {
					required : true,
					maxlength : 10,
					minlength : 10
				},
				address1 : "required",
				address2 : "required",
				city : "required",
				state : "required",
				zipCode : "required",
				country : "required",
			},

			messages : {
				email : {
					required : "Please enter e-mail address",
					email : "Please enter a valid e-mail address"
				},

				firstName : "Please enter first name",
				lastName : "Please enter last name",
				password : "Please enter password",

				confirmPassword : {
					required : "Please confirm password",
					equalTo : "Confirm password does not match password"
				},

				phone : {
					required : "Please enter phone number",
					maxlength : "Please enter a valid phone number",
					minlength : "Please enter a valid phone number"
				},
				address1 : "Please enter address 1",
				address2 : "Please enter address 2",
				city : "Please enter city",
				state : "Please enter state",
				zipCode : "Please enter zip code",
				country : "Please enter country",
			}
		});
	});