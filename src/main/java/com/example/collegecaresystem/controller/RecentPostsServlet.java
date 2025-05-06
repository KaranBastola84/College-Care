package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.utils.DBConnectionUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Report;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import java.io.IOException;

@WebServlet(name = "RecentPostsServlet", value = "/RecentPostsServlet")
public class RecentPostsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Report> recentPosts = new ArrayList<>();

        String sql = "SELECT r.report_id, r.req_type, r.location, r.date_reported, " +
                "r.status, r.item_name, r.description, r.date_lost, " +
                "it.type_name AS item_type, u.username " +
                "FROM Report r " +
                "JOIN item_types it ON r.item_type_id = it.item_type_id " +
                "JOIN User u ON r.user_id = u.user_id " +
                "ORDER BY r.date_reported DESC LIMIT 20";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Report report = new Report();
                report.setReportId(rs.getInt("report_id"));
                report.setReqType(rs.getString("req_type"));
                report.setLocation(rs.getString("location"));
                report.setDateReported(rs.getDate("date_reported"));
                report.setStatus(rs.getString("status"));
                report.setItemName(rs.getString("item_name"));
                report.setDescription(rs.getString("description"));
                report.setDateReported(rs.getDate("date_lost"));
                report.setItemType(rs.getString("item_type"));

                // Set additional fields from join
                report.setUsername(rs.getString("username"));

                recentPosts.add(report);
            }

            request.setAttribute("recentPosts", recentPosts);
            request.getRequestDispatcher("/WEB-INF/view/recent-posts.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}