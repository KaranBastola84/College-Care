<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lost & Found System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script>
        function toggleMobileMenu() {
            const menu = document.getElementById('mobile-menu');
            menu.classList.toggle('hidden');
        }
    </script>
</head>
<body>
<header>
    <%-- Top Header --%>
    <div class="top-header">
        <div class="header-container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">Lost & Found</a>
            </div>

            <div class="desktop-nav">
                <a href="${pageContext.request.contextPath}/LoginServlet">Login</a>
                <span class="separator">|</span>
                <a href="${pageContext.request.contextPath}/RegisterServlet">Register</a>
            </div>
        </div>
    </div>

    <%-- Main Navigation --%>
    <nav class="main-nav">
        <div class="nav-container">
            <ul class="nav-list">
                <li><a href="/">Submit Lost Item</a></li>
                <li><a href="/">Submit Found Item</a></li>
                <li><a href="${pageContext.request.contextPath}/">View Recent Posts</a></li>
            </ul>
        </div>
    </nav>
</header>

<section class="how-it-works">
    <div class="section-container">
        <div class="section-header">
            <h2>How It Works</h2>
            <p>Our lost and found system makes it easy to report and find lost items</p>
        </div>

        <div class="steps-container">
            <%-- Step 1 --%>
            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-upload text-green-600"></i>
                </div>
                <h3>Step 1: Submit Report</h3>
                <p>Fill out the form with details about your lost item or an item you found</p>
            </div>

            <%-- Step 2 --%>
            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-search text-green-600"></i>
                </div>
                <h3>Step 2: Browse Listings</h3>
                <p>Look through our database of lost and found items</p>
            </div>

            <%-- Step 3 --%>
            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-bell text-green-600"></i>
                </div>
                <h3>Step 3: Get Notified</h3>
                <p>Receive notifications when there's a potential match for your item</p>
            </div>

            <%-- Step 4 --%>
            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-check-circle text-green-600"></i>
                </div>
                <h3>Step 4: Claim Your Item</h3>
                <p>Verify ownership and arrange to retrieve your lost belongings</p>
            </div>
        </div>
    </div>
</section>

<%-- Footer --%>
<footer class="main-footer">
    <div class="footer-container">
        <div class="footer-columns">
            <div class="footer-about">
                <h3>Lost & Found</h3>
                <p>Helping people reconnect with their lost belongings since 2024.</p>
            </div>

            <%-- Contact Section --%>
            <div class="footer-contact">
                <h3>Contact Us</h3>
                <div class="contact-info">
                    <div class="contact-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>123 College Street, Campus City</span>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-phone"></i>
                        <span>(123) 456-7890</span>
                    </div>
                    <div class="contact-item">
                        <i class="fas fa-envelope"></i>
                        <span>help@lostfound.edu</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-copyright">
            &copy; <%= java.time.Year.now().getValue() %> Lost & Found System. All rights reserved.
        </div>
    </div>
</footer>
</body>
</html>