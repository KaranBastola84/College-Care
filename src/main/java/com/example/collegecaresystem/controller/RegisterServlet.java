package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.utils.PasswordHash;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;

import java.io.IOException;
import java.io.InputStream;


@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class RegisterServlet extends HttpServlet {
    private static final String ADMIN_APPROVAL_CODE = "1430";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullname = request.getParameter("full_name");
        String dobStr = request.getParameter("dateofbirth");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("Role");
        String approvalCode = request.getParameter("approvalCode");

        if ("admin".equalsIgnoreCase(role)) {
            if (approvalCode == null || approvalCode.trim().isEmpty()) {
                request.setAttribute("error", "Admin approval code is required");
                request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
                return;
            } else if (!ADMIN_APPROVAL_CODE.equals(approvalCode.trim())) {
                request.setAttribute("error", "Invalid admin approval code");
                request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
                return;
            }
        }
        boolean hasError = false;
        String errorMessage = "";
        if (rawPassword.length() < 8 ||
                !rawPassword.matches(".*[A-Z].*") ||
                !rawPassword.matches(".*[a-z].*") ||
                !rawPassword.matches(".*\\d.*")) {
            request.setAttribute("error", "Password must be at least 8 characters with uppercase, lowercase, and numbers");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = null;
        if (!hasError) {
            hashedPassword = PasswordHash.hashPassword(rawPassword);
        }
        if (rawPassword == null || confirmPassword == null || !rawPassword.equals(confirmPassword)) {
            hasError = true;
            errorMessage = "Passwords do not match";
        }
        if (!rawPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }



        java.sql.Date dateofbirth = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                dateofbirth = java.sql.Date.valueOf(dobStr);
            } catch (IllegalArgumentException e) {
                hasError = true;
                errorMessage = "Invalid date format";
            }
        }

        byte[] profilePicture = null;
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                profilePicture = new byte[(int) filePart.getSize()];
                fileContent.read(profilePicture);
            }
        }

        if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                fullname == null || fullname.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
            hasError = true;
            errorMessage = "Required fields are missing";
        }

        if (hasError) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(fullname, email, phone, address, username, hashedPassword, dateofbirth, gender, profilePicture, role);

        int userId = UserDAO.addUser(newUser);

        if (userId > 0) {
            request.getSession().setAttribute("registrationSuccess", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        } else {
            request.setAttribute("error", "Registration failed. Username or email may already be in use.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }
}