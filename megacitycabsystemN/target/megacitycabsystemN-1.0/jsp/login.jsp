<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script>
        function showNotification(message, type) {
            var notification = document.createElement("div");
            notification.className = "notification " + type;
            notification.innerText = message;
            document.body.appendChild(notification);

            setTimeout(function () {
                notification.style.opacity = "0";
                setTimeout(() => notification.remove(), 500);
            }, 3000);
        }
    </script>
    <style>
        /* General Page Styles */
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

        /* Login Form Container */
        .my-div {      
            background: #ffffff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }

        /* Header Styles */
        h1 {
            color: #333;
        }

        h2 {
            color: #555;
            font-size: 18px;
        }

        /* Form Input Styles */
        .input-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .input-group label {
            display: block;
            font-weight: bold;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        /* Button Styles */
        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        /* Extra Links Styles */
        .extra-links {
            margin-top: 10px;
        }

        .extra-links a {
            color: #0000EE;
            text-decoration: none;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: green;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            opacity: 1;
            transition: opacity 0.5s;
            z-index: 1000;
        }
        .notification.error { background: red; }
    </style>
</head>
<body>
    
    <%-- Show notification from request parameter --%>
    <%
        String successMessage = request.getParameter("success");
        String errorMessage = request.getParameter("error");
        if (successMessage != null) { %>
        <script> showNotification("<%= successMessage %>", "success"); </script>
    <% } else if (errorMessage != null) { %>
        <script> showNotification("<%= errorMessage %>", "error"); </script>
    <% } %>
    
    <div class="my-div">
        <h1>Welcome Back..🚗</h1>
        <h2>Sign in to continue</h2>
        <form action="../LoginServlet" method="post">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Login</button>
        </form>

        <div class="extra-links">
            <a href="#">Forgot Password?</a><br>
            <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            <p>Want to register as a driver? <a href="driver.jsp">Register as Driver</a></p>
        </div>
    </div>
</body>
</html>
