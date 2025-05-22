package model;

import java.sql.Date;

public class Report {
    private int reportId;
    private int userId;
    private String reqType;
    private String location;
    private java.sql.Date dateReported;
    private java.util.Date dateLost;
    private String status;
    private int itemId;
    private String itemName;
    private byte[] image;
    private String description;
    private int itemTypeId;
    private String itemType;
    private transient String username;
    private String imageBase64;

    public Report() {}

    public Report(int reportId, int userId, String reqType, String location, java.sql.Date dateReported,
                  String status, int itemId, String itemName, byte[] image, String description, int itemTypeId, String itemType) {
        this.reportId = reportId;
        this.userId = userId;
        this.reqType = reqType;
        this.location = location;
        this.dateReported = dateReported;
        this.status = status;
        this.itemId = itemId;
        this.itemName = itemName;
        this.image = image;
        this.description = description;
        this.itemTypeId = itemTypeId;
        this.itemType = itemType;

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

    public String getReqType() {
        return reqType;
    }

    public void setReqType(String reqType) {
        this.reqType = reqType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public java.sql.Date getDateReported() {
        return dateReported;
    }

    public void setDateReported(java.sql.Date dateReported) {
        this.dateReported = dateReported;
    }

    public Date getDateLost() {
        return (Date) dateLost;
    }

    public void setDateLost(java.util.Date dateLost) {
        this.dateLost = dateLost;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getItemTypeId() {
        return itemTypeId;
    }

    public void setItemTypeId(int itemTypeId) {
        this.itemTypeId = itemTypeId;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public String getImageBase64() {
        return imageBase64;
    }

    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
    }

    public String getStatusBadge() {
        switch (status.toLowerCase()) {
            case "open": return "<span class='status open'>Open</span>";
            case "resolved": return "<span class='status resolved'>Resolved</span>";
            case "pending": return "<span class='status pending'>Pending</span>";
            default: return "<span class='status'>" + status + "</span>";
        }
    }

    public String getTypeBadge() {
        if ("lost".equalsIgnoreCase(reqType)) {
            return "<span class='tag lost'>Lost</span>";
        }
        return "<span class='tag found'>Found</span>";
    }

    public Date getSafeDateLost() {
        return this.dateLost != null ? (Date) this.dateLost : new Date(System.currentTimeMillis());
    }

}
