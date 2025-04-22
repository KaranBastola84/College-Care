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
            --main-bg: #f6f4fc;
            --sidebar-bg: #ffffff;
            --accent-color: #6c4bc1;
            --progress-bg: #f3f3f3;
            --card-bg: #fff;
            --card-shadow: 0 4px 20px rgba(0,0,0,0.05);
            --border-radius: 20px;
            --lost-color: #f2b01e;
            --found-color: #3da5f4;
            --lost-bg: #fff8e1;
            --found-bg: #e3f2fd;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: var(--main-bg);
            padding: 2rem;
        }

        .dashboard {
            display: grid;
            grid-template-columns: 250px 1fr 300px;
            gap: 2rem;
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
        }

        .sidebar {
            background: var(--sidebar-bg);
            border-radius: var(--border-radius);
            padding: 1rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sidebar h2 {
            font-size: 1.3rem;
            margin-bottom: 2rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.75rem;
            border-radius: 12px;
            margin-bottom: 1rem;
            text-decoration: none;
            color: black;
            background-color: #f2f0fb;
        }

        .nav-link.active {
            background-color: var(--accent-color);
            color: white;
        }

        .main-content {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .status-boxes {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .status-box {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            padding: 1rem;
            box-shadow: var(--card-shadow);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .status-box.lost { background-color: var(--lost-color); color: white; }
        .status-box.found { background-color: var(--found-color); color: white; }

        .quick-search {
            background: var(--card-bg);
            padding: 1rem;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }

        .quick-search input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 12px;
            margin-bottom: 1rem;
        }

        canvas {
            margin-top: 1rem;
            width: 100% !important;
            max-height: 250px;
        }

        .right-panel {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .card-list {
            padding: 1rem;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }

        .card-list h4 {
            margin-bottom: 0.5rem;
        }

        .card-list.lost-items {
            background: var(--lost-bg);
            border-left: 6px solid var(--lost-color);
        }

        .card-list.found-items {
            background: var(--found-bg);
            border-left: 6px solid var(--found-color);
        }

        .item {
            margin-bottom: 1rem;
        }

        .item:last-child {
            margin-bottom: 0;
        }
    </style>
</head>
<body>
<div class="dashboard">
    <aside class="sidebar">
        <div>
            <h2>Ideas here</h2>
            <a href="#" class="nav-link active">Dashboard</a>
            <a href="#" class="nav-link">Items</a>
            <a href="#" class="nav-link">Reports</a>
            <a href="#" class="nav-link">Settings</a>
        </div>
    </aside>

    <main class="main-content">
        <div class="status-boxes">
            <div class="status-box lost">
                <h3>61</h3>
                <p>Show Lost Items</p>
            </div>
            <div class="status-box found">
                <h3>19</h3>
                <p>Show Found Items</p>
            </div>
        </div>

        <div class="quick-search">
            <h4>Quick Search</h4>
            <input type="text" placeholder="Search Items">
            <canvas id="lostFoundChart"></canvas>
        </div>
    </main>

    <aside class="right-panel">
        <div class="card-list lost-items">
            <h4>Recently Lost Items</h4>
            <div class="item">
                <strong>Device</strong>: Laptop<br>
                <strong>Color</strong>: Black Yellow<br>
                <strong>Details</strong>: Laptop slightly scratched
            </div>
            <div class="item">
                <strong>Camera</strong>: Digital SLR<br>
                <strong>Model</strong>: Nikon V1<br>
                <strong>Serial</strong>: 123WWWG98NDK
            </div>
            <div class="item">
                <strong>Key</strong>: Bike Key<br>
                <strong>Color</strong>: Brown<br>
                <strong>Details</strong>: Holds lab equipment
            </div>
        </div>

        <div class="card-list found-items">
            <h4>Recently Found Items</h4>
            <div class="item">
                <strong>Bag</strong>: Leather<br>
                <strong>Color</strong>: Brown<br>
                <strong>Features</strong>: Books and Laptop<br>
                <strong>Details</strong>: Newly logged
            </div>
            <div class="item">
                <strong>Device</strong>: Laptop<br>
                <strong>Color</strong>: Black Yellow<br>
                <strong>Details</strong>: Laptop slightly scratched
            </div>
            <div class="item">
                <strong>Key</strong>: Car Key<br>
                <strong>Color</strong>: Brown<br>
                <strong>Details</strong>: Slightly scratched
            </div>
        </div>
    </aside>
</div>

<script>
    const ctx = document.getElementById('lostFoundChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [
                {
                    label: 'Lost Items',
                    data: [3, 4, 2, 5, 3, 6, 4],
                    backgroundColor: 'transparent',
                    borderColor: '#f2b01e',
                    tension: 0.4
                },
                {
                    label: 'Found Items',
                    data: [1, 2, 1, 3, 2, 4, 3],
                    backgroundColor: 'transparent',
                    borderColor: '#3da5f4',
                    tension: 0.4
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    position: 'bottom'
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>
