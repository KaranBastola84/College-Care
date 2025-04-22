<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 4:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Account</title>
</head>
<body>
<h1>Delete Account</h1>
<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/DeleteAccountServlet" method="post">
    Password: <input type="password" name="password" required><br>
    Reason (optional): <textarea name="reason"></textarea><br>
    <input type="submit" value="Delete Account">
</form>
<a href="${pageContext.request.contextPath}/UserProfileServlet">Cancel</a>
</body>
</html>
