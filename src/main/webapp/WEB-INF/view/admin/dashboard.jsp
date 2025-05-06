<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 5:27 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lost & Found Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --warning-color: #f44336;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f4f4f4;
        }

        .sidebar {
            width: 220px;
            background-color: #fff;

            position: fixed;
            height: 100%;

            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;

        }
        .sidebar nav a[aria-current="page"] {
            font-weight: bold;
            background-color: #f8f9fa;
        }
        .sidebar-content {
            padding-top: 30px;
        }

        .sidebar h2 {
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .sidebar nav a {
            padding: 12px 30px;
            display: block;
            color: black;
            text-decoration: none;
            font-size: 15px;
            margin-bottom: 15px;
        }

        .sidebar nav a:hover {
            font-weight: bold;
            color: #333;
        }

        .signout1 {
            background: #f44336;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 20px auto;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            width: 180px;
            display: block;
        }

        .main {
            margin-left: 240px;
            padding: 20px;
        }

        .dashboard-header {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .card {
            flex: 1;
            min-width: 150px;
            padding: 15px;
            background-color: #fff;
            border-left: 5px solid;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .card.orange {
            border-color: orange;
        }

        .card.teal {
            border-color: teal;
        }

        .card h3 {
            margin: 0;
            font-size: 24px;
        }

        .card p {
            margin: 5px 0 0;
            color: gray;
        }

        .search-box input {
            padding: 8px;
            width: 100%;
            margin: 15px 0;
            box-sizing: border-box;
        }

        .charts, .recent {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .chart, .recent-box {
            background: #ffffff;
            padding: 15px;
            flex: 1;
            min-width: 300px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .chart {
            background: #f2ecec;
        }

        .recent-box ul {
            list-style: none;
            padding: 0;
        }

        .recent-box li {
            padding: 5px 0;
            border-bottom: 1px solid #e0d6d6;
        }

        h2 {
            font-size: 18px;
        }

        canvas {
            width: 100% !important;
            height: 250px !important;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-content">
        <h2 href="/">Lost and Found</h2>
        <nav aria-label="Main navigation">
            <a href="${pageContext.request.contextPath}/Dashboard.jsp" aria-current="page">Dashboard</a>
            <a href="/WEB-INF/view/admin/items.jsp">Items</a>
            <a href="/WEB-INF/view/admin/report.jsp">Report</a>
            <a href="/WEB-INF/view/admin/setting.jsp">Settings</a>x
        </nav>
    </div>
    <form action="${pageContext.request.contextPath}/LogoutServlet" method="post">
        <button type="submit" class="signout1" aria-label="Sign out">Sign Out</button>
    </form>
</div>

<div class="main">
    <h1>Dashboard</h1>
    <div class="dashboard-header">
        <div class="card orange">
            <h3>61</h3>
            <p>Reported lost</p>
        </div>
        <div class="card teal">
            <h3>71</h3>
            <p>Items found</p>
        </div>
    </div>

    <section aria-label="Search section">
        <form class="search-box" role="search">
            <input type="search" placeholder="Search items..." aria-label="Search items by name" />
        </form>
    </section>

    <div class="charts">
        <div class="chart">
            <h2>Lost Items (last month)</h2>
            <canvas id="lostChart"></canvas>
        </div>
        <div class="chart">
            <h2>Found Items (last month)</h2>
            <canvas id="foundChart"></canvas>
        </div>
    </div>

    <div class="recent">
        <div class="recent-box">
            <h2>Recently Lost Items</h2>
            <ul id="lost-list">
                <li><strong></strong></li>
                <li><strong></strong></li>
                <li><strong></strong></li>
            </ul>
        </div>
        <div class="recent-box">
            <h2>Recently Found Items</h2>
            <ul id="found-list">
                <li><strong></strong></li>
                <li><strong></strong></li>
                <li><strong></strong></li>
            </ul>
        </div>
    </div>
</div>

<script>
    // Dynamic content population example
    document.addEventListener('DOMContentLoaded', () => {
        // Populate recent items
        const recentItems = {
            lost: ['Backpack (Oct 10)', 'Phone (Oct 9)', 'Keys (Oct 8)'],
            found: ['Wallet (Oct 10)', 'Glasses (Oct 9)', 'Watch (Oct 8)']
        };

        populateList('lost-list', recentItems.lost);
        populateList('found-list', recentItems.found);

        function populateList(listId, items) {
            const list = document.getElementById(listId);
            list.innerHTML = items.map(item => `<li><strong>${item}</strong></li>`).join('');
        }
    });
</script>

</body>
</html>
