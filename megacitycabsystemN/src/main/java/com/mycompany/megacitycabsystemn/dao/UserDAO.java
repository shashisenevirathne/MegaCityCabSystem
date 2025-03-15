package com.mycompany.megacitycabsystemn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.mycompany.megacitycabsystemn.model.DatabaseConnection;
import com.mycompany.megacitycabsystemn.model.User;

public class UserDAO {
    public User validateUser(String username, String hashedPassword) {
        User user = null;
        String query = "SELECT username, role FROM users WHERE username=? AND password=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(rs.getString("username"), rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
