package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final String REMEMBER_ME_COOKIE_NAME = "rememberMe";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Remove user attribute
            session.removeAttribute("user");
            session.removeAttribute("loggedIn");

            // Invalidate the session
            session.invalidate();
        }

        // Clear the remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (REMEMBER_ME_COOKIE_NAME.equals(cookie.getName())) {
                    cookie.setValue("");
                    cookie.setPath(request.getContextPath());
                    cookie.setMaxAge(0); // This will delete the cookie
                    response.addCookie(cookie);
                    break;
                }
            }
        }

        // Add a message to be displayed on the login page
        request.getSession().setAttribute("success", "You have been successfully logged out.");

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Call doGet to handle post requests as well
        doGet(request, response);
    }
}