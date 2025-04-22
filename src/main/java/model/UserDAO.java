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
        String query = "INSERT INTO user (full_name, email, phone, address, username, password, dateofbirth, gender, profilePicture, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(5, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(6, user.getPassword());
            ps.setString(1, user.getFullname());
            try {
                java.sql.Date dob = user.getDateofbirth();
                if (dob != null) {
                    ps.setDate(7, dob);
                } else {
                    ps.setNull(7, java.sql.Types.DATE);
                }
            } catch (Exception e) {
                ps.setNull(7, java.sql.Types.DATE);
            }

            ps.setString(8, user.getGender());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(10,user.getRole());
            // Handling Profile Picture (if not null)
            if (user.getProfilePicture() != null) {
                ps.setBytes(9, user.getProfilePicture());
            } else {
                ps.setNull(9, Types.BLOB);
            }
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return -1;
    }

    public static User getUserByEmailOrUsername(String emailOrUsername, String password) {
        String query = "SELECT * FROM user WHERE email = ? OR username = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");


                if (PasswordHash.verifyPassword(password, hashedPassword)) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("username"),
                            hashedPassword,
                            rs.getDate("dateofbirth"),
                            rs.getString("gender"),
                            rs.getBytes("profilePicture"),
                            rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null;
    }


    public static boolean updateUser(User user) {
        String query = "UPDATE user SET password = ?, full_name = ?, dateOfBirth = ?, gender = ?, phone = ?, address = ?, profilePicture = ? WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, user.getPassword());
            ps.setString(2, user.getFullname());
            try {
                String dobString = String.valueOf(user.getDateofbirth());
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date parsedDate = (Date) sdf.parse(dobString);
                ps.setDate(5, new java.sql.Date(parsedDate.getTime()));
            } catch (ParseException e) {
                ps.setNull(5, java.sql.Types.DATE);
            }
            ps.setString(4, user.getGender());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());


            if (user.getProfilePicture() != null) {
                ps.setBytes(7, user.getProfilePicture());
            } else {
            }

            ps.setInt(8, user.getId());


            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false;
    }


    public static boolean updatePassword(int userId, String currentPassword, String newPassword) {

        String verifyQuery = "SELECT password FROM user WHERE user_id = ?";
        String updateQuery = "UPDATE user SET password = ? WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psVerify = conn.prepareStatement(verifyQuery);
             PreparedStatement psUpdate = conn.prepareStatement(updateQuery)) {


            psVerify.setInt(1, userId);
            ResultSet rs = psVerify.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");


                if (storedPassword.equals(currentPassword)) {
                    psUpdate.setString(1, newPassword);
                    psUpdate.setInt(2, userId);

                    int affectedRows = psUpdate.executeUpdate();
                    return affectedRows > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return false;
    }

    public static boolean deleteUser(String emailOrUsername, String password) {
        String queryCheck = "SELECT user_id, password FROM user WHERE (email = ? OR username = ?)";
        String queryDelete = "DELETE FROM user WHERE user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement psCheck = conn.prepareStatement(queryCheck);
             PreparedStatement psDelete = conn.prepareStatement(queryDelete)) {

            psCheck.setString(1, emailOrUsername);
            psCheck.setString(2, emailOrUsername);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String storedPassword = rs.getString("password");

                if (!PasswordHash.verifyPassword(password, storedPassword)) {
                    System.out.println("Incorrect password. User deletion failed.");
                    return false;
                }

                psDelete.setInt(1, userId);
                int affectedRows = psDelete.executeUpdate();
                return affectedRows > 0;
            } else {
                System.out.println("User not found with that username/email.");
                return false;
            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return false;
    }
}