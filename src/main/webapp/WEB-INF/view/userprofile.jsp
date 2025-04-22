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
    <title>User Profile</title>
</head>
<body>
<h1>Welcome, ${userDTO.fullName}</h1>
<% if (request.getAttribute("success") != null) { %>
<p style="color: green;"><%= request.getAttribute("success") %></p>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<p style="color: red;"><%= request.getAttribute("error") %></p>
<% } %>

<p>Email: ${userDTO.email}</p>
<p>Role: ${userDTO.role}</p>

<a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a><br>
<a href="${pageContext.request.contextPath}/DeleteAccountServlet">Delete Account</a>
</body>
</html>
