package com.example.collegecaresystem.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import model.User;
import java.io.IOException;

@WebFilter(urlPatterns = "/admin/*")
public class AuthorizationFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Allow access to login/register pages
        if (req.getRequestURI().endsWith("/LoginServlet") ||
                req.getRequestURI().endsWith("/RegisterServlet")) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/LoginServlet");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            req.setAttribute("errorMessage", "Admin privileges required");
            req.getRequestDispatcher("/WEB-INF/view/error/403.jsp").forward(request, response);
            return;
        }

        chain.doFilter(request, response);
    }
}