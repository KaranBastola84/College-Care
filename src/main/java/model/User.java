package model;

import java.util.Date;
public class User {
    private int user_id;
    private String full_name;
    private String email;
    private String phone;
    private String address;
    private String username;
    private String password;
    private java.sql.Date dateofbirth;
    private String gender;
    private byte[] profilePicture;
    private String role;

    public User(int user_id, String full_name, String email, String phone, String address, String username, String password, java.sql.Date dateofbirth, String gender, byte[] profilePicture, String role) {
        this.user_id = user_id;
        this.full_name = full_name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.dateofbirth = dateofbirth;
        this.role = role;
        this.profilePicture = profilePicture;
    }

    public User(String full_name, String email, String phone, String address, String username, String password, java.sql.Date dateofbirth, String gender, byte[] profilePicture, String role) {
    this(0, full_name, email, phone, address, username, password, dateofbirth, gender, profilePicture, role);
    }

    public int getId() {
        return user_id;
    }
    public void setId(int user_id) {
        this.user_id = user_id;
    }
    public String getFullname() {
        return full_name;
    }
    public void setFullname(String full_name) {
        this.full_name = full_name;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public java.sql.Date getDateofbirth() {
        return dateofbirth;
    }
    public void setDateofbirth(java.sql.Date dateofbirth) {
        this.dateofbirth = dateofbirth;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
    public byte[] getProfilePicture() {
        return profilePicture;
    }
    public void setProfilePicture(byte[] profilePicture) {
        this.profilePicture = profilePicture;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
}
