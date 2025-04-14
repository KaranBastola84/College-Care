package model;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class UserDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/LostandFound";
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
        String query = "INSERT INTO users (username, email, password, fullname, dateofbirth, gender, phone, address, profilePicture) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                e.printStackTrace();
                ps.setNull(5, java.sql.Types.DATE);
            }

            ps.setString(6, user.getGender());
            ps.setString(7, user.getPhone());
            ps.setString(8, user.getAddress());
            // Handling Profile Picture (if not null)
            if (user.getProfilePicture() != null) {
                ps.setBytes(9, user.getProfilePicture()); // Store image as BLOB
            } else {
                ps.setNull(9, Types.BLOB); // If no image, set NULL
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
}