package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;
import java.io.IOException;

@WebServlet(name = "DeleteAccountServlet", value = "/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Get current user from session
        User currentUser = (User) session.getAttribute("user");

        // Get password from request
        String password = request.getParameter("password");

        if (password == null || password.trim().isEmpty()) {
            // If no password provided, just show the delete account page
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
            return;
        }

        // Check if password is correct
        if (!password.equals(currentUser.getPassword())) {
            // Password is incorrect, set error message and redirect back to profile
            request.setAttribute("error", "Incorrect password. Access to account deletion page denied.");
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
            return;
        }

        // Password is correct, forward to delete account confirmation page
        request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Get current user from session
        User currentUser = (User) session.getAttribute("user");

        // Get form parameters
        String password = request.getParameter("password");
        String reason = request.getParameter("reason");

        // Validate input
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Password is required to delete your account");
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
            return;
        }

        // Check if password is correct
        if (!password.equals(currentUser.getPassword())) {
            request.setAttribute("error", "Incorrect password. Account deletion failed.");
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
            return;
        }

        // Log the reason for deletion (in a real application, you might store this in a database)
        if (reason != null && !reason.trim().isEmpty()) {
            System.out.println("Account deletion reason for user " + currentUser.getUsername() + ": " + reason);
        }

        // Delete user from database
        boolean deleteSuccess = UserDAO.deleteUser(currentUser.getEmail(), password);

        if (deleteSuccess) {
            // Invalidate session (logout)
            session.invalidate();
            String message = "Account deletion successful.";
            request.setAttribute("success", message);
            // Redirect to login page with success message
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to delete account. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
        }
    }
}