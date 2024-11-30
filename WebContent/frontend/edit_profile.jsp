<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - Legendary Games</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/profile1_style.css">
</head>
<body>
    <jsp:directive.include file="header.jsp" />
    <div class="profile">
        <div class="head">
            Edit Your Profile
        </div>
        <div class="main-form">
            <form action="update_profile" method="post" id="customerForm">
            <div class="main">
                <div class="card">
                    <div class="text-wrappers">
                        <div class="text-wrapper">Email:<input class="input-box1" name="email"value="${loggedCustomer.email}" disabled id="custom-disabled"></div>
                        <div class="text-wrapper">First Name:<input class="input-box"id="firstName" name="firstName" value="${loggedCustomer.firstname}" required></div>
                        <div class="text-wrapper">Last Name:<input class="input-box"id="lastName" name="lastName" value="${loggedCustomer.lastname}" required></div>
                        <div class="text-wrapper">Phone:<input class="input-box"id="phone" name="phone" value="${loggedCustomer.phone}" required></div>
                        <div class="text-wrapper">Primary Address:<input class="input-box"id="address1" name="address1" value="${loggedCustomer.addressLine1}" required></div>
                        <div class="text-wrapper">Secondary Address:<input class="input-box"id="address2" name="address2" value="${loggedCustomer.addressLine2}" required></div>
                        <div class="text-wrapper">City:<input class="input-box"id="city" name="city" value="${loggedCustomer.city}"required></div>
                        <div class="text-wrapper">State:<input class="input-box"id="state" name="state" value="${loggedCustomer.state}"required></div>
                        <div class="text-wrapper">Zip Code:<input class="input-box"id="zipCode" name="zipCode" value="${loggedCustomer.zipcode}"required></div>
                        <div class="text-wrapper">Country:<select class="input-box" name="country" id="country">
                            <c:forEach items="${mapCountries}" var="country">
                                <option value="${country.value}"
                                        <c:if test='${loggedCustomer.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
                            </c:forEach>
                        </select></div>
                        <div class="text-center mb-3">
                            <i>(Leave password blank if you don't want to change password)</i>
                        </div>
                        <div class="text-wrapper">Password:
                            <input type="password" class="input-box" id="password" name="password">
                        </div>
                        <div class="text-wrapper">Confirm:
                            <input type="password" class="input-box" id="confirmPassword" name="confirmPassword">
                        </div>
                        <div class="btn-container">
                            <button class="btn" type="submit">Update</button>
                            <button class="btn-cancel" onclick="window.history.back()">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </div>
    <jsp:directive.include file="footer.jsp" />

    <script>
        $(document).ready(function() {
            $("#customerForm").validate({
                rules: {
                    firstName: "required",
                    lastName: "required",
                    phone: "required",
                    address1: "required",
                    city: "required",
                    state: "required",
                    zipCode: "required",
                    country: "required",
                    password: {
                        minlength: 5
                    },
                    confirmPassword: {
                        equalTo: "#password"
                    }
                },
                messages: {
                    firstName: "Please enter your first name",
                    lastName: "Please enter your last name",
                    phone: "Please enter your phone number",
                    address1: "Please enter your primary address",
                    city: "Please enter your city",
                    state: "Please enter your state",
                    zipCode: "Please enter your zip code",
                    country: "Please select your country",
                    password: {
                        minlength: "Password must be at least 5 characters long"
                    },
                    confirmPassword: {
                        equalTo: "Confirm password does not match password"
                    }
                }
            });

            $("#buttonCancel").click(function() {
                history.go(-1);
            });
        });
    </script>
</body>
</html>
