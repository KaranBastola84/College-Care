package com.example.collegecaresystem.controller.admin;

import com.example.collegecaresystem.service.ItemTypeDAO;
import com.example.collegecaresystem.service.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ItemType;
import model.Report;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "AdminReportCreateServlet", urlPatterns = "/admin/reports/create")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class AdminReportCreateServlet extends HttpServlet {
    private ReportDAO reportDAO = new ReportDAO();
    private ItemTypeDAO itemTypeDAO = new ItemTypeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<ItemType> itemTypes = itemTypeDAO.getAllItemTypes();
            req.setAttribute("itemTypes", itemTypes);
            req.getRequestDispatcher("/WEB-INF/view/admin/report_form.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Error loading item categories");
            req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // Validate item type
            int itemTypeId = Integer.parseInt(req.getParameter("itemTypeId"));
            if (!itemTypeDAO.exists(itemTypeId)) {
                req.setAttribute("error", "Invalid item category selected");
                doGet(req, resp); // Re-show form with error
                return;
            }

            // Parse other parameters
            String reqType = req.getParameter("reqType");
            String itemName = req.getParameter("itemName");
            String location = req.getParameter("location");
            String status = req.getParameter("status");
            String description = req.getParameter("description");

            // Parse dates
            Date dateReported = parseDate(req.getParameter("dateReported"));
            Date dateLost = parseDate(req.getParameter("dateLost"));

            // Handle image upload
            byte[] imageBytes = null;
            Part imagePart = req.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try (InputStream in = imagePart.getInputStream()) {
                    imageBytes = in.readAllBytes();
                }
            }

            // Get user from session
            HttpSession session = req.getSession(false);
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                throw new ServletException("User not authenticated");
            }

            // Create and save report
            Report report = new Report();
            report.setUserId(userId);
            report.setReqType(reqType);
            report.setItemName(itemName);
            report.setItemTypeId(itemTypeId);
            report.setDateReported(dateReported);
            report.setDateLost(dateLost);
            report.setLocation(location);
            report.setStatus(status);
            report.setDescription(description);
            report.setImage(imageBytes);

            reportDAO.insert(report);

            resp.sendRedirect(req.getContextPath() + "/admin/reports?success=Report+created+successfully");

        } catch (SQLException | NumberFormatException | ParseException e) {
            req.setAttribute("error", "Error creating report: " + e.getMessage());
            doGet(req, resp);
        }
    }

    private Date parseDate(String dateString) throws ParseException {
        if (dateString == null || dateString.trim().isEmpty()) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate = sdf.parse(dateString);
        return new Date(utilDate.getTime());
    }
}