<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f9fafb;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            margin: 0;
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
            border-radius: 0.375rem;
            padding: 0.75rem;
            margin-bottom: 1rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }

        .input-field {
            width: 100%;
            padding: 0.5rem 2.5rem 0.5rem 2.5rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            font-size: 0.875rem;
        }

        .password-toggle {
            position: absolute;
            right: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #9ca3af;
        }

        .submit-btn {
            width: 100%;
            background-color: #2563eb;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
            font-weight: 500;
        }

        .submit-btn:hover {
            background-color: #1d4ed8;
        }

        .link-text {
            color: #2563eb;
            text-decoration: none;
        }

        .link-text:hover {
            text-decoration: underline;
        }

        .role-group {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .radio-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
    </style>
    <script>
        function togglePassword() {
            const passwordField = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
    </script>
</head>
<body>
<div class="container">
    <div style="margin-bottom: 1.5rem;">
        <h1 style="font-size: 1.5rem; font-weight: 700; margin-bottom: 0.25rem;">Login</h1>
        <p style="color: #4b5563;">Enter your credentials to access your account</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error-message">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/LoginServlet" method="post" style="display: grid; gap: 1rem;">
        <div class="form-group">
            <label class="form-label">Username</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope input-icon"></i>
                <input type="text" name="username" required class="input-field" placeholder="Username">
            </div>
        </div>
        <div class="form-group">
            <label class="form-label">Email</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" name="email" required class="input-field" placeholder="johndoe@gmail.com">
            </div>
        </div>

        <div class="form-group">
            <div style="display: flex; justify-content: space-between; margin-bottom: 0.25rem;">
                <label class="form-label">Password</label>
                <a href="/forgot-password" class="link-text">Forgot password?</a>
            </div>
            <div class="input-wrapper">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" id="password" name="password" required class="input-field">
                <button type="button" onclick="togglePassword()" class="password-toggle">
                    <i id="eye-icon" class="fas fa-eye"></i>
                </button>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Role</label>
            <div class="role-group">
                <label class="radio-label">
                    <input type="radio" name="role" value="user" checked style="margin: 0;">
                    <span>User</span>
                </label>
                <label class="radio-label">
                    <input type="radio" name="role" value="admin" style="margin: 0;">
                    <span>Admin</span>
                </label>
            </div>
        </div>

        <button type="submit" class="submit-btn">Login</button>
    </form>
    <div style="margin-top: 1rem; text-align: center; font-size: 0.875rem;">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/RegisterServlet" class="link-text">Register</a>
    </div>
</div>
</body>
</html>