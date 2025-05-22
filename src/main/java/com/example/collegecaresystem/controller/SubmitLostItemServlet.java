package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.utils.DBConnectionUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.time.LocalDate;

@WebServlet(name = "SubmitLostItemServlet", value = "/submit-lost")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class SubmitLostItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/lost-form.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        User user = (User) session.getAttribute("user");
        try {
            // Get form data
            String itemName = getPartValue(request, "item_name");
            String category = getPartValue(request, "item_type");
            String dateLost = getPartValue(request, "date_reported");
            String location = getPartValue(request, "location");
            String description = getPartValue(request, "description");

            // Validate required fields
            if (itemName.isEmpty() || category.isEmpty() || dateLost.isEmpty() || location.isEmpty()) {
                sendError(request, response, "All required fields must be filled");
                return;
            }

            // Handle file upload
            Part filePart = request.getPart("image");
            InputStream imageStream = null;
            if (filePart != null && filePart.getSize() > 0 && filePart.getContentType().startsWith("image/")) {
                imageStream = filePart.getInputStream();
            }

            try (Connection conn = DBConnectionUtil.getConnection()) {
                // Get category ID from database
                int itemTypeId = getItemTypeId(conn, category);

                String sql = "INSERT INTO Report (user_id, req_type, location, date_lost, "
                        + "date_reported, status, item_name, image, description, item_type_id) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, user.getId());
                    stmt.setString(2, "lost");
                    stmt.setString(3, location);
                    stmt.setDate(4, Date.valueOf(LocalDate.parse(dateLost)));  // User-provided lost date
                    stmt.setDate(5, Date.valueOf(LocalDate.now()));           // Current date as reported date
                    stmt.setString(6, "unclaimed");
                    stmt.setString(7, itemName);

                    if (imageStream != null) {
                        stmt.setBlob(8, imageStream);
                    } else {
                        stmt.setNull(8, Types.BLOB);
                    }

                    stmt.setString(9, description);
                    stmt.setInt(10, itemTypeId);

                    int affectedRows = stmt.executeUpdate();

                    if (affectedRows > 0) {
                        session.setAttribute("success", "Item reported successfully!");
                    } else {
                        session.setAttribute("error", "Failed to save report");
                    }
                    if (affectedRows > 0) {
                        session.setAttribute("success", "Item reported successfully!");
                    } else {
                        session.setAttribute("error", "Failed to save report");
                    }
                    response.sendRedirect(request.getContextPath() + "/submit-lost");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendError(request, response, "Database error: " + e.getMessage());
        }
    }

    private int getItemTypeId(Connection conn, String category) throws SQLException {
        String sql = "SELECT item_type_id FROM item_types WHERE type_name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt("item_type_id") : 0;
        }
    }

    private String getPartValue(HttpServletRequest request, String partName) {
        try {
            Part part = request.getPart(partName);
            return new String(part.getInputStream().readAllBytes(), StandardCharsets.UTF_8).trim();
        } catch (Exception e) {
            return "";
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/view/lost-form.jsp").forward(request, response);
    }
}