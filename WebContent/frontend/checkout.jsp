<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - Keyboard Store</title>
    <link rel="icon" type="image/x-icon" href="../images/Logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.validate.min.js"></script>
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/checkout_style.css">
</head>
<body>
    <header><jsp:directive.include file="header.jsp" /></header>
    <div class="checkout_form">
        <div class="div">
            <div class="main-form">
                <div class="container">
                    <!-- Checkout-card-->
                    <div class="checkout-container">
                        <div class="checkout-card">
                            <div class="checkout-detail-card">
                                <div class="card-title">Checkout Infomation<img class="svg" src="css/images/detail.svg"/></div>
                                <div class="text-wrappers">
                                    <div class="text-wrapper">Subtotal: <div><fmt:formatNumber value="${cart.totalAmount}" type="currency"/></div></div>
                                    <div class="text-wrapper">Tax: <div><fmt:formatNumber value="${tax}" type="currency"/></div></div>
                                    <div class="text-wrapper">Shipping Fee: <div><fmt:formatNumber value="${shippingFee}" type="currency"/></div></div>
                                    <div class="text-wrapper">Total: <div><fmt:formatNumber value="${total}" type="currency"/></div></div>
                                </div>
                                <div class="edit-cart" onclick="window.location='view_cart'">&lt; Edit Cart</div>
                            </div>
                        </div>
                    </div>
                    <!-- Shipping Information Form -->
                    <form id="informationForm" action="place_order" method="POST">
                    <div class="information-container">
                        <div class="information-card">
                            <div class="information-detail-card">
                                <div class="card-title">Shipping Information</div>
                                <div class="text-wrappers">
                                    <div class="text-wrapper">First Name:<input class="input-box"id="firstname" name="firstname" value="${loggedCustomer.firstname}"></div>
                                    <div class="text-wrapper">Last Name:<input class="input-box"id="lastname" name="lastname" value="${loggedCustomer.lastname}"></div>
                                    <div class="text-wrapper">Phone:<input class="input-box"id="phone" name="phone" value="${loggedCustomer.phone}"></div>
                                    <div class="text-wrapper">Primary Address:<input class="input-box"id="address1" name="address1" value="${loggedCustomer.addressLine1}"></div>
                                    <div class="text-wrapper">Secondary Address:<input class="input-box"id="address2" name="address2" value="${loggedCustomer.addressLine2}"></div>
                                    <div class="text-wrapper">City:<input class="input-box"id="city" name="city" value="${loggedCustomer.city}"></div>
                                    <div class="text-wrapper">State:<input class="input-box"id="state" name="state" value="${loggedCustomer.state}"></div>
                                    <div class="text-wrapper">Zip Code:<input class="input-box"id="zipcode" name="zipcode" value="${loggedCustomer.zipcode}"></div>
                                    <div class="text-wrapper">Country:<select class="input-box" name="country" id="country">
                                        <c:forEach items="${mapCountries}" var="country">
                                            <option value="${country.value}"
                                                    <c:if test='${loggedCustomer.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
                                        </c:forEach>
                                    </select> </div>
                                    <div class="text-wrapper">Payment method:<select class="input-box"id="paymentMethod" name="paymentMethod">
                                        <option value="Cash On Delivery">Cash On Delivery</option>
                                        <option value="paypal">Paypal</option>
                                    </select> </div>
                                    <div class="place-order" onclick="submitUpdate()">Update &gt;</div>
                                    <div class="place-order" onclick="submitForm()">Place Order &gt;</div>

                                    <!--<div class="place-order" onclick="updateShippingFee()">Update Address</div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <jsp:directive.include file="footer.jsp" />
    <script>
        function submitUpdate() {
            // Change form action to update_checkout before submitting
            document.getElementById('informationForm').action = 'update_shipping_fee';
            document.getElementById('informationForm').submit();
        }

        function submitForm() {
            const form = document.getElementById('informationForm');
            if(form){
                form.submit();
            }else {
                console.error("form not found");
            }
        }
    </script>
</body>
</html>
