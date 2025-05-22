package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Contact;
import com.example.collegecaresystem.utils.DBConnectionUtil;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

@WebServlet(name = "ContactServlet", value = "/contact")
@MultipartConfig
public class ContactServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("username");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Get user ID from session if available
        HttpSession session = request.getSession(false);
        Integer userId = (session != null && session.getAttribute("user") != null) ?
                ((User) session.getAttribute("user")).getId() : null;

        // Create Contact object
        Contact contact = new Contact();
        contact.setName(name);
        contact.setEmail(email);
        contact.setSubject(subject);
        contact.setMessage(message);
        contact.setUserId(userId != null ? userId : 0); // Use 0 or handle null in DB

        // Save to database
        try (Connection conn = DBConnectionUtil.getConnection()) {
            String sql = "INSERT INTO Contact (user_id, name, email, subject, message, msg_sent) " +
                    "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setObject(1, userId, Types.INTEGER);
                stmt.setString(2, contact.getName());
                stmt.setString(3, contact.getEmail());
                stmt.setString(4, contact.getSubject());
                stmt.setString(5, contact.getMessage());

                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("success", "Message sent successfully!");
                } else {
                    request.setAttribute("error", "Failed to send message");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}