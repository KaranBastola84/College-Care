<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 5/4/2025
  Time: 8:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f3f4f6;
        }

        .container {
            display: flex;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background-color: #fff;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            z-index: 10;
        }

        .sidebar .logo {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding: 20px 30px;
            font-size: 22px;
            font-weight: bold;
            color: black;
        }

        .sidebar nav {
            display: flex;
            flex-direction: column;
            gap: 30px;
            padding-left: 30px;
            padding-bottom: 350px;
        }

        .sidebar nav a {
            text-decoration: none;
            color: black;
            font-size: 16px;
            transition: 0.2s ease-in-out;
        }

        .sidebar nav a:hover {
            font-weight: bold;
            color: #333;
        }

        .sidebar .sign-out {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 10px;
            margin: 20px auto;
            width: 90%;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
        }

        .main {
            margin-left: 250px;
            flex: 1;
            padding: 24px 36px;
        }

        .topbar {
            background-color: #8d8f8e;
            padding: 14px 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 10px;
        }

        .search-bar input {
            padding: 6px 14px;
            border-radius: 6px;
            border: none;
            width: 260px;
        }

        .profile-header {
            background: white;
            border-radius: 10px;
            padding: 20px 24px;
            margin-top: 24px;
            display: flex;
            align-items: center;
        }

        .profile-header img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            margin-right: 18px;
        }

        .profile-header .info {
            font-size: 15px;
        }

        .section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-top: 30px;
            position: relative;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .section h3 {
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: 600;
        }

        .row {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin-bottom: 16px;
        }

        .row > div {
            width: 32%;
            margin-bottom: 12px;
        }

        .label {
            font-weight: 600;
            color: #555;
            display: block;
            margin-bottom: 6px;
        }

        .value {
            color: #222;
            font-size: 15px;
        }

        .edit-btn {
            background-color: #ff6600;
            border: none;
            color: white;
            padding: 6px 14px;
            border-radius: 6px;
            cursor: pointer;
            position: absolute;
            top: 30px;
            right: 30px;
            font-size: 14px;
        }

        .edit-btn:hover {
            background-color: #ee5656;
            border-radius: 4px;
            padding: 10px;
            transition: all 0.2s ease;
        }

        .address-section {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .address-box {
            width: 32%;
            margin-bottom: 12px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <span style="font-size: 30px;">🎒</span>
            <div class="logo-text">I Found</div>
        </div>
        <nav>
            <a href="Dashboard.jsp">Dashboard</a>
            <a href="Lost.jsp">Items</a>
            <a href="Found.jsp">Report</a>
            <a href="settings.jsp">Settings</a>
        </nav>
        <button class="sign-out">Sign Out</button>
    </div>

    <!-- Main content -->
    <div class="main">
        <div class="topbar">
            <div class="search-bar">
                <input type="text" placeholder="Search...">
            </div>
        </div>

        <div class="profile-header">
            <img src="images/profile-pic.png" alt="Profile Picture">
            <div class="info">
                <strong>Karan Bastola</strong><br>
                Admin<br>
                Ithari, Nepal
            </div>
        </div>

        <div class="section">
            <h3>Personal Information</h3>
            <button class="edit-btn">Edit</button>
            <div class="row">
                <div>
                    <span class="label">First Name:</span>
                    <span class="value">Karan</span>
                </div>
                <div>
                    <span class="label">Last Name:</span>
                    <span class="value">Bastola</span>
                </div>
                <div>
                    <span class="label">Date of Birth:</span>
                    <span class="value">12-12-2003</span>
                </div>
            </div>
            <div class="row">
                <div>
                    <span class="label">Email:</span>
                    <span class="value">bstolakaran@gmail.com</span>
                </div>
                <div>
                    <span class="label">Phone Number:</span>
                    <span class="value">+9834576997</span>
                </div>
                <div>
                    <span class="label">User Role:</span>
                    <span class="value">Admin</span>
                </div>
            </div>
        </div>

        <div class="section">
            <h3>Address</h3>
            <div class="address-section">
                <div class="address-box">
                    <span class="label">Country:</span>
                    <span class="value">Nepal</span>
                </div>
                <div class="address-box">
                    <span class="label">City:</span>
                    <span class="value">Ithari</span>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="js/profile.js"></script>
</body>
</html>

