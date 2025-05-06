<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<c:if test="${not empty success}">
    <div class="bg-green-100 p-3 mb-4 rounded-lg">
            ${success}
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="bg-red-100 p-3 mb-4 rounded-lg">
            ${error}
    </div>
</c:if>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>College Lost & Found</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
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

<body class="bg-gradient-to-br from-green-100 to-white text-gray-800">

<main class="container mx-auto px-4 py-10">
    <div class="text-center mb-8">
        <h2 class="text-3xl font-bold text-green-700 typewriter">Have you lost something on campus?</h2>
        <p class="text-gray-600 mt-2">Submit details so we can help you get it back.</p>
    </div>

    <div class="bg-white glass rounded-2xl shadow-lg p-8">
        <form action="SubmitLostItemServlet" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-6" >
            <div>
                <label class="block text-sm font-semibold mb-1">What was Lost *</label>
                <input name="item_name" type="text" placeholder="e.g. Laptop, Bag, Wallet" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Category *</label>
                <input name="item_type" type="text" placeholder="e.g. Electronics, Books, Clothing" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div>
                <label class="block text-sm font-semibold mb-1">Date Lost *</label>
                <input name="date_reported" type="date" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>


            <div>
                <label class="block text-sm font-semibold mb-1">Upload Image</label>
                <input name="image" type="file" class="w-full border border-gray-300 rounded-lg p-2" />
            </div>

            <div class="md:col-span-2">
                <label class="block text-sm font-semibold mb-1">Location Lost *</label>
                <input name="location" id="locationInput" type="text" placeholder="e.g. Library, Cafeteria, Hallway" class="w-full border border-gray-300 rounded-lg p-2" required />
            </div>

            <div class="md:col-span-2">
                <label class="block text-sm font-semibold mb-1">Additional Information</label>
                <textarea name="description" rows="4" placeholder="Provide any specific details to help identify the item..." class="w-full border border-gray-300 rounded-lg p-2"></textarea>
            </div>

            <div class="md:col-span-2 text-right">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition">Submit Lost Item</button>
            </div>
        </form>
    </div>
</main>

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
