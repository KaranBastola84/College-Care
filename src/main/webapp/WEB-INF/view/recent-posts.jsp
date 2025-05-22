<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Recent Posts - College Lost & Found</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
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

        .card-footer {
            padding: 1rem;
            border-top: 1px solid #eee;
        }

        .lost-item .card-header {
            border-left: 4px solid #ef4444;
        }

        .found-item .card-header {
            border-left: 4px solid #22c55e;
        }
        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }
    </style>
</head>
<body>

<header>
    <%-- Top Header --%>
    <div class="top-header">
        <div class="header-container" style="display: flex; justify-content: flex-end; align-items: center;">
            <div class="desktop-nav">
                <a href="${pageContext.request.contextPath}/LoginServlet">Login</a>
                <span class="separator">|</span>
                <a href="${pageContext.request.contextPath}/RegisterServlet" style="margin-right: 50px;">Register</a>
            </div>
        </div>
    </div>


    <%-- Main Navigation --%>
    <nav class="main-nav">
        <div class="nav-container">
            <ul class="nav-list">
                <li><a href="${pageContext.request.contextPath}/submit-lost">Submit Lost Item</a></li>
                <li><a href="${pageContext.request.contextPath}/SubmitFoundItemServlet">Submit Found Item</a></li>
                <li><a href="${pageContext.request.contextPath}/RecentPostsServlet">View Recent Posts</a></li>
            </ul>
        </div>
    </nav>
</header>

<div class="posts-container">
    <h1>Recent Posts</h1>

    <div style="display: none;">
        Total Posts: ${recentPosts.size()}
        <c:forEach items="${recentPosts}" var="post" varStatus="loop">
            Post ${loop.index + 1}:
            ID: ${post.reportId}
            Type: ${post.reqType}
            Item: ${post.itemName}
            Category: ${post.itemType}
        </c:forEach>
    </div>

    <div class="tabs-nav">
        <button class="tab-button active" onclick="showTab('lost', this)">Lost Items</button>
        <button class="tab-button" onclick="showTab('found', this)">Found Items</button>
    </div>

    <%-- Lost Items Tab --%>
    <div id="lost-tab" class="tab-content active">
        <div class="posts-grid">
            <c:forEach items="${recentPosts}" var="post">
                <c:if test="${post.reqType eq 'lost'}">
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
                                <fmt:formatDate value="${post.dateLost}" pattern="MM/dd/yyyy"/>
                            </div>

                            <div class="item-info">
                                <strong>Location Lost:</strong>
                                <c:out value="${post.location}"/>
                            </div>

                            <c:if test="${not empty post.description}">
                                <div class="item-info">
                                    <strong>Additional Information:</strong>
                                    <c:out value="${post.description}"/>
                                </div>
                            </c:if>

                            <c:if test="${not empty post.imageBase64}">
                                <img src="data:image/jpeg;base64,${post.imageBase64}"
                                     alt="<c:out value="${post.itemName}"/>"
                                     class="item-image">
                            </c:if>
                        </div>
                        <div class="card-footer">
                            <button class="action-button" onclick="viewDetails(${post.reportId})">
                                <i class="fas fa-info-circle"></i> Details
                            </button>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <%-- Found Items Tab --%>
    <div id="found-tab" class="tab-content" style="margin-top: 25px">
        <div class="posts-grid">
            <c:forEach items="${recentPosts}" var="post">
                <c:if test="${post.reqType eq 'found'}">
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
                                <strong>Location Found:</strong>
                                <c:out value="${post.location}"/>
                            </div>

                            <c:if test="${not empty post.description}">
                                <div class="item-info">
                                    <strong>Additional Information:</strong>
                                    <c:out value="${post.description}"/>
                                </div>
                            </c:if>

                            <c:if test="${not empty post.imageBase64}">
                                <img src="data:image/jpeg;base64,${post.imageBase64}"
                                     alt="<c:out value="${post.itemName}"/>"
                                     class="item-image">
                            </c:if>
                        </div>

                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>

<footer class="main-footer">
    <div class="footer-container">
        <div class="footer-columns">
            <div class="footer-section">
                <div class="footer-logo">
                    <a href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/assets/images/laflogo.png" alt="Lost & Found Logo" class="footer-logo-img">
                    </a>
                </div>
                <h4 class="footer-title">Lost & Found System</h4>
                <p class="footer-text">A digital platform connecting lost items with their owners</p>
                <div class="team-credits">
                    <div class="team-member">
                        <i class="fas fa-user icon-sm"></i>
                        <span>Karan Bastola<br>bnstkaran84@gmail.com</span>
                    </div>
                    <div class="team-member">
                        <i class="fas fa-user icon-sm"></i>
                        <span>Devit Rai<br>np05cp4a230048@iic.edu.np</span>
                    </div>
                    <div class="team-member">
                        <i class="fas fa-user icon-sm"></i>
                        <span>Rohit Shah<br>mike.johnson@lostfound.edu</span>
                    </div>
                    <div class="team-member">
                        <i class="fas fa-user icon-sm"></i>
                        <span>Diwakar Yadav<br>sarah.williams@lostfound.edu</span>
                    </div>
                </div>
            </div>

            <div class="footer-section">
                <h4 class="footer-title">Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/submit-lost" class="footer-link">
                        <i class="fas fa-search-minus icon-sm"></i> Report Lost Item
                    </a></li>
                    <li><a href="${pageContext.request.contextPath}/submit-found" class="footer-link">
                        <i class="fas fa-search-plus icon-sm"></i> Submit Found Item
                    </a></li>
                    <li><a href="${pageContext.request.contextPath}/LoginServlet" class="footer-link">
                        <i class="fas fa-sign-in-alt icon-sm"></i> User Login
                    </a></li>
                    <li><a href="${pageContext.request.contextPath}/RegisterServlet" class="footer-link">
                        <i class="fas fa-user-plus icon-sm"></i> Create Account
                    </a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h4 class="footer-title">Contact Support</h4>
                <div class="contact-info">
                    <div class="contact-item">
                        <i class="fas fa-envelope contact-icon"></i>
                        <div class="contact-details">
                            <span class="contact-label">Email Support</span>
                            <a href="mailto:help@lostfound.edu" class="contact-link">np05cp4a230154@iic.edu.np</a>
                        </div>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-phone contact-icon"></i>
                        <div class="contact-details">
                            <span class="contact-label">Phone Support</span>
                            <a href="tel:1234567890" class="contact-link">+9779826320515</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="footer-copyright">
                &copy; 2025 Lost & Found System. All rights reserved.
            </div>
            <div class="footer-credits">
                Developed with <i class="fas fa-heart icon-xs"></i> by Team C2
            </div>
        </div>
    </div>
</footer>

<script>
    function showTab(tabName, btn) {
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });
        document.querySelectorAll('.tab-button').forEach(button => {
            button.classList.remove('active');
        });

        document.getElementById(tabName + '-tab').classList.add('active');
        btn.classList.add('active');
    }

    function viewDetails(reportId) {
        window.location.href = `${pageContext.request.contextPath}/ReportDetailsServlet?id=${reportId}`;
    }

    function claimItem(reportId) {
        alert(`Claim item for report ID: ${reportId}`);
    }
</script>
</body>
</html>