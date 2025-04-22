<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 4:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background: white;
            padding: 25px 35px;
            border-radius: 10px;
            width: 500px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Edit Your Profile</h2>
    <form action="EditProfileServlet" method="post">
        <input type="hidden" name="user_id" value="<%= user.getId() %>">

        <label>Full Name:</label>
        <input type="text" name="full_name" value="<%= user.getFullname() %>" required>

        <label>Email:</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required>

        <label>Phone:</label>
        <input type="tel" name="phone" value="<%= user.getPhone() %>" required>

        <label>Address:</label>
        <textarea name="address" required><%= user.getAddress() %></textarea>

        <label>Gender:</label>
        <select name="gender" required>
            <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
            <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
        </select>

        <input type="submit" value="Update Profile">
    </form>
</div>
</body>
</html>

