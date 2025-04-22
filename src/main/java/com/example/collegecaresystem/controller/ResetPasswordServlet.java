package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;
import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", value = "/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        User currentUser = (User) session.getAttribute("user");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirm password do not match");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            return;
        }

        if (!currentPassword.equals(currentUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
            return;
        }
        boolean updateSuccess = UserDAO.updatePassword(currentUser.getId(), currentPassword, newPassword);

        if (updateSuccess) {
            currentUser.setPassword(newPassword);
            session.setAttribute("user", currentUser);

            request.getSession().setAttribute("success", "Password updated successfully!");
            response.sendRedirect(request.getContextPath() + "/UserProfileServlet");
        } else {
            request.setAttribute("error", "Failed to update password. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/resetpassword.jsp").forward(request, response);
        }
    }
}