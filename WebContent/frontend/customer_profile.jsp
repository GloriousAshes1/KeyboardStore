<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Profile - KeyBoard Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/profile_style.css">
</head>
<body>
    <header><jsp:directive.include file="header.jsp"/></header>
    <div class="profile">
        <div class="head">
            <h3>Welcome, ${loggedCustomer.fullname}</h3>
        </div>
        <div class="main-form">
            <div class="main">
                <div class="card">
                    <div class="text-wrappers">
                        <div class="text-wrapper">Email:<input class="input-box" name="email"value="${loggedCustomer.email}" disabled id="custom-disabled"></div>
                        <div class="text-wrapper">First Name:<input class="input-box"id="firstname" name="firstname" value="${loggedCustomer.firstname}" readonly></div>
                        <div class="text-wrapper">Last Name:<input class="input-box"id="lastname" name="lastname" value="${loggedCustomer.lastname}" readonly></div>
                        <div class="text-wrapper">Phone:<input class="input-box"id="phone" name="phone" value="${loggedCustomer.phone}" readonly></div>
                        <div class="text-wrapper">Primary Address:<input class="input-box"id="address1" name="address1" value="${loggedCustomer.addressLine1}" readonly></div>
                        <div class="text-wrapper">Secondary Address:<input class="input-box"id="address2" name="address2" value="${loggedCustomer.addressLine2}" readonly></div>
                        <div class="text-wrapper">City:<input class="input-box"id="city" name="city" value="${loggedCustomer.city}"readonly></div>
                        <div class="text-wrapper">State:<input class="input-box"id="state" name="state" value="${loggedCustomer.state}"readonly></div>
                        <div class="text-wrapper">Zip Code:<input class="input-box"id="zipcode" name="zipcode" value="${loggedCustomer.zipcode}"readonly></div>
                        <div class="text-wrapper">Country:<input class="input-box"id="country" name="country" value="${loggedCustomer.countryName}"readonly></div>
                        <div class="btn" onclick="window.location='edit_profile'">Edit profile</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer><jsp:directive.include file="footer.jsp" /></footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
