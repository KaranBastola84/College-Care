package com.example.collegecaresystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import model.UserDAO;
import com.example.collegecaresystem.utils.PasswordHash;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

@WebServlet(name = "UpdateProfileServlet", value = "/UpdateProfileServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class UpdateProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name"); // Correct variable name
        String dateOfBirthStr = request.getParameter("dateofbirth");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (!PasswordHash.verifyPassword(password, currentUser.getPassword())) {
            request.setAttribute("error", "Incorrect password. Profile update failed.");
            request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
            return;
        }

        Date dateOfBirth = null;
        try {
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(dateOfBirthStr);
                dateOfBirth = new Date(utilDate.getTime());
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Use YYYY-MM-DD.");
            request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
            return;
        }

        byte[] profilePicture = currentUser.getProfilePicture();
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream fileContent = filePart.getInputStream()) {
                BufferedImage image = ImageIO.read(fileContent);
                if (image != null) {
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    ImageIO.write(image, "jpg", baos);
                    profilePicture = baos.toByteArray();
                }
            } catch (Exception e) {
                request.setAttribute("error", "Invalid image: " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
                return;
            }
        }

        currentUser.setFullname(fullName);
        currentUser.setDateofbirth(dateOfBirth);
        currentUser.setGender(gender);
        currentUser.setPhone(phone);
        currentUser.setAddress(address);
        currentUser.setProfilePicture(profilePicture);

        boolean updateSuccess = UserDAO.updateUser(currentUser);

        if (updateSuccess) {
            session.setAttribute("user", currentUser);
            request.getSession().setAttribute("success", "Profile updated successfully!");
            response.sendRedirect(request.getContextPath() + "/UserProfileServlet");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/editprofile.jsp").forward(request, response);
        }
    }
}