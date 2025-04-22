<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 4:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f3f3f3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .reset-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 400px;
        }
        h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .error, .success {
            color: red;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="reset-container">
    <h2>Reset Your Password</h2>

    <% String message = request.getParameter("msg");
        if (message != null) { %>
    <div class="error"><%= message %></div>
    <% } %>

    <form action="ResetPasswordServlet" method="post">
        <input type="hidden" name="username" value="<%= request.getParameter("username") %>">
        <input type="password" name="newPassword" placeholder="New Password" required>
        <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
        <input type="submit" value="Reset Password">
    </form>
</div>
</body>
</html>

