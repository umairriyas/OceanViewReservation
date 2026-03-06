<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OceanView Hotel - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>🌊 OceanView Hotel</h2>
        <h3>Staff Login</h3>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <p class="error-msg"><%= error %></p>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Enter username" required />
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required />
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>
    </div>
</div>
</body>
</html>
