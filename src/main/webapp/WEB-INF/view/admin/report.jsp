<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 5/4/2025
  Time: 8:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - Report</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background: linear-gradient(to right, #f0f0f0, #f9f9f9);
        }

        .sidebar {
            width: 250px;
            background: white;
            display: flex;
            flex-direction: column;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            position: fixed;
            height: 100%;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 40px;
        }

        .logo-text {
            font-size: 22px;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: black;
            font-size: 16px;
            font-weight: 500;
            padding: 8px 12px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .sidebar nav a:hover {
            font-weight: bold;
            color: #333;
        }

        .signout {
            margin-top: auto;
            background: #f44336;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .main-content {
            margin-left: 250px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .top-navbar {
            background: white;
            padding: 15px 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .top-navbar .search-bar {
            display: flex;
            align-items: center;
            background: #f0f0f0;
            border-radius: 30px;
            overflow: hidden;
        }

        .top-navbar .search-bar input {
            border: none;
            padding: 8px 15px;
            background: none;
            outline: none;
        }

        .top-navbar .icons {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .top-navbar .bell {
            font-size: 20px;
            cursor: pointer;
        }

        .page-content {
            padding: 30px;
            overflow-y: auto;
        }

        .title {
            font-size: 36px;
            margin-bottom: 20px;
        }

        .title span {
            color: green;
        }

        .search-report {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 40px;
            gap: 20px;
        }

        .search-box {
            display: flex;
            border: 1px solid gray;
            border-radius: 30px;
            overflow: hidden;
            width: 300px;
        }

        .search-box input {
            border: none;
            padding: 10px;
            flex: 1;
            outline: none;
        }

        .search-box button {
            border: none;
            background: transparent;
            padding: 10px;
            cursor: pointer;
        }

        .report-btn {
            background: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }

        .items {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }

        .card {
            background: rgb(236, 230, 230);
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
            width: 280px;
            height: 200px;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .card-header {
            background: #f0f0f0;
            padding: 10px;
            font-size: 14px;
            text-align: left;
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .card-body {
            padding: 15px;
            text-align: left;
        }

        .card-body h3 {
            margin-bottom: 5px;
        }

        .card-body .description {
            font-size: 13px;
            margin: 10px 0;
        }

        .contact-btn {
            background: purple;
            color: white;
            border: none;
            padding: 7px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar">
    <div class="logo">
        <span style="font-size: 30px;">📋</span>
        <div class="logo-text">Report</div>
    </div>
    <nav class="nav-links">
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="Lost.jsp">Items</a>
        <a href="Found.jsp">Report</a>
        <a href="Settings.jsp">Settings</a>
    </nav>
    <button class="signout">Sign Out</button>
</aside>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Navbar -->
    <header class="top-navbar">
        <div class="search-bar">
            <input type="text" placeholder="Search reports...">
        </div>
        <div class="icons">
            <span class="bell">🔔</span>
        </div>
    </header>

    <!-- Page Content -->
    <div class="page-content">
        <h2 class="title">Report <span>Dashboard</span></h2>

        <div class="search-report">
            <div class="search-box">
                <input type="text" placeholder="Report name">
                <button>🔍</button>
            </div>
            <button class="report-btn">Generate Report</button>
        </div>

        <section class="items">
            <div class="card">
                <div class="card-header">
                    <p>Report</p>
                    <p>April</p>
                </div>
                <div class="card-body">
                    <h3>Lost & Found Stats</h3>
                    <p>12 items recovered</p>
                    <p class="description">Summary report generated on 4th May</p>
                    <button class="contact-btn">Download</button>
                </div>
            </div>
        </section>
    </div>
</div>

</body>
</html>

