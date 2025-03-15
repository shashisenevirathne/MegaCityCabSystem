package com.mycompany.megacitycabsystemn.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.mycompany.megacitycabsystemn.dao.UserDAO;
import com.mycompany.megacitycabsystemn.model.User;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        
        String password;
        if (username.equals("admin")) {
            password = request.getParameter("password");  // Admin password remains plain text
        } else {
            password = hashPassword(request.getParameter("password")); // Hash input password for normal users
        }

        UserDAO userDao = new UserDAO();
        User user = userDao.validateUser(username, password); // Validate user

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole()); // Store role

            // Role-based redirect
            if ("customer".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("jsp/booking.jsp");
            } else if ("driver".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("jsp/driverDashboard.jsp");
            } else if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("jsp/adminDashboard.jsp");
            } else {
                response.sendRedirect("jsp/login.jsp?error=Unknown role");
            }
        } else {
            response.sendRedirect("jsp/login.jsp?error=Invalid Credentials");
        }
    }

    // Hashing function using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
