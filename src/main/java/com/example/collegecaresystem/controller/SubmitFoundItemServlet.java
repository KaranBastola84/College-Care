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

@WebServlet(name = "SubmitFoundItemServlet", value = "/SubmitFoundItemServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class SubmitFoundItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/found-form.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Authentication check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        try {
            // Retrieve form data
            String itemName = getPartValue(request, "item");
            String category = getPartValue(request, "category");
            String dateFound = getPartValue(request, "dateFound");
            String brand = getPartValue(request, "brand");
            String location = getPartValue(request, "location");
            String description1 = getPartValue(request, "description");

            // Validate required fields
            if (itemName.isEmpty() || category.isEmpty() || dateFound.isEmpty() || location.isEmpty()) {
                handleError(request, response, "Please fill all required fields");
                return;
            }

            // Handle file upload
            Part filePart = request.getPart("image");
            InputStream imageStream = null;
            if (filePart != null && filePart.getSize() > 0 && filePart.getContentType().startsWith("image/")) {
                imageStream = filePart.getInputStream();
            }

            // Build description
            StringBuilder description = new StringBuilder();
            description.append("Found Date: ").append(dateFound).append("\n");
            if (!brand.isEmpty()) description.append("Brand: ").append(brand).append("\n");
            description.append("Location: ").append(location).append("\n");
            description.append("Additional Details: ").append(description1);

            try (Connection conn = DBConnectionUtil.getConnection()) {
                // Get category ID from database
                int itemTypeId = getItemTypeId(conn, category);

                String sql = "INSERT INTO Report (user_id, req_type, location, date_lost, "
                        + "date_reported, status, item_name, image, description, item_type_id) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, user.getId());
                    stmt.setString(2, "found");
                    stmt.setString(3, location);
                    stmt.setDate(4, Date.valueOf(LocalDate.parse(dateFound)));
                    stmt.setDate(5, Date.valueOf(LocalDate.now()));
                    stmt.setString(6, "unclaimed");
                    stmt.setString(7, itemName);

                    if (imageStream != null) {
                        stmt.setBlob(8, imageStream);
                    } else {
                        stmt.setNull(8, Types.BLOB);
                    }

                    stmt.setString(9, description.toString());
                    stmt.setInt(10, itemTypeId);

                    int affectedRows = stmt.executeUpdate();

                    if (affectedRows > 0) {
                        session.setAttribute("success", "Found item reported successfully!");
                    } else {
                        session.setAttribute("error", "Failed to save found item report");
                    }
                    response.sendRedirect(request.getContextPath() + "/SubmitFoundItemServlet");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            handleError(request, response, "Error processing request: " + e.getMessage());
        }
    }

    private int getItemTypeId(Connection conn, String category) throws SQLException {
            String sql = "SELECT item_type_id FROM item_types WHERE type_name = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, category);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt("item_type_id");
                }
            }
        throw new SQLException("Invalid category: " + category);
        }


    private String getPartValue(HttpServletRequest request, String partName) {
        try {
            Part part = request.getPart(partName);
            return new String(part.getInputStream().readAllBytes(), StandardCharsets.UTF_8).trim();
        } catch (Exception e) {
            return "";
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("/WEB-INF/view/found-form.jsp").forward(request, response);
    }
}