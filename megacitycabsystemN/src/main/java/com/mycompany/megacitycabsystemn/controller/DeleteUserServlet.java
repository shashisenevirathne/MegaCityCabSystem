package com.mycompany.megacitycabsystemn.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.megacitycabsystemn.model.DatabaseConnection;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id != null) {
            try (Connection con = DatabaseConnection.getConnection()) {
                String query = "DELETE FROM users WHERE id=?";
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(id));

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("jsp/adminDashboard.jsp?success=User deleted successfully!");
                } else {
                    response.sendRedirect("jsp/adminDashboard.jsp?error=User not found!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("jsp/adminDashboard.jsp?error=Database error!");
            }
        }
    }
}
