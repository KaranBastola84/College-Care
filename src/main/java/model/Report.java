package model;

import java.util.Date;

public class Report {
    private int report_id;
    private int user_id;
    private String req_type;
    private String location;
    private java.sql.Date date_reported;
    private String status;
    private int item_id;
    private String item_name;
    private byte[] image;
    private String description;
    private int item_type_id;
    private String item_type;

    public Report() {}

    public Report(int report_id, int user_id, String req_type, String location, java.sql.Date date_reported,
                  String status,int item_id, String item_name, byte[] image, String description, int item_type_id, String item_type) {
        this.report_id = report_id;
        this.user_id = user_id;
        this.req_type = req_type;
        this.location = location;
        this.date_reported = date_reported;
        this.status = status;
        this.item_id = item_id;
        this.item_name = item_name;
        this.image = image;
        this.description = description;
        this.item_type_id = item_type_id;
        this.item_type = item_type;
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

    public int getItem_id() {
        return item_id;
    }
    public void setItemId(int item_id) {
        this.item_id = item_id;
    }
    public String getItemName() {
        return item_name;
    }
    public void setItemName(String item_name) {
        this.item_name = item_name;
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
    public int getItem_type_id() {
        return item_type_id;
    }
    public void setItemTypeId(int item_type_id) {
        this.item_type_id = item_type_id;
    }

    public String getItemType() {
        return item_type;
    }
    public void setItemType(String item_type) {
        this.item_type = item_type;
    }
}
