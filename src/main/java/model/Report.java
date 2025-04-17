package model;

import java.util.Date;

public class Report {
    private int report_id;
    private int user_id;
    private String req_type;
    private String location;
    private java.sql.Date date_reported;
    private String status;
    private String item_name;
    private String item_type;
    private String description;
    private byte[] image;

    public Report() {}

    public Report(int report_id, int user_id, String req_type, String location, java.sql.Date date_reported,
                  String status, String item_name, String item_type, String description, byte[] image) {
        this.report_id = report_id;
        this.user_id = user_id;
        this.req_type = req_type;
        this.location = location;
        this.date_reported = date_reported;
        this.status = status;
        this.item_name = item_name;
        this.item_type = item_type;
        this.description = description;
        this.image = image;
    }

    public int getReportId() {
        return report_id;
    }

    public void setReportId(int report_id) {
        this.report_id = report_id;
    }


    public int getUserId() {
        return user_id;
    }

    public void setUserId(int user_id) {
        this.user_id = user_id;
    }

    public String getReqType() {
        return req_type;
    }
    public void setReqType(String req_type) {
        this.req_type = req_type;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public java.sql.Date getDateReported() {
        return date_reported;
    }
    public void setDateReported(java.sql.Date date_reported) {
        this.date_reported = date_reported;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getItemName() {
        return item_name;
    }
    public void setItemName(String item_name) {
        this.item_name = item_name;
    }
    public String getItemType() {
        return item_type;
    }
    public void setItemType(String item_type) {
        this.item_type = item_type;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public byte[] getImage() {
        return image;
    }
    public void setImage(byte[] image) {
        this.image = image;
    }
}
