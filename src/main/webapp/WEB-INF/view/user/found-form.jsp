<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 5/20/2025
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
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
                <li><a href="${pageContext.request.contextPath}/user/lost-form">Submit Lost Item</a></li>
                <li><a href="${pageContext.request.contextPath}/UserFoundItemRedirectServlet">Submit Found Item</a></li>
                <li><a href="${pageContext.request.contextPath}/UserDashboardServlet">View Recent Posts</a></li>
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

