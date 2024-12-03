<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - KeyBoard Store</title>
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="css/globals.css" />
    <link rel="stylesheet" href="css/styleguide.css" />
    <link rel="stylesheet" href="css/product_style.css"/>
</head>
<body>
    <header><jsp:directive.include file="header.jsp"/></header>
    <div class="product-detail-form">
        <!-- main -->
        <div class="main">
            <!-- product name and reviews -->
            <div class="product-title">
                <div class="product-name">${product.productName}</div>
                <div class="average-rate">
                    <jsp:directive.include file="product_rating.jsp" /> (${product.sumReviews} Ratings)
                </div>
            </div>
            <!-- product content -->
            <div class="product-content">
                <div class="product-img">
                    <img class="product-img" src="${product.image}" alt="${product.productName}">
                </div>
                <div class="detail">
                    <div class="row">
                        <div class="brand font">Brand: ${product.brand}<div>Code: ${product.code}</div></div>
                        <div class="description">Description: ${product.description}</div>
                    </div>
                    <div class="row1">
                        <div class="font">Price: <fmt:formatNumber value="${product.sellingPrice}" type="currency"/></div>
                        <button class="btn-add-to-cart" onclick="window.location = 'add_to_cart?product_id=' + ${product.productId}">Add to Cart</button>
                    </div>
                </div>
            </div>
            <!-- review -->
            <div class="reviews">
                <div class="header-container">
                    <div class="reviews-header">
                        <div class="reviews-title">
                            Review(s)
                        </div>
                        <button class="write-review-btn" onclick="window.location = 'write_review?product_id=' + ${product.productId}">Write a review</button>
                    </div>
                </div>
                <div class="reviews-grid">
                    <c:forEach items="${product.reviews}" var="review" varStatus="loop">
                        <div class="review-card">
                            <div class="review-rating">
                                <c:forTokens items="${review.stars}" delims="," var="star">
                                    <c:if test="${star eq 'on'}">
                                        <img class="rating-star" alt="*" src="images/full-star.png" />
                                    </c:if>
                                    <c:if test="${star eq 'off'}">
                                        <img class="rating-star" alt="*" src="images/no-star.png" />
                                    </c:if>
                                </c:forTokens>
                            </div>
                            <div class="review-content">
                            <h3 class="review-title">${review.headline}</h3>
                            <p class="review-text">${review.comment}</p>
                            </div>
                            <div class="reviewer">
                            <div class="reviewer-info">
                                <p class="reviewer-name">${review.customer.fullname}</p>
                                <time class="review-date"><fmt:formatDate value="${review.reviewTime}" pattern="yyyy-MM-dd HH:mm" /></time>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
        </div>

    </div>
    <footer>
        <jsp:directive.include file="footer.jsp" />
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.read-more').forEach(function(readMore) {
                readMore.addEventListener('click', function() {
                    const textBlock = readMore.parentElement;
                    textBlock.querySelector('.short-text').style.display = 'none';
                    readMore.style.display = 'none';
                    textBlock.querySelector('.full-text').style.display = 'inline';
                });
            });
        });

        $(document).ready(function() {
            $("#buttonWriteReview").click(function() {
                window.location = 'write_review?product_id=' + ${product.productId};
            });

            $("#buttonAddToCart").click(function() {
                window.location = 'add_to_cart?product_id=' + ${product.productId};
            });
        });
    </script>
</body>
</html>
