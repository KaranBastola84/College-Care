package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.utils.PasswordHash;
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
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        String password = request.getParameter("password");

        if (password == null || password.trim().isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
            return;
        }

        if (!PasswordHash.verifyPassword(password, currentUser.getPassword())) {
            request.setAttribute("error", "Incorrect password. Access to account deletion page denied.");
            request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        String password = request.getParameter("password");
        String reason = request.getParameter("reason");

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Password is required to delete your account");
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
            return;
        }

        if (!password.equals(currentUser.getPassword())) {
            request.setAttribute("error", "Incorrect password. Account deletion failed.");
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
            return;
        }

        if (reason != null && !reason.trim().isEmpty()) {
            System.out.println("Account deletion reason for user " + currentUser.getUsername() + ": " + reason);
        }

        boolean deleteSuccess = UserDAO.deleteUser(currentUser.getEmail(), password);

        if (deleteSuccess) {
            session.invalidate();
            String message = "Account deletion successful.";
            request.setAttribute("success", message);
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to delete account. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/deleteaccount.jsp").forward(request, response);
        }
    }
}