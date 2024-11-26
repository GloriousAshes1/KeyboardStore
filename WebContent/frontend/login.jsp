<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In - Legendary Gamestore</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" type="image/x-icon" href="images/Logo.png">
    <script src="https://js.hcaptcha.com/1/api.js" async defer></script>
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
        input[type="email"],
        input[type="password"] {
            width: 240px;
            padding: 8px;
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
        button#registerButton {
            background-color: #28a745;
        }
        button#registerButton:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="images/Logo.png" height="200" width="200" alt="Store Logo" />
        <h1>Legendary Games</h1>
        <h2>Sign In</h2>

        <c:if test="${message != null}">
            <div class="message">${message}</div>
        </c:if>

        <form id="formLogin" action="login" method="post">
            <table>
                <tr>
                    <td><label for="email">Email:</label></td>
                    <td><input type="email" name="email" id="email" required minlength="3" maxlength="30"></td>
                </tr>
                <tr>
                    <td><label for="password">Password:</label></td>
                    <td><input type="password" name="password" id="password" required minlength="3" maxlength="30"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <div class="h-captcha" data-sitekey="dce64bd6-264a-42f6-a44a-1dc47b56b660"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">
                        <button type="submit">Sign In</button>
                        <button type="button" id="registerButton">Sign Up</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
