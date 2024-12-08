<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Admin Login</title>
	<link rel="icon" type="image/x-icon" href="../images/Logo.png">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="../css/login.css">
	<script src="https://kit.fontawesome.com/afcbf95f02.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div id="wrapper">
	<form action="login" id="form-login" method="post">
		<img src="../images/Logo.png" height="100" width="100" alt="Store Logo" align="center"/>
		<h1 class="form-heading">Keyboard Store Administration Login</h1>

		<c:if test="${message != null}">
			<p class="form-error">${message}</p>
		</c:if>

		<div class="form-group">
			<i class="fa-solid fa-user"></i>
			<input type="email" class="form-input" name="email"
				   required minlength="5" maxlength="30" placeholder="Email">
		</div>

		<div class="form-group">
			<i class="fa-solid fa-lock"></i>
			<input type="password" class="form-input" name="password"
				   required minlength="3" maxlength="30" placeholder="Password">
		</div>
		<input type="submit" value="Log in" class="form-submit">
	</form>
</div>
</body>
</html>
