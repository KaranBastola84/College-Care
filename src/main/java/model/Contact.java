package model;

public class Contact {
    private int contact_id;
    private int user_id;
    private String name;
    private String email;
    private String subject;
    private String message;
    private java.sql.Timestamp msgSent;

    public Contact() {}

    public Contact(int contact_id, int user_id, String name, String email, String subject, String message, java.sql.Timestamp msgSent) {
        this.contact_id = contact_id;
        this.user_id = user_id;
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.msgSent = msgSent;
    }

    public int getContactId() {
        return contact_id;
    }

    public void setContactId(int contact_id) {
        this.contact_id = contact_id;
    }

    public int getUserId() {
        return user_id;
    }

    public void setUserId(int user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public java.sql.Timestamp getMsgSent() {
        return msgSent;
    }

    public void setMsgSent(java.sql.Timestamp msgSent) {
        this.msgSent = msgSent;
    }
}
