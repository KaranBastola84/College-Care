package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String REMEMBER_ME_COOKIE_NAME = "rememberMe";
    private static final int COOKIE_AGE = 7 * 24 * 60 * 60;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in via remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (REMEMBER_ME_COOKIE_NAME.equals(cookie.getName())) {
                    String[] credentials = decodeCookieValue(cookie.getValue());
                    if (credentials != null && credentials.length == 2) {
                        String username = credentials[0];
                        String password = credentials[1];
                        User user = UserDAO.getUserByEmailOrUsername(username, password);
                        if (user != null) {
                            // Auto login successful
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user);
                            session.setAttribute("loggedIn", true);
                            response.sendRedirect(request.getContextPath() + "/");
                            return;
                        }
                    }
                }
            }
        }

        // Check if there's a success message
        String registrationSuccess = (String) request.getSession().getAttribute("registrationSuccess");
        if (registrationSuccess != null) {
            request.setAttribute("registrationSuccess", registrationSuccess);
            // Remove the session attribute to prevent showing the message again
            request.getSession().removeAttribute("registrationSuccess");
        }

        // Redirect to the login.jsp page in WEB-INF/view directory
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Validate input
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = UserDAO.getUserByEmailOrUsername(username, password);

        if (user != null) {
            // Authentication successful
            // Store user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);

            // Handle remember me functionality
            if (rememberMe != null && rememberMe.equals("on")) {
                String cookieValue = encodeCookieValue(username, password);
                Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE_NAME, cookieValue);
                rememberMeCookie.setMaxAge(COOKIE_AGE);
                rememberMeCookie.setPath(request.getContextPath());
                response.addCookie(rememberMeCookie);
            }

            // Redirect to homepage
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    private String encodeCookieValue(String username, String password) {
        // Simple encoding - in production, use more secure methods
        return username + ":"+password;
    }

    private String[] decodeCookieValue(String cookieValue) {
        // Simple decoding - in production, use more secure methods
        return cookieValue.split(":");
    }
}