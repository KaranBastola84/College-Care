package com.example.collegecaresystem.dto;

import model.User;

import java.sql.Date;
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
}
