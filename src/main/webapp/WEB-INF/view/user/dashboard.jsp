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

        document.addEventListener('click', function(event) {
            const dropdowns = document.querySelectorAll('.profile-dropdown');
            dropdowns.forEach(dropdown => {
                if (!dropdown.contains(event.target)) {
                    dropdown.querySelector('.dropdown-content').style.display = 'none';
                }
            });
        });

        document.querySelectorAll('.profile-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                const dropdown = this.closest('.profile-dropdown');
                const content = dropdown.querySelector('.dropdown-content');
                content.style.display = content.style.display === 'block' ? 'none' : 'block';
            });
        });

    </script>
</head>
<style>
    .top-header-admin {
        background: #f8f9fa;
        padding: 0.5rem 2rem;
        display: flex;
        justify-content: flex-end;
        align-items: center;
    }

    .user-profile {
        position: relative;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .welcome-text {
        font-weight: 500;
        color: #2d3748;
    }

    .profile-btn {
        background: none;
        border: none;
        cursor: pointer;
        padding: 0;
    }

    .profile-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #e2e8f0;
        transition: border-color 0.2s;
    }

    .profile-icon:hover {
        border-color: #cbd5e0;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        top: 100%;
        background: white;
        min-width: 200px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        border-radius: 0.5rem;
        padding: 0.5rem 0;
        z-index: 100;
    }

    .profile-dropdown:hover .dropdown-content,
    .profile-dropdown:focus-within .dropdown-content {
        display: block;
    }

    .dropdown-link {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.75rem 1rem;
        color: #4a5568;
        text-decoration: none;
        transition: background 0.2s;
    }

    .dropdown-link:hover {
        background: #f7fafc;
    }

    .dropdown-link i {
        width: 20px;
        text-align: center;
    }

    .top-header-admin
    {
        background-color: #16a34a;
        height: 50px;
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
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="user-profile">
                <span class="welcome-text">
                    Welcome, <c:out value="${sessionScope.user.username}" />
                </span>
                        <div class="profile-dropdown">
                            <button class="profile-btn">
                                <img src="${pageContext.request.contextPath}/assets/images/laflogo.png" alt="Lost & Found Logo">
                            </button>
                            <div class="dropdown-content">
                                <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="dropdown-link">
                                    <i class="fas fa-user-edit"></i> Edit Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/LogoutServlet" class="dropdown-link">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>


    <%-- Main Navigation --%>
    <nav class="main-nav">
        <div class="nav-container">
            <ul class="nav-list">
                <li><a href="${pageContext.request.contextPath}/user/lost-form">Submit Lost Item</a></li>
                <li><a href="${pageContext.request.contextPath}/UserFoundItemRedirectServlet">Submit Found Item</a></li>
                <li><a href="${pageContext.request.contextPath}/">View Recent Posts</a></li>
            </ul>
        </div>
    </nav>
</header>

<div class="background-container">
    <div class="form-container">
        <h1>Lost and Found</h1>
        <!-- Submit Lost Item Form -->
        <form action="${pageContext.request.contextPath}/submit-lost" method="post">
            <label for="lost">What was Lost or Found <span class="required">*</span></label>
            <small>Please provide an approximate location of the lost property</small>
            <input type="text" id="lost" name="location" placeholder="Item Location" required />
            <button type="submit" class="lost" style="margin-top: 10px">Submit Lost Item</button>
        </form>
        <!-- Submit Found Item Form -->
        <form action="${pageContext.request.contextPath}/SubmitFoundItemServlet" method="post">
            <label for="found">What was Found or lost <span class="required">*</span></label>
            <small>Please provide an approximate location of the found property</small>
            <input type="text" id="found" name="location" placeholder="Item Location" required />
            <button type="submit" class="found" style="margin-top: 10px">Submit Found Item</button>
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

<section class="contact-admin">
    <div class="section-container">
        <div class="section-header">
            <h2>Contact Admin</h2>
            <p>If you have any inquiries or need help, feel free to reach out</p>
        </div>
        <form class="contact-form" action="${pageContext.request.contextPath}/contact" method="POST">
            <label for="username">Your Name <span class="required">*</span></label>
            <input type="text" id="username" name="username" required placeholder="Enter your full name">

            <label for="email">Your Email <span class="required">*</span></label>
            <input type="email" id="email" name="email" required placeholder="Enter your email address">

            <label for="subject">Subject <span class="required">*</span></label>
            <input type="text" id="subject" name="subject" required placeholder="Message subject">

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
                    <li><a href="${pageContext.request.contextPath}/SubmitFoundItemServlet" class="footer-link">
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