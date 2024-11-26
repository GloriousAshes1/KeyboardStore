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
    
    <div align="center">
        <form id="reviewForm" action="submit_review" method="post">
            <table class="normal" width="80%">
                <tr>
                    <td><h2>Your Reviews</h2></td>
                    <td>&nbsp;</td>
                    <td><h2>${loggedCustomer.fullname}</h2></td>
                </tr>
                <tr>
                    <td colspan="3"><hr/></td>
                </tr>
                <tr>
                    <td>
                        <span id="product-title">${product.productName}</span><br/>
                        <img class="product-large" src="${product.image}"/>
                    </td>
                    <td>
                        <div id="rateYo"></div>
                        <input type="hidden" id="rating" name="rating" />
                        <input type="hidden" name="productId" value="${product.productId}" />
                        
                        <br/>
                        <input type="text" name="headline" size="60" placeholder="Headline or Summary for your review (required)" />
                        <br/><br/>
                        <textarea name="comment" cols="70" rows="10" placeholder="Write your review details..."></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <button type="submit">Submit</button>
                        &nbsp;&nbsp;
                        <button id="buttonCancel" >Cancel</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    
    <%@ include file="footer.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>

    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function($) {
            $("#buttonCancel").click(function() {
                history.go(-1);
            });
            
            $("#reviewForm").validate({
                rules: {
                    headline: "required",
                    comment: "required",
                },
                
                messages: {
                    headline: "Please enter headline",
                    comment: "Please enter review details"
                }
            });
            
            $("#rateYo").rateYo({
                starWidth: "40px",
                fullStar: true,
                onSet: function (rating, rateYoInstance){
                    $("#rating").val(rating);   
                }
             });
        });
    </script>
</body>
</html>
