package com.example.collegecaresystem.service;

import model.User;
import model.UserDAO;
import com.example.collegecaresystem.utils.PasswordHash;

public class AuthService {
    public static User authenticate(String usernameOrEmail, String password) {
        User user = UserDAO.getUserByEmailOrUsername(usernameOrEmail, password);
        if (user != null && PasswordHash.verifyPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }
}