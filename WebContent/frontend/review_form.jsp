<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Write Review</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>

    <style>
        .product-large {
            width: 300.35px;
            height: 180.92px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div style="margin: 20px auto; width: 80%;">
    <h2 style="text-align: center;">Your Review</h2>
    <form id="reviewForm" action="submit_review" method="post" style="border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
        <div style="display: flex; align-items: flex-start; gap: 20px;">
            <!-- Product Information -->
            <div style="flex: 1; text-align: center;">
                <span id="product-title" style="display: block; font-weight: bold;">${product.productName}</span>
                <img class="product-large" src="${product.image}" style="width: 200px; height: 200px; border: 1px solid #ddd; border-radius: 4px;"/>
            </div>

            <!-- Review Inputs -->
            <div style="flex: 2;">
                <!-- Rating -->
                <div id="rateYo" style="margin-bottom: 10px;"></div>
                <input type="hidden" id="rating" name="rating" />
                <input type="hidden" name="productId" value="${product.productId}" />

                <!-- Review Title -->
                <input
                        type="text"
                        name="headline"
                        size="60"
                        placeholder="Review title"
                        style="display: block; width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px;"/>

                <!-- Review Details -->
                <textarea
                        name="comment"
                        cols="70"
                        rows="10"
                        placeholder="Review Detail"
                        style="display: block; width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;"></textarea>
            </div>
        </div>

        <!-- Submit and Cancel Buttons -->
        <div style="text-align: center; margin-top: 20px; margin-left: auto;">
            <button
                    type="submit"
                    style="background-color: #007bff; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;margin-left: auto;">Submit</button>
            &nbsp;&nbsp;
            <button
                    id="buttonCancel"
                    type="button"
                    style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;margin-left: auto;">Cancel</button>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>

<script type="text/javascript">
    $.noConflict();
    jQuery(document).ready(function($) {
        // Cancel button action
        $("#buttonCancel").click(function() {
            history.go(-1);
        });

        // Form validation
        $("#reviewForm").validate({
            rules: {
                headline: "required",
                comment: "required",
            },
            messages: {
                headline: "Please enter the review title",
                comment: "Please enter the review details"
            }
        });

        // Star rating
        $("#rateYo").rateYo({
            starWidth: "30px",
            fullStar: true,
            onSet: function (rating, rateYoInstance) {
                $("#rating").val(rating);
            }
        });
    });
</script>
</body>
</html>
