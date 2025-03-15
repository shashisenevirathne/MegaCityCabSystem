package com.mycompany.megacitycabsystemn.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.megacitycabsystemn.model.DatabaseConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/RegisterDriverServlet")
public class RegisterDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String nic = request.getParameter("NIC");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String licenseNo = request.getParameter("licenseNo");
        String vehicleNo = request.getParameter("vehicleNo");
        String username = request.getParameter("userName");
        String password = request.getParameter("password"); // Get raw password
        String hashedPassword = hashPassword(password); // Hash it

        try (Connection con = DatabaseConnection.getConnection()) {
            // **Check if username already exists**
            String checkUserQuery = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement checkUserStmt = con.prepareStatement(checkUserQuery);
            checkUserStmt.setString(1, username);
            ResultSet rs = checkUserStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                response.sendRedirect("jsp/registerDriver.jsp?error=Username already exists!");
                return;
            }

            // **Insert into Users table (Including Password)**
            String userQuery = "INSERT INTO users (username, password, role) VALUES (?, ?, 'driver')";
            PreparedStatement userStmt = con.prepareStatement(userQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, username);
            userStmt.setString(2, hashedPassword);
            int userResult = userStmt.executeUpdate();

            if (userResult > 0) {
                // **Get the generated user_id**
                ResultSet generatedKeys = userStmt.getGeneratedKeys();
                int userId = 0;
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1);
                }

                // **Insert into Drivers table**
                String driverQuery = "INSERT INTO drivers (full_name, nic, email, phone, license_no, vehicle_no, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement driverStmt = con.prepareStatement(driverQuery);
                driverStmt.setString(1, fullName);
                driverStmt.setString(2, nic);
                driverStmt.setString(3, email);
                driverStmt.setString(4, phone);
                driverStmt.setString(5, licenseNo);
                driverStmt.setString(6, vehicleNo);
                driverStmt.setInt(7, userId);

                int driverResult = driverStmt.executeUpdate();

                if (driverResult > 0) {
                    response.sendRedirect("jsp/login.jsp?success=Driver registered successfully!");
                } else {
                    response.sendRedirect("jsp/driver.jsp?error=Failed to register driver.");
                }
            } else {
                response.sendRedirect("jsp/driver.jsp?error=User registration failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/driver.jsp?error=" + e.getMessage());
        }
    }

    // **Hash password for security**
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}