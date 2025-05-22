package com.example.collegecaresystem.controller;

import com.example.collegecaresystem.service.ReportDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Report;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
@WebServlet(name = "AdminDashboardServlet", value = "/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private final ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            long lostCount = reportDAO.countReportsByType("lost");
            long foundCount = reportDAO.countReportsByType("found");

            // Get all reports with user info
            List<Report> reports = reportDAO.findAll();

            // Set request attributes
            request.setAttribute("lostCount", lostCount);
            request.setAttribute("foundCount", foundCount);
            request.setAttribute("reports", reports);

            request.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp")
                    .forward(request, response);

        } catch (SQLException ex) {
            throw new ServletException("Database error: " + ex.getMessage(), ex);
        }
    }
}