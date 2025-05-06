<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 5/5/2025
  Time: 11:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recent Posts</title>
    <style>
        body {
            background-color: #f9fafb;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .page-title {
            color: #1f2937;
            font-size: 1.875rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
        }

        .posts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            padding: 0 1rem;
        }

        .post-card {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 1.5rem;
            transition: transform 0.2s ease;
        }

        .post-card:hover {
            transform: translateY(-2px);
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .post-type {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .post-type.lost {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .post-type.found {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .post-date {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .item-name {
            color: #1f2937;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .post-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            font-size: 0.875rem;
        }

        .detail-label {
            color: #6b7280;
            font-weight: 500;
        }

        .detail-value {
            color: #374151;
        }

        .status {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.875rem;
        }

        .status-unclaimed {
            background-color: #fef3c7;
            color: #d97706;
        }

        .status-claimed {
            background-color: #dbeafe;
            color: #2563eb;
        }

        .status-returned {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .description-box {
            background-color: #f3f4f6;
            padding: 1rem;
            border-radius: 0.375rem;
            margin-top: 1rem;
        }

        .description-text {
            color: #4b5563;
            font-size: 0.875rem;
            line-height: 1.5;
        }

        @media (max-width: 768px) {
            .posts-grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="page-title">Recent Lost & Found Posts</h1>

    <div class="posts-grid">
        <c:forEach items="${recentPosts}" var="post">
            <div class="post-card">
                <div class="post-header">
                    <div>
                            <span class="post-type ${post.reqType == 'lost' ? 'lost' : 'found'}">
                                    ${post.reqType}
                            </span>
                        <span class="post-date">
                                <fmt:formatDate value="${post.dateReported}" pattern="MMM dd, yyyy"/>
                            </span>
                    </div>
                    <span class="post-date">
                            Posted by ${post.username}
                        </span>
                </div>

                <h3 class="item-name">${post.itemName}</h3>

                <div class="post-details">
                    <div class="detail-item">
                        <span class="detail-label">Category:</span>
                        <span class="detail-value">${post.itemType}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Location:</span>
                        <span class="detail-value">${post.location}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Date:</span>
                        <span class="detail-value">
                                <fmt:formatDate value="${post.dateLost}" pattern="MMM dd, yyyy"/>
                            </span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Status:</span>
                        <span class="status status-${post.status}">
                                ${post.status}
                        </span>
                    </div>
                </div>

                <c:if test="${not empty post.description}">
                    <div class="description-box">
                        <p class="description-text">${post.description}</p>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
