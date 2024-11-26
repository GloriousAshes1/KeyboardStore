<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In - Legendary Gamestore</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.validate.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .container h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }
        .container h2 {
            margin: 10px 0;
            font-size: 18px;
            color: #555;
        }
        .message {
            color: red;
            font-size: 14px;
        }
        form {
            margin-top: 20px;
        }
        table {
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 10px;
        }
        td {
            text-align: left;
            padding: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 200px;
            padding: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #0056b3;
        }
        button#cancelButton {
            background-color: #28a745;
        }
        button#cancelButton:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Legendary Games</h1>
        <h2>Sign Up</h2>

        <c:if test="${message != null}">
            <div class="message">${message}</div>
        </c:if>

        <form action="register_customer" method="post" id="customerForm">
            <table>
                <tr>
                    <td><label for="email">Email:</label></td>
                    <td><input type="text" name="email" id="email" value="${customer.email}"></td>
                </tr>
                <tr>
                    <td><label for="firstName">First Name:</label></td>
                    <td><input type="text" name="firstName" id="firstName" value="${customer.firstname}"></td>
                </tr>
                <tr>
                    <td><label for="lastName">Last Name:</label></td>
                    <td><input type="text" name="lastName" id="lastName" value="${customer.lastname}"></td>
                </tr>
                <tr>
                    <td><label for="password">Password:</label></td>
                    <td><input type="password" name="password" id="password" value="${customer.password}"></td>
                </tr>
                <tr>
                    <td><label for="confirmPassword">Confirm Password:</label></td>
                    <td><input type="password" name="confirmPassword" id="confirmPassword" value="${customer.password}"></td>
                </tr>
                <tr>
                    <td><label for="phone">Phone Number:</label></td>
                    <td><input type="text" name="phone" id="phone" value="${customer.phone}"></td>
                </tr>
                <tr>
                    <td><label for="address1">Address Line 1:</label></td>
                    <td><input type="text" name="address1" id="address1" value="${customer.addressLine1}"></td>
                </tr>
                <tr>
                    <td><label for="address2">Address Line 2:</label></td>
                    <td><input type="text" name="address2" id="address2" value="${customer.addressLine2}"></td>
                </tr>
               <tr>
                    <td><label for="city">City:</label></td>
                    <td><input type="text" name="city" id="city" value="${customer.city}"></td>
                </tr>
                <tr>
                    <td><label for="state">State:</label></td>
                    <td><input type="text" name="state" id="state" value="${customer.state}"></td>
                </tr>
                <tr>
                    <td><label for="zipCode">Zip Code:</label></td>
                    <td><input type="text" name="zipCode" id="zipCode" value="${customer.zipcode}"></td>
                </tr>
                 <tr>
                    <td><label for="country">Country:</label></td>
                    <td><select class="form-select" name="country" id="country">
				<c:forEach items="${mapCountries}" var="country">
					<option value="${country.value}"
						<c:if test='${customer.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
				</c:forEach>
		</select></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <button type="submit" class="btn btn-primary">Sign Up</button>
                        <button type="button" class="btn btn-secondary" id = "cancelButton">Cancel</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
        	$("#cancelButton").click(function(event) {
                event.preventDefault();
                window.location = '${pageContext.request.contextPath}/';
            });
		    $("#customerForm").validate({
		    	rules: {
                    email: {
                        required: true,
                        email: true
                    },
                    firstName: {
                        required: true,
                        minlength: 2
                    },
                    lastName: {
                        required: true,
                        minlength: 2
                    },
                    password: {
                        required: true,
                        minlength: 6
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "#password"
                    },
                    phone: {
                        required: true,
                        minlength: 10,
                        digits: true
                    },
                    address1: {
                        required: true
                    },
                    city: {
                        required: true
                    },
                    state: {
                        required: true
                    },
                    zipCode: {
                        required: true,
                        digits: true
                    },
                    country: {
                        required: true
                    }
                },
                messages: {
                    email: {
                        required: "Please enter your email",
                        email: "Please enter a valid email address"
                    },
                    firstName: {
                        required: "Please enter your first name",
                        minlength: "Your first name must be at least 2 characters long"
                    },
                    lastName: {
                        required: "Please enter your last name",
                        minlength: "Your last name must be at least 2 characters long"
                    },
                    password: {
                        required: "Please provide a password",
                        minlength: "Your password must be at least 6 characters long"
                    },
                    confirmPassword: {
                        required: "Please confirm your password",
                        equalTo: "Please enter the same password as above"
                    },
                    phone: {
                        required: "Please enter your phone number",
                        minlength: "Your phone number must be at least 10 digits long",
                        digits: "Please enter only digits"
                    },
                    address1: {
                        required: "Please enter your address"
                    },
                    city: {
                        required: "Please enter your city"
                    },
                    state: {
                        required: "Please enter your state"
                    },
                    zipCode: {
                        required: "Please enter your zip code",
                        digits: "Please enter only digits"
                    },
                    country: {
                        required: "Please select your country"
                    }
                }
		    });
        });
    </script>
</body>
</html>
