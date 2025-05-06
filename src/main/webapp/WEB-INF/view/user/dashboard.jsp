<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
<style>
    .top-header-admin
    {
        background-color: #16a34a;
        height: 80px;
        display: flex;
        align-items: end;
        padding: 10px;
    }
    .editBtn {
        width: 55px;
        height: 55px;
        border-radius: 20px;
        border: none;
        background-color: rgb(104, 104, 106);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.123);
        cursor: pointer;
        position: relative;
        overflow: hidden;
        transition: all 0.3s;
    }
    .editBtn::before {
        content: "";
        width: 200%;
        height: 200%;
        background-color: rgb(102, 102, 141);
        position: absolute;
        z-index: 1;
        transform: scale(0);
        transition: all 0.3s;
        border-radius: 50%;
        filter: blur(10px);
    }
    .editBtn:hover::before {
        transform: scale(1);
    }
    .editBtn:hover {
        box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.336);
    }

    .editBtn svg {
        height: 17px;
        fill: white;
        z-index: 3;
        transition: all 0.2s;
        transform-origin: bottom;
    }
    .editBtn:hover svg {
        transform: rotate(-15deg) translateX(5px);
    }
    .editBtn::after {
        content: "";
        width: 25px;
        height: 1.5px;
        position: absolute;
        bottom: 19px;
        left: -5px;
        background-color: white;
        border-radius: 2px;
        z-index: 2;
        transform: scaleX(0);
        transform-origin: left;
        transition: transform 0.5s ease-out;
    }
    .editBtn:hover::after {
        transform: scaleX(1);
        left: 0px;
        transform-origin: right;
    }

</style>
<body>
<header>
    <%-- Top Header --%>
        <div class="top-header-admin">
            <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="editBtn">
                <svg height="1em" viewBox="0 0 512 512">
                    <path
                            d="M410.3 231l11.3-11.3-33.9-33.9-62.1-62.1L291.7 89.8l-11.3 11.3-22.6 22.6L58.6 322.9c-10.4 10.4-18 23.3-22.2 37.4L1 480.7c-2.5 8.4-.2 17.5 6.1 23.7s15.3 8.5 23.7 6.1l120.3-35.4c14.1-4.2 27-11.8 37.4-22.2L387.7 253.7
                410.3 231zM160 399.4l-9.1 22.7c-4 3.1-8.5 5.4-13.3 6.9L59.4 452l23-78.1c1.4-4.9 3.8-9.4 6.9-13.3l22.7-9.1v32c0 8.8 7.2 16 16 16h32zM362.7 18.7L348.3 33.2 325.7 55.8 314.3 67.1l33.9 33.9 62.1 62.1 33.9 33.9 11.3-11.3
                22.6-22.6 14.5-14.5c25-25 25-65.5 0-90.5L453.3 18.7c-25-25-65.5-25-90.5 0zm-47.4 168l-144 144c-6.2 6.2-16.4 6.2-22.6 0s-6.2-16.4 0-22.6l144-144c6.2-6.2 16.4-6.2 22.6 0s6.2 16.4 0 22.6z"
                    ></path>
                </svg>
            </a>
        </div>

    <%-- Main Navigation --%>
    <nav class="main-nav">
        <div class="nav-container">
            <ul class="nav-list">
                <li><a href="${pageContext.request.contextPath}/SubmitLostItemServlet">Submit Lost Item</a></li>
                <li><a href="${pageContext.request.contextPath}/SubmitFoundItemServlet">Submit Found Item</a></li>
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
    </div>
</div>

<section class="how-it-works">
    <div class="section-container">
        <div class="section-header">
            <h2>How It Works</h2>
            <p>Our lost and found system makes it easy to report and find lost items</p>
        </div>

        <div class="steps-container">
            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-upload text-green-600"></i>
                </div>
                <h3>Step 1: Submit Report</h3>
                <p>Fill out the form with details about your lost item or an item you found</p>
            </div>

            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-search text-green-600"></i>
                </div>
                <h3>Step 2: Browse Listings</h3>
                <p>Look through our database of lost and found items</p>
            </div>

            <div class="step-card">
                <div class="icon-circle">
                    <i class="fas fa-comment text-green-600"></i>
                </div>
                <h3>Step 3: Comment out!</h3>
                <p>Leave a comment on the post for further inquiry.</p>
            </div>

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

<section class="lost-reports">
    <div class="section-container">
        <div class="section-header">
            <h2>Recent Lost Item Reports</h2>
            <p>Below is the space where all reported lost items will appear.</p>
        </div>
        <div class="reports-placeholder">
            <p>No reports found</p>
        </div>
    </div>
</section>

<section class="contact-admin">
    <div class="section-container">
        <div class="section-header">
            <h2>Contact Admin</h2>
            <p>If you have any inquiries or need help, feel free to reach out</p>
        </div>

        <form class="contact-form">
            <label for="username">Your Name <span class="required">*</span></label>
            <input type="text" id="username" name="username" required placeholder="Enter your full name" />

            <label for="email">Your Email <span class="required">*</span></label>
            <input type="email" id="email" name="email" required placeholder="Enter your email address" />

            <label for="message">Message <span class="required">*</span></label>
            <textarea id="message" name="message" rows="5" required placeholder="Write your message here..."></textarea>

            <button type="submit">Send Message</button>
        </form>
    </div>
</section>

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
</body>
</html>