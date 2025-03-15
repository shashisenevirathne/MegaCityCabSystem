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

@WebServlet("/RegisterCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String nic = request.getParameter("NIC");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = hashPassword(request.getParameter("password"));
        String rideType = request.getParameter("rideType");

        try (Connection con = DatabaseConnection.getConnection()) {
            // Insert into Users table
            String userQuery = "INSERT INTO users (username, password, role) VALUES (?, ?, 'customer')";
            PreparedStatement userStmt = con.prepareStatement(userQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, username);
            userStmt.setString(2, password);
            int userResult = userStmt.executeUpdate();

            if (userResult > 0) {
                // Get the generated user_id
                ResultSet rs = userStmt.getGeneratedKeys();
                int userId = 0;
                if (rs.next()) {
                    userId = rs.getInt(1);
                }

                // Insert into Customers table
                String customerQuery = "INSERT INTO customers (full_name, nic, email, phone, address, ride_type, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement customerStmt = con.prepareStatement(customerQuery);
                customerStmt.setString(1, fullName);
                customerStmt.setString(2, nic);
                customerStmt.setString(3, email);
                customerStmt.setString(4, phone);
                customerStmt.setString(5, address);
                customerStmt.setString(6, rideType);
                customerStmt.setInt(7, userId);
                
                int customerResult = customerStmt.executeUpdate();

                if (customerResult > 0) {
                    response.sendRedirect("jsp/login.jsp?success=Registration successful!");
                } else {
                    response.sendRedirect("jsp/register.jsp?error=Failed to register customer.");
                }
            } else {
                response.sendRedirect("jsp/register.jsp?error=User registration failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/register.jsp?error=Database error!");
        }
    }

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
