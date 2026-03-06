package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DBConnection;

import java.sql.*;

public class UserDAO {

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user: " + e.getMessage());
        }
        return null;
    }

    public boolean validateUser(String username, String password) {
        User u = getUserByUsername(username);
        if (u != null && u.getPassword().equals(password)) {
            return true;
        }
        return false;
    }
}
