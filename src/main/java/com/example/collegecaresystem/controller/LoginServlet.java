package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.service.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;
import com.example.collegecaresystem.utils.DBConnectionUtil;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String REMEMBER_ME_COOKIE_NAME = "rememberMe";
    private static final int COOKIE_AGE = 7 * 24 * 60 * 60;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession existingSession = request.getSession(false);
        if (existingSession != null && existingSession.getAttribute("loggedIn") != null) {
            User user = (User) existingSession.getAttribute("user");
            redirectBasedOnRole(user, request, response);
            return;
        }

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
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user);
                            session.setAttribute("loggedIn", true);
                            redirectBasedOnRole(user, request, response);
                            return;
                        }
                    }
                }
            }
        }

        String registrationSuccess = (String) request.getSession().getAttribute("registrationSuccess");
        if (registrationSuccess != null) {
            request.setAttribute("registrationSuccess", registrationSuccess);
            request.getSession().removeAttribute("registrationSuccess");
        }

        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        User user = AuthService.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);

            if (rememberMe != null && rememberMe.equals("on")) {
                String cookieValue = encodeCookieValue(username, password);
                Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE_NAME, cookieValue);
                rememberMeCookie.setHttpOnly(true);
                rememberMeCookie.setSecure(true);
                rememberMeCookie.setMaxAge(COOKIE_AGE);
                rememberMeCookie.setPath(request.getContextPath());
                response.addCookie(rememberMeCookie);
            }

            redirectBasedOnRole(user, request, response);
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    private void redirectBasedOnRole(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String role = user.getRole();
        String contextPath = request.getContextPath();

        if ("admin".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
        } else {
            response.sendRedirect(request.getContextPath() + "/UserDashboardServlet");
        }
    }

    private String encodeCookieValue(String username, String password) {
        return username + ":" + password;
    }

    private String[] decodeCookieValue(String cookieValue) {
        return cookieValue.split(":");
    }
}