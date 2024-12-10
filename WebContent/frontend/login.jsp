<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In - Keyboard Store</title>
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <script src="https://kit.fontawesome.com/afcbf95f02.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://js.hcaptcha.com/1/api.js" async defer></script>
</head>
<body>
    <div id="wrapper">
        <form id="form-login" action="login" method="post">
            <img src="images/Logo.png" height="100" width="100" alt="Store Logo" align="center"/>
        <h1 class = "form-heading">Keyboard Store</h1>
        <h2 class = "form-heading">Sign In</h2>

        <c:if test="${message != null}">
            <div class="form-error">${message}</div>
        </c:if>
            <div class="form-group">
                <i class="fa-solid fa-user"></i>
                <input type="email" class="form-input" name="email"
                       required minlength="3" maxlength="30" placeholder="Email">
            </div>
            <div class="form-group">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name="password"
                       required minlength="3" maxlength="30" placeholder="Password">
            </div>
            <div class="form-group">
                <div class="h-captcha" data-sitekey="dce64bd6-264a-42f6-a44a-1dc47b56b660"></div>
            </div>
            <a href="register" align="right">Don't have an account yet?</a>
            <input type="submit" value="Log in" class="form-submit">
        </form>
    </div>
</body>
</html>
