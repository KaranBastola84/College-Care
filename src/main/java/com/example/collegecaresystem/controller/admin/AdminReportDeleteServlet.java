package com.example.collegecaresystem.controller.admin;

import com.example.collegecaresystem.service.ReportDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="AdminReportDeleteServlet", urlPatterns="/admin/reports/delete")
public class AdminReportDeleteServlet extends HttpServlet {
    private final ReportDAO reportDAO = new ReportDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int reportId = Integer.parseInt(request.getParameter("id"));

        try {
            reportDAO.delete(reportId);
            request.getSession().setAttribute("successMessage",
                    "Report #" + reportId + " deleted successfully");
        } catch (SQLException ex) {
            request.getSession().setAttribute("errorMessage",
                    "Error deleting report: " + ex.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
