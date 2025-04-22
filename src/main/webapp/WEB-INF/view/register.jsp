<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 4/21/2025
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f9fafb;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .container {
            width: 100%;
            max-width: 28rem;
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
        }

        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
            padding: 0.75rem;
            border-radius: 0.375rem;
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .input-group {
            position: relative;
            margin-bottom: 1rem;
        }

        .input-field {
            width: 100%;
            padding: 0.5rem 2.5rem 0.5rem 2.5rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
        }

        .icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }

        .password-toggle {
            position: absolute;
            right: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            background: none;
            border: none;
        }

        .radio-group {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .radio-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .submit-btn {
            width: 100%;
            background-color: #2563eb;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            border: none;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #1d4ed8;
        }

        .strength-bar {
            height: 0.25rem;
            border-radius: 0.125rem;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
        }

        .strength-0 { width: 20%; background-color: #ef4444; }
        .strength-1 { width: 40%; background-color: #ef4444; }
        .strength-2 { width: 60%; background-color: #f59e0b; }
        .strength-3 { width: 80%; background-color: #eab308; }
        .strength-4 { width: 100%; background-color: #22c55e; }

        .link {
            color: #2563eb;
            text-decoration: none;
        }

        .link:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const confirmField = document.getElementById('confirmPassword');
            const eyeIcon = document.getElementById('eye-icon');

            [passwordField, confirmField].forEach(field => {
                field.type = field.type === 'password' ? 'text' : 'password';
            });

            eyeIcon.classList.toggle('fa-eye-slash');
        }

        function calculatePasswordStrength(password) {
            if (!password) return 0;
            let strength = 0;
            if (password.length >= 8) strength += 1;
            if (/[A-Z]/.test(password)) strength += 1;
            if (/[a-z]/.test(password)) strength += 1;
            if (/[0-9]/.test(password)) strength += 1;
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            return strength;
        }
        function toggleAdminCode(show) {
            document.getElementById('admin-code-group').style.display = show ? 'block' : 'none';
        }
        document.getElementById("Role").addEventListener("change", function() {
            const adminCodeGroup = document.getElementById("admin-code-group");
            if (this.value === "admin") {
                adminCodeGroup.style.display = "block";
            } else {
                adminCodeGroup.style.display = "none";
            }
        });
        function updatePasswordStrength() {
            const password = document.getElementById('password').value;
            const strength = calculatePasswordStrength(password);
            const strengthBar = document.getElementById('strength-bar');
            const strengthText = document.getElementById('strength-text');

            const texts = ['Very Weak', 'Weak', 'Fair', 'Good', 'Strong'];

            strengthBar.className = 'strength-bar';
            strengthBar.classList.add(`strength-${strength}`);
            strengthText.textContent = texts[strength] || 'Very Strong';
        }
    </script>
</head>
<body>
<div class="container">
    <div style="margin-bottom: 1.5rem;">
        <h1 style="font-size: 1.5rem; font-weight: 700; margin-bottom: 0.25rem;">Create an account</h1>
        <p style="color: #4b5563;">Enter your information to create an account</p>
    </div>

    <%-- Error Messages --%>
    <% if (request.getAttribute("error") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" enctype="multipart/form-data"
          onsubmit="document.getElementById('submit-btn').disabled=true;document.getElementById('submit-btn').innerText='Creating account...'">
        <div style="display: grid; gap: 1rem;">
            <%-- Full Name --%>
            <div class="input-group">
                <label class="form-label">Full Name</label>
                <div style="position: relative;">
                    <i class="fas fa-user icon"></i>
                    <input type="text" name="full_name" required
                           class="input-field"
                           placeholder="Your name">
                </div>
            </div>

            <%-- Username --%>
            <div class="input-group">
                <label class="form-label">Username</label>
                <div style="position: relative;">
                    <i class="fas fa-user icon"></i>
                    <input type="text" name="username" required
                           class="input-field">
                </div>
            </div>

            <%-- Email --%>
            <div class="input-group">
                <label class="form-label">Email</label>
                <div style="position: relative;">
                    <i class="fas fa-envelope icon"></i>
                    <input type="email" name="email" required
                           class="input-field"
                           placeholder="name@example.com">
                </div>
            </div>

            <%-- Password --%>
            <div class="input-group">
                <label class="form-label">Password</label>
                <div style="position: relative;">
                    <i class="fas fa-lock icon"></i>
                    <input type="password" id="password" name="password" required
                           class="input-field"
                           onkeyup="updatePasswordStrength()">
                    <button type="button" onclick="togglePassword()"
                            class="password-toggle">
                        <i id="eye-icon" class="fas fa-eye"></i>
                    </button>
                </div>
                <div id="strength-bar" class="strength-bar"></div>
                <div id="strength-text" style="font-size: 0.875rem; margin-top: 0.25rem;"></div>
            </div>

            <%-- Confirm Password --%>
            <div class="input-group">
                <label class="form-label">Confirm Password</label>
                <div style="position: relative;">
                    <i class="fas fa-lock icon"></i>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           class="input-field">
                </div>
            </div>

            <%-- Role Selection --%>
            <div class="input-group">
                <label class="form-label">Role</label>
                <div class="radio-group">
                    <label class="radio-label">
                        <input type="radio" name="Role" value="user" checked onchange="toggleAdminCode(false)">
                        <span>User</span>
                    </label>
                    <label class="radio-label">
                        <input type="radio" name="Role" value="admin" onchange="toggleAdminCode(true)">
                        <span>Admin</span>
                    </label>
                </div>
            </div>

            <%-- Admin Approval Code --%>
            <div id="admin-code-group" style="display: none;">
                <label class="form-label">Admin Approval Code</label>
                <input type="text" name="approvalCode"
                       class="input-field"
                       placeholder="Enter approval code">
            </div>

            <%-- Additional Fields --%>
            <div class="input-group">
                <label class="form-label">Date of Birth</label>
                <input type="date" name="dateofbirth" class="input-field">
            </div>

            <div class="input-group">
                <label class="form-label">Gender</label>
                <select name="gender" class="input-field">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>
            </div>

            <div class="input-group">
                <label class="form-label">Profile Picture</label>
                <input type="file" name="profilePicture" class="input-field">
            </div>

            <%-- Submit Button --%>
            <button type="submit" id="submit-btn" class="submit-btn">
                Create Account
            </button>
        </div>
    </form>

    <div style="margin-top: 1rem; text-align: center; font-size: 0.875rem;">
        Already have an account?
        <a href="${pageContext.request.contextPath}/LoginServlet" class="link">Login</a>
    </div>
</div>
</body>
</html>