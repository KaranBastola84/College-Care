<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 5:27 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lost & Found Dashboard</title>
    <link href="/assets/css/styles.css" rel="stylesheet">
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
        body.admin-page {
            font-family: 'Inter', sans-serif;
            background: #f7fafc;
            color: #2d3748;
            padding: 2rem;
        }
        h1.page-title {
            font-size: 1.75rem;
            margin-bottom: 1rem;
            color: #2d3748;
        }

        /* Table base */
        table.admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: #fff;
            border-radius: 0.5rem;
            overflow: hidden;
        }

        /* Table header */
        .admin-table thead th {
            background: #38a169;
            color: #fff;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: .05em;
            padding: 0.75rem 1rem;
            text-align: left;
        }

        /* Table rows */
        .admin-table tbody tr {
            border-bottom: 1px solid #edf2f7;
        }
        .admin-table tbody tr:nth-child(even) {
            background: #f0fff4;
        }
        .admin-table tbody tr:hover {
            background: #e6fffa;
        }

        /* Table cells */
        .admin-table td {
            padding: 0.75rem 1rem;
            font-size: 0.875rem;
            color: #4a5568;
        }

        /* Action links/buttons */
        a.btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
            border-radius: 0.25rem;
            text-decoration: none;
            display: inline-block;
            margin-right: 0.25rem;
        }
        a.btn-create {
            background: #38a169;
            color: #fff;
        }
        a.btn-create:hover {
            background: #2f855a;
        }
        a.btn-edit {
            background: #3182ce;
            color: #fff;
        }
        a.btn-edit:hover {
            background: #2b6cb0;
        }
        a.btn-delete {
            background: #e53e3e;
            color: #fff;
        }
        a.btn-delete:hover {
            background: #c53030;
        }

        /* Status badges */
        .status {
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            display: inline-block;
        }

        .status.open { background: #bfdbfe; color: #1e40af; }
        .status.resolved { background: #bbf7d0; color: #166534; }
        .status.pending { background: #fef08a; color: #854d0e; }

        /* Type tags */
        .tag {
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            text-transform: uppercase;
        }

        .tag.lost { background: #fde68a; color: #92400e; }
        .tag.found { background: #a7f3d0; color: #065f46; }

        .posts-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .tabs-nav {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            border-bottom: 2px solid #eee;
        }

        .tab-button {
            padding: 0.75rem 1.5rem;
            border: none;
            background: none;
            cursor: pointer;
            font-weight: 600;
            color: #666;
            transition: all 0.3s ease;
        }

        .tab-button.active {
            color: #22c55e;
            border-bottom: 3px solid #22c55e;
        }

        .posts-grid {
            display: grid;
            gap: 2rem;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        }

        .post-card {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            padding: 1rem;
            border-bottom: 1px solid #eee;
        }

        .card-header h3 {
            margin: 0;
            font-size: 1.1rem;
            color: #333;
        }

        .card-content {
            padding: 1rem;
        }

        .item-info {
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .item-info strong {
            color: #666;
            display: block;
            margin-bottom: 0.25rem;
        }

        .item-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 0.25rem;
            margin-top: 1rem;
        }

        .lost-item .card-header {
            border-left: 4px solid #ef4444;
        }

        .found-item .card-header {
            border-left: 4px solid #22c55e;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <form action="${pageContext.request.contextPath}/LogoutServlet" method="post">
        <button type="submit" class="signout1" aria-label="Sign out">Sign Out</button>
    </form>
</div>

<div class="main">
    <h1>Dashboard</h1>
    <div class="dashboard-header">
        <div class="card orange">
            <h3>${lostCount}</h3>
            <p>Reported lost</p>
        </div>
        <div class="card teal">
            <h3>${foundCount}</h3>
            <p>Items found</p>
        </div>
    </div>

    <h1 class="page-title">Lost &amp; Found ▸ All Reports</h1>

    <table class="admin-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Type</th>
            <th>Item Name</th>
            <th>Category</th>
            <th>Location</th>
            <th>Date</th>
            <th>Status</th>
            <th>Submitted By</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${reports}" var="report">
            <tr>
                <td>${report.reportId}</td>
                <td>${report.getTypeBadge()}</td>
                <td>${report.itemName}</td>
                <td>${report.itemType}</td>
                <td>${report.location}</td>
                <td><fmt:formatDate value="${report.dateReported}" pattern="yyyy-MM-dd"/></td>
                <td>${report.getStatusBadge()}</td>
                <td>${report.username}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/reports/edit?id=${report.reportId}"
                       class="btn btn-edit">Edit</a>
                    <form action="${pageContext.request.contextPath}/admin/reports/delete"
                          method="post"
                          style="display: inline;">
                        <input type="hidden" name="id" value="${report.reportId}">
                        <button type="submit" class="btn btn-delete"
                                onclick="return confirm('Delete report #${report.reportId}?')">
                            Delete
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="recent">

        <div id="recent-lost" class="tab-content active">
            <div class="posts-grid">
                <c:forEach items="${recentLost}" var="post" end="4">
                    <div class="post-card lost-item">
                        <div class="card-header">
                            <h3><c:out value="${post.itemName}"/></h3>
                            <small class="text-muted">Reported by <c:out value="${post.username}"/></small>
                        </div>
                        <div class="card-content">
                            <div class="item-info">
                                <strong>Category:</strong>
                                <c:out value="${post.itemType}"/>
                            </div>
                            <div class="item-info">
                                <strong>Date Lost:</strong>
                                <c:choose>
                                    <c:when test="${not empty report.dateLost}">
                                        <fmt:formatDate value="${report.dateLost}" pattern="MM/dd/yyyy"/>
                                    </c:when>
                                    <c:otherwise>
                                        Not specified
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="item-info">
                                <strong>Location:</strong>
                                <c:out value="${post.location}"/>
                            </div>
                            <c:if test="${not empty post.imageBase64}">
                                <img src="data:image/jpeg;base64,${post.imageBase64}"
                                     alt="<c:out value="${post.itemName}"/>"
                                     class="item-image">
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div id="recent-found" class="tab-content">
            <div class="posts-grid">
                <c:forEach items="${recentFound}" var="post" end="4">
                    <div class="post-card found-item">
                        <div class="card-header">
                            <h3><c:out value="${post.itemName}"/></h3>
                            <small class="text-muted">Found by <c:out value="${post.username}"/></small>
                        </div>
                        <div class="card-content">
                            <div class="item-info">
                                <strong>Category:</strong>
                                <c:out value="${post.itemType}"/>
                            </div>
                            <div class="item-info">
                                <strong>Date Found:</strong>
                                <fmt:formatDate value="${post.dateReported}" pattern="MM/dd/yyyy"/>
                            </div>
                            <div class="item-info">
                                <strong>Location:</strong>
                                <c:out value="${post.location}"/>
                            </div>
                            <c:if test="${not empty post.imageBase64}">
                                <img src="data:image/jpeg;base64,${post.imageBase64}"
                                     alt="<c:out value="${post.itemName}"/>"
                                     class="item-image">
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    function showRecentTab(tabName, btn) {
        // Hide all tab content
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.style.display = 'none';
        });

        // Remove active class from all buttons
        document.querySelectorAll('.tab-button').forEach(button => {
            button.classList.remove('active');
        });

        // Show selected tab
        document.getElementById(tabName).style.display = 'block';
        btn.classList.add('active');
    }
</script>

</body>
</html>
