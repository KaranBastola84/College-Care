package model;

import com.example.collegecaresystem.utils.PasswordHash;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import at.favre.lib.crypto.bcrypt.BCrypt;

public class UserDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/lostandfound";
    private static final String USER = "root";
    private static final String PASS = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
    public static int addUser(User user) {
        String query = "INSERT INTO user (username, email, password, fullname, dateofbirth, gender, phone, address, profilePicture, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getFullname());
            try {
                String dobString = user.getDateofbirth();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date parsedDate = (Date) sdf.parse(dobString);
                ps.setDate(5, new java.sql.Date(parsedDate.getTime()));
            } catch (ParseException e) {
                ps.setNull(5, java.sql.Types.DATE);
            }

            ps.setString(6, user.getGender());
            ps.setString(7, user.getPhone());
            ps.setString(8, user.getAddress());
            ps.setString(9,user.getRole());
            // Handling Profile Picture (if not null)
            if (user.getProfilePicture() != null) {
                ps.setBytes(10, user.getProfilePicture()); // Store image as BLOB
            } else {
                ps.setNull(10, Types.BLOB); // If no image, set NULL
            }
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Return the new user ID
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return -1; // Return -1 if insertion fails
    }
    // Authunicate User
    public static User getUserByEmailOrUsername(String emailOrUsername, String password) {
        String query = "SELECT * FROM user WHERE (email = ? OR username = ?) AND password = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("fullName"),
                        rs.getString("dateofbirth"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getBytes("profilePicture"),
                        rs.getString("role")
                         // Binary image data
                );
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null; // Return null if authentication fails
    }

    public static boolean updateUser(User user) {
        String query = "UPDATE user SET password = ?, fullName = ?, dateOfBirth = ?, gender = ?, phone = ?, address = ?, profilePicture = ? WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getPassword()); // Ensure password is hashed before storing
            ps.setString(2, user.getFullname());
            try {
                String dobString = user.getDateofbirth();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date parsedDate = (Date) sdf.parse(dobString);
                ps.setDate(5, new java.sql.Date(parsedDate.getTime()));
            } catch (ParseException e) {
                ps.setNull(5, java.sql.Types.DATE);
            } // Convert Date to SQL Date
            ps.setString(4, user.getGender());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());

            // Handling Profile Picture
            if (user.getProfilePicture() != null) {
                ps.setBytes(7, user.getProfilePicture()); // Update image
            } else {
                ps.setNull(7, Types.BLOB); // If no new image, set NULL
            }

            ps.setInt(8, user.getId()); // WHERE condition (ensures ID remains unchanged)

            // Execute update and check if successful
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0; // Returns true if update was successful

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false; // Return false if update fails
    }

    // Method to update user password
    public static boolean updatePassword(int userId, String currentPassword, String newPassword) {
        // First verify the current password
        String verifyQuery = "SELECT password FROM user WHERE user_id = ?";
        String updateQuery = "UPDATE user SET password = ? WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psVerify = conn.prepareStatement(verifyQuery);
             PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {

            // Verify current password
            psVerify.setInt(1, userId);
            ResultSet rs = psVerify.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                // If current password matches, update to new password
                if (storedPassword.equals(currentPassword)) {
                    psUpdate.setString(1, newPassword); // Should hash the password in a real application
                    psUpdate.setInt(2, userId);

                    int affectedRows = psUpdate.executeUpdate();
                    return affectedRows > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return false; // Return false if password update fails
    }

    // Method to delete user by username/email and password
    public static boolean deleteUser(String emailOrUsername, String password) {
        String queryCheck = "SELECT user_id, password FROM user WHERE (email = ? OR username = ?)";
        String queryDelete = "DELETE FROM user WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psCheck = conn.prepareStatement(queryCheck);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete)) {

            // Step 1: Check if the username/email and password match
            psCheck.setString(1, emailOrUsername);
            psCheck.setString(2, emailOrUsername);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String storedPassword = rs.getString("password"); // Get stored password

                if (!storedPassword.equals(password)) { // Compare passwords
                    System.out.println("Incorrect password. User deletion failed.");
                    return false;
                }

                // Step 2: If password matches, delete the user
                psDelete.setInt(1, userId);
                int affectedRows = psDelete.executeUpdate();
                return affectedRows > 0; // Returns true if deletion was successful
            } else {
                System.out.println("User not found with that username/email.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false; // Return false if deletion fails
    }
}