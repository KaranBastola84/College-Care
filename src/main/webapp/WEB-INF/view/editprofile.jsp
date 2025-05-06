<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 4:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.collegecaresystem.dto.UserDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css">
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Lost and Found</h2>
        <ul>
            <li class="active">Personal Details</li>
            <!-- <li><a href="${pageContext.request.contextPath}/reportItems.jsp">Reported Items</a></li>  -->
        </ul>
        <div class="sign-out">
            <form action="${pageContext.request.contextPath}/LogoutServlet" method="post">
                <button class="sign-out-btn" type="submit">Sign Out</button>
            </form>
        </div>
    </div>

    <!-- Main content -->
    <div class="main">
        <div class="profile-header">
            <img src="${UserDTO.profilePicture}" alt="Profile Picture" style="width: 100px; height: 100px; object-fit: cover;">
            <div class="info">
                <strong>${UserDTO.fullName}</strong><br>
                ${UserDTO.role}<br>
                ${UserDTO.address}
            </div>
        </div>

        <!-- Success or Error Messages -->
        <c:if test="${not empty success}">
            <p style="color: green;">${success}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color: red;">${error}</p>
        </c:if>

        <!-- Personal Info -->
        <div class="section">
            <h3>Personal Information</h3>
            <button class="edit-btn" onclick="showForm()">Edit</button>
            <div class="row">
                <div><span class="label">Full Name:</span><span class="value">${UserDTO.fullName}</span></div>
                <div><span class="label">Username:</span><span class="value">${UserDTO.username}</span></div>
                <div><span class="label">Date of Birth:</span><span class="value">${UserDTO.dateOfBirth}</span></div>
            </div>
            <div class="row">
                <div><span class="label">Email:</span><span class="value">${UserDTO.email}</span></div>
                <div><span class="label">Phone:</span><span class="value">${UserDTO.phone}</span></div>
                <div><span class="label">Gender:</span><span class="value">${UserDTO.gender}</span></div>
                <div><span class="label">Address:</span><span class="value">${UserDTO.address}</span></div>
            </div>
        </div>
    </div>
</div>

<!-- Edit Form Modal -->
<div class="edit-modal" id="editForm">
    <div class="edit-form-box">
        <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post" enctype="multipart/form-data">
            <h2>Edit Personal Information</h2>
            <label>Full Name: <input type="text" name="full_name" value="${UserDTO.fullName}"></label>
            <label>Username: <input type="text" name="username" value="${UserDTO.username}"></label>
            <label>Email: <input type="email" name="email" value="${UserDTO.email}"></label>
            <label>Phone: <input type="text" name="phone" value="${UserDTO.phone}"></label>
            <label>Gender:
                <select name="gender">
                    <option value="male" ${UserDTO.gender == 'male' ? 'selected' : ''}>Male</option>
                    <option value="female" ${UserDTO.gender == 'female' ? 'selected' : ''}>Female</option>
                    <option value="other" ${UserDTO.gender == 'other' ? 'selected' : ''}>Other</option>
                </select>
            </label>
            <label>Date of Birth: <input type="date" name="dateofbirth" value="${UserDTO.dateOfBirth}"></label>
            <label>Address: <textarea name="address">${UserDTO.address}</textarea></label>
            <label>Profile Picture: <input type="file" name="profilePicture"></label>
            <div class="form-buttons">
                <button type="submit" class="save-btn">Save</button>
                <button type="button" class="cancel-btn" onclick="hideForm()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function showForm() {
        document.getElementById('editForm').style.display = 'flex';
    }

    function hideForm() {
        document.getElementById('editForm').style.display = 'none';
    }

    window.addEventListener('click', function (e) {
        const modal = document.getElementById('editForm');
        const formBox = document.querySelector('.edit-form-box');
        if (e.target === modal) {
            hideForm();
        }
    });
</script>
</body>
</html>

