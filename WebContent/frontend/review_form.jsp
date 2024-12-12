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
            width: 350px; /* Chiều rộng tự động theo khối cha */
            height: 338px; /* Đảm bảo tỷ lệ hình ảnh */
            max-width: 100%; /* Không vượt quá khối cha */
            object-fit: contain; /* Đảm bảo hình ảnh không bị cắt */
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div style="margin: 20px auto; width: 80%;">
    <h2 style="text-align: center;">Your Review</h2>
    <form id="reviewForm" action="submit_review" method="post" style="border: 1px solid #ccc; padding: 20px; border-radius: 8px;">
        <div style="display: flex; align-items: flex-start; gap: 20px;">
            <!-- Thông tin sản phẩm -->
            <div style="flex: 1; text-align: center;">
                <span id="product-title" style="display: block; font-weight: bold;">${product.productName}</span>
                <img class="product-large" src="${product.image}" />
            </div>

            <!-- Đầu vào đánh giá -->
            <div style="flex: 2;">
                <!-- Đánh giá sao -->
                <div id="rateYo" style="margin-bottom: 10px;"></div>
                <input type="hidden" id="rating" name="rating" />
                <input type="hidden" name="productId" value="${product.productId}" />

                <!-- Tiêu đề đánh giá -->
                <input
                        type="text"
                        name="headline"
                        size="60"
                        placeholder="Review title"
                        style="display: block; width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 4px;"/>

                <!-- Nội dung đánh giá -->
                <textarea
                        name="comment"
                        cols="70"
                        rows="10"
                        placeholder="Review Detail"
                        style="display: block; width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px;"></textarea>
            </div>
        </div>

        <!-- Nút Gửi và Hủy -->
        <div style="text-align: center; margin-top: 20px;">
            <button
                    type="submit"
                    style="background-color: #007bff; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;">Submit</button>
            &nbsp;&nbsp;
            <button
                    id="buttonCancel"
                    type="button"
                    style="background-color: #dc3545; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer;">Cancel</button>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>

<script type="text/javascript">
    $.noConflict();
    jQuery(document).ready(function($) {
        // Hành động nút hủy
        $("#buttonCancel").click(function() {
            history.go(-1);
        });

        // Xác thực biểu mẫu
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

        // Đánh giá sao
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