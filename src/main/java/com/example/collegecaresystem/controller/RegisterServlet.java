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
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 5,     // 5 MB
        maxRequestSize = 1024 * 1024 * 10   // 10 MB
)
public class RegisterServlet extends HttpServlet {
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

        boolean hasError = false;
        String errorMessage = "";

        // Check if passwords match
        if (rawPassword == null || confirmPassword == null || !rawPassword.equals(confirmPassword)) {
            hasError = true;
            errorMessage = "Passwords do not match";
        }

        // Hash the password only if no error
        String hashedPassword = null;
        if (!hasError) {
            hashedPassword = PasswordHash.hashPassword(rawPassword);
        }

        // Parse date of birth
        java.sql.Date dateofbirth = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                dateofbirth = java.sql.Date.valueOf(dobStr);
            } catch (IllegalArgumentException e) {
                hasError = true;
                errorMessage = "Invalid date format";
            }
        }

        // Handle profile picture upload
        byte[] profilePicture = null;
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                profilePicture = new byte[(int) filePart.getSize()];
                fileContent.read(profilePicture);
            }
        }

        // Validate required fields
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

        // Create user object
        User newUser = new User(fullname, email, phone, address, username, hashedPassword, dateofbirth, gender, profilePicture, role);

        // Add user to database
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