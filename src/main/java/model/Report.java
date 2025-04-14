package model;

import java.util.Date;

public class Report {
    private int reportId;
    private int userId;
    private int itemId;
    private String status; // e.g., "Lost", "Found", "Returned"
    private Date dateReported;

    public Report() {}

    public Report(int reportId, int userId, int itemId, String status, Date dateReported) {
        this.reportId = reportId;
        this.userId = userId;
        this.itemId = itemId;
        this.status = status;
        this.dateReported = dateReported;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDateReported() {
        return dateReported;
    }

    public void setDateReported(Date dateReported) {
        this.dateReported = dateReported;
    }
}
