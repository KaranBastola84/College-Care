package com.example.collegecaresystem.service;

import model.User;
import model.UserDAO;

public class UserService {
    public static boolean deleteUser(String emailOrUsername, String password) {
        return UserDAO.deleteUser(emailOrUsername, password);
    }
}