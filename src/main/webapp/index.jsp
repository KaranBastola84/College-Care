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
                <li><a href="/">Submit Lost Item</a></li>
                <li><a href="/">Submit Found Item</a></li>
                <li><a href="${pageContext.request.contextPath}/">View Recent Posts</a></li>
            </ul>
        </div>
    </nav>
</header>
<div class="background-container">
    <div class="form-container">
        <h1>Lost and Found</h1>
        <p class="subtitle">Locate lost or found items!</p>
        <p class="note"><strong>Lost & Found</strong> can help you find what you are looking for!</p>
        <form>
            <label for="item">What was Lost or Found <span class="required">*</span></label>
            <input type="text" id="item" placeholder="Item Lost or Found" required />

            <label for="location">Where Lost or Found <span class="required">*</span></label>
            <small>Please provide an approximate location of the lost property</small>
            <input type="text" id="location" placeholder="Item Location" required />
            <div class="buttons">
                <button type="submit" class="lost">Submit Lost Item</button>
                <button type="submit" class="found">Submit Found Item</button>
            </div>
        </form>
    </div></div>

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
                    <i class="fas fa-comment text-green-600"></i>
                </div>
                <h3>Step 3: Comment out!</h3>
                <p>Leave a comment on the post for further inquiry.</p>
            </div>

            <%-- Step 4 --%>
            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-check-circle text-green-600"></i>
                </div>
                <h3>Step 4: Claim Your Item</h3>
                <p>Verify and arrange to retrieve your lost belongings</p>
            </div>
        </div>
    </div>
</section>

<%-- Footer --%>
<footer class="main-footer">
    <div class="footer-container">
        <div class="footer-columns">
            <!-- System Information -->
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
                        <span>Jane Smith<br>jane.smith@lostfound.edu</span>
                    </div>
                    <div class="team-member">
                        <i class="fas fa-user icon-sm"></i>
                        <span>Mike Johnson<br>mike.johnson@lostfound.edu</span>
                    </div>
                    <div class="team-member">
                        <i class="fas fa-user icon-sm"></i>
                        <span>Sarah Williams<br>sarah.williams@lostfound.edu</span>
                    </div>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="footer-section">
                <h4 class="footer-title">Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="/submit-lost" class="footer-link">
                        <i class="fas fa-search-minus icon-sm"></i> Report Lost Item
                    </a></li>
                    <li><a href="/submit-found" class="footer-link">
                        <i class="fas fa-search-plus icon-sm"></i> Submit Found Item
                    </a></li>
                    <li><a href="/login" class="footer-link">
                        <i class="fas fa-sign-in-alt icon-sm"></i> User Login
                    </a></li>
                    <li><a href="/register" class="footer-link">
                        <i class="fas fa-user-plus icon-sm"></i> Create Account
                    </a></li>
                </ul>
            </div>

            <!-- Contact Information -->
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

        <!-- Copyright Notice -->
        <div class="footer-bottom">
            <div class="footer-copyright">
                &copy; <%= java.time.Year.now().getValue() %> Lost & Found System. All rights reserved.
            </div>
            <div class="footer-credits">
                Developed with <i class="fas fa-heart icon-xs"></i> by Team C2
            </div>
        </div>
    </div>
</footer>
</body>
</html>