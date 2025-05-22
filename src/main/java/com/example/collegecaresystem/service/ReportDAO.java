package com.example.collegecaresystem.service;

import com.example.collegecaresystem.utils.DBConnectionUtil;
import model.Report;

import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class ReportDAO {

    // 1) Create
    public void insert(Report r) throws SQLException {
        String sql = "INSERT INTO Report (user_id, req_type, location, date_reported, "
                + "date_lost, status, item_name, image, description, item_type_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, r.getUserId());
            ps.setString(2, r.getReqType());
            ps.setString(3, r.getLocation());
            ps.setDate(4, r.getDateReported());

            // Handle null dateLost
            if (r.getDateLost() != null) {
                ps.setDate(5, r.getDateLost());
            } else {
                ps.setNull(5, Types.DATE);
            }

            ps.setString(6, r.getStatus());
            ps.setString(7, r.getItemName());

            // Handle image
            if (r.getImage() != null) {
                ps.setBytes(8, r.getImage());
            } else {
                ps.setNull(8, Types.BLOB);
            }

            ps.setString(9, r.getDescription());
            ps.setInt(10, r.getItemTypeId());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    r.setReportId(rs.getInt(1));
                }
            }
        }
    }

    // 2) Read (all)
    public List<Report> findAll() throws SQLException {
        String sql = "SELECT r.*, u.username, t.type_name AS item_type "
                + "FROM Report r "
                + "LEFT JOIN User u ON r.user_id = u.user_id "
                + "LEFT JOIN item_types t ON r.item_type_id = t.item_type_id "
                + "ORDER BY r.date_reported DESC";
        List<Report> list = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Report r = mapRow(rs);
                list.add(r);
            }
        }
        return list;
    }

    // 3) Read (by id)
    public Report findById(int id) throws SQLException {
        String sql = "SELECT r.*, u.username, t.type_name AS item_type "
                + "FROM Report r "
                + "LEFT JOIN User u ON r.user_id = u.user_id "
                + "LEFT JOIN item_types t ON r.item_type_id = t.item_type_id "
                + "WHERE r.report_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    // 4) Update
    public void update(Report r) throws SQLException {
        String sql = "UPDATE Report SET "
                + "req_type = ?, location = ?, date_reported = ?, date_lost = ?, "
                + "status = ?, item_name = ?, image = ?, description = ?, item_type_id = ? "
                + "WHERE report_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Handle null dateLost
            java.sql.Date dateLost = r.getDateLost() != null ?
                    new java.sql.Date(r.getDateLost().getTime()) :
                    null;

            ps.setString(1, r.getReqType());
            ps.setString(2, r.getLocation());
            ps.setDate(3, new java.sql.Date(r.getDateReported().getTime()));
            ps.setDate(4, dateLost);  // Now handles null
            ps.setString(5, r.getStatus());
            ps.setString(6, r.getItemName());
            if (r.getImage() != null) {
                ps.setBytes(7, r.getImage());
            } else {
                ps.setNull(7, Types.BLOB);
            }
            ps.setString(8, r.getDescription());
            ps.setInt(9, r.getItemTypeId());
            ps.setInt(10, r.getReportId());

            ps.executeUpdate();
        }
    }

    // 5) Delete
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM Report WHERE report_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // Helper to map a ResultSet row to a Report
    private Report mapRow(ResultSet rs) throws SQLException {
        Report r = new Report();
        r.setReportId(rs.getInt("report_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setReqType(rs.getString("req_type"));
        r.setLocation(rs.getString("location"));
        r.setDateReported(rs.getDate("date_reported"));
        r.setStatus(rs.getString("status"));
        r.setItemName(rs.getString("item_name"));
        r.setImage(rs.getBytes("image"));
        r.setDescription(rs.getString("description"));
        r.setItemTypeId(rs.getInt("item_type_id"));
        r.setItemType(rs.getString("item_type"));
        r.setUsername(rs.getString("username"));  // transient field for display
        return r;
    }

    public long countReportsByType(String type) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Report WHERE req_type = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        }
        return 0;
    }

    public boolean updateStatus(int reportId, String newStatus) throws SQLException {
        String sql = "UPDATE Report SET status = ? WHERE report_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, reportId);

            return ps.executeUpdate() > 0;
        }

    }

    public List<Report> getRecentItemsByType(String type, int limit) throws SQLException {
        String sql = "SELECT r.*, u.username FROM report r "
                + "JOIN user u ON r.user_id = u.user_id "
                + "WHERE r.req_type = ? "
                + "ORDER BY r.date_reported DESC LIMIT ?";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, type);
            ps.setInt(2, limit);

            List<Report> reports = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Report report = mapRow(rs);
                    // Add Base64 image conversion if needed
                    if (report.getImage() != null) {
                        String imageBase64 = Base64.getEncoder().encodeToString(report.getImage());
                        report.setImageBase64(imageBase64);
                    }
                    reports.add(report);
                }
            }
            return reports;
        }
    }
}
