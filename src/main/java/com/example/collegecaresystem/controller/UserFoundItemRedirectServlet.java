package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UserFoundItemRedirectServlet", value = "/UserFoundItemRedirectServlet")
public class UserFoundItemRedirectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            // Redirect to login with return URL
            String redirectUrl = request.getContextPath() + "/LoginServlet";
            response.sendRedirect(redirectUrl);
            return;
        }

        // Forward to existing lost item form servlet
        request.getRequestDispatcher("/WEB-INF/view/user/found-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}