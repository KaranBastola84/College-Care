package com.example.collegecaresystem.dto;

import model.User;

import java.sql.Date;
import java.util.Base64;
public class UserDTO {
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

    public UserDTO(User user){
        this.user_id = user.getId();
        this.full_name = user.getFullname();
        this.email = user.getEmail();
        this.phone = user.getPhone();
        this.address = user.getAddress();
        this.username = user.getUsername();
        this.password = user.getPassword();
        this.dateofbirth = user.getDateofbirth();
        this.gender = user.getGender();
        this.profilePicture = user.getProfilePicture();
        this.role = user.getRole();
    }

    public int getUserId() { return user_id; }
    public String getFullName() { return full_name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    public String getUsername() { return username; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getGender() { return gender; }

    public String getDateOfBirth() {
        return dateofbirth != null ? dateofbirth.toString() : "";
    }

    public String getProfilePicture() {
        if (profilePicture != null && profilePicture.length > 0) {
            return "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profilePicture);
        }
        return "/assets/images/default-avatar.png";
    }
}
