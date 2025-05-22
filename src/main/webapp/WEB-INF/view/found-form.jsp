
<%@ page language="java" session="true" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <title>College Lost & Found</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        @keyframes typing {
            from { width: 0 }
            to { width: 100% }
        }
        .typewriter {
            display: inline-block;
            overflow: hidden;
            white-space: nowrap;
            border-right: 2px solid;
            animation: typing 3s steps(30, end) forwards;
        }
        .glass {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.75);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        }
    </style>
</head>
<header>
    <%-- Top Header --%>
    <div class="top-header">
        <div class="header-container" style="display: flex; justify-content: flex-end; align-items: center;">
            <div class="desktop-nav" style="margin-top: 10px">
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
<body class="bg-gradient-to-br from-yellow-100 to-white text-gray-800">

<main class="container mx-auto px-4 py-10">
    <div class="text-center mb-8">
        <h2 class="text-3xl font-bold text-yellow-700 typewriter">Have you found something on campus?</h2>
        <p class="text-gray-600 mt-2">Submit the details to help it reach its rightful owner.</p>
    </div>

    <div class="bg-white glass rounded-2xl shadow-lg p-8">
        <form class="grid grid-cols-1 md:grid-cols-2 gap-6"
              enctype="multipart/form-data"
              method="post"
              action="${pageContext.request.contextPath}/SubmitFoundItemServlet">

        <div>
                <label class="block text-sm font-semibold mb-1">What was Found *</label>
                <input type="text" name="item" placeholder="e.g. Phone, Notebook, Keys" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Category *</label>
                <input type="text" name="category" placeholder="e.g. Electronics, Stationery" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Date Found *</label>
                <input type="date" name="dateFound" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Item Name </label>
                <input type="text" name="item-name" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Brand (if any)</label>
                <input type="text" name="brand" placeholder="e.g. Samsung, Nike" class="w-full border border-gray-300 rounded-lg p-2" />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Upload Image</label>
                <input type="file" name="image" class="w-full border border-gray-300 rounded-lg p-2" />
            </div>

            <div class="md:col-span-2">
                <label class="block text-sm font-semibold mb-1">Location Found *</label>
                <input type="text" name="location" placeholder="e.g. Auditorium, Lab" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div class="md:col-span-2">
                <label class="block text-sm font-semibold mb-1">Additional Information</label>
                <textarea name="additionalInfo" rows="4" placeholder="Any additional details..." class="w-full border border-gray-300 rounded-lg p-2"></textarea>
            </div>

            <div class="md:col-span-2 text-right">
                <button type="submit" class="bg-yellow-600 text-white px-6 py-2 rounded-lg hover:bg-yellow-700 transition">Submit Found Item</button>
            </div>
        </form>
    </div>
</main>


<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden" id="successModal">
    <div class="bg-white p-8 rounded-xl shadow-lg text-center">
        <h2 class="text-2xl font-bold text-yellow-600">✅ Item Submitted!</h2>
        <p class="mt-2 text-gray-600">Thanks for helping someone recover their lost item.</p>
        <button onclick="closeModal()" class="mt-4 px-4 py-2 bg-yellow-600 text-white rounded hover:bg-yellow-700">Close</button>
    </div>
</div>


</body>
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
</html>
