package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.utils.DBConnectionUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Report;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet(name = "RecentPostsServlet" , value = "/RecentPostsServlet")
public class RecentPostsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Report> recentPosts = new ArrayList<>();
//        List<LostFoundItem> recentLostPosts = lostFoundDAO.getRecentLostItems(6);
//        request.setAttribute("recentLostPosts", recentLostPosts);



        String sql = "SELECT r.report_id, r.req_type, r.location, r.date_reported, " +
                "r.status, r.item_name, r.description, r.date_lost, r.image, " +
                "it.type_name AS item_type, u.username " +
                "FROM Report r " +
                "JOIN item_types it ON r.item_type_id = it.item_type_id " +
                "JOIN User u ON r.user_id = u.user_id " +
                "ORDER BY r.date_reported DESC";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Report report = new Report();
                report.setReportId(rs.getInt("report_id"));
                report.setReqType(rs.getString("req_type"));
                report.setLocation(rs.getString("location"));
                report.setDateLost(rs.getDate("date_lost"));
                report.setStatus(rs.getString("status"));
                report.setItemName(rs.getString("item_name"));
                report.setDescription(rs.getString("description"));
                report.setItemType(rs.getString("item_type"));
                report.setUsername(rs.getString("username"));


                byte[] imageBytes = rs.getBytes("image");
                if (imageBytes != null && imageBytes.length > 0) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    report.setImageBase64(base64Image);
                }

                recentPosts.add(report);
            }


            request.setAttribute("recentPosts", recentPosts);
            request.getRequestDispatcher("/WEB-INF/view/recent-posts.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/").forward(request, response);
        }
    }
}