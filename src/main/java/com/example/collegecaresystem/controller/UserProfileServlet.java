package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.dto.UserDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

import java.io.IOException;

@WebServlet(name = "UserProfileServlet", value = "/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        User currentUser = (User) session.getAttribute("user");
        UserDTO userDTO = new UserDTO(currentUser);
        request.setAttribute("userDTO", userDTO);
        String success = (String) session.getAttribute("success");
        request.setAttribute("success", success);
        String error = (String) session.getAttribute("error");
        request.setAttribute("error", error);
        request.getRequestDispatcher("/WEB-INF/view/userprofile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}