<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.mycompany.megacitycabsystemn.model.DatabaseConnection" %>
<%@ page import="java.util.*, com.mycompany.megacitycabsystemn.model.User" %>

<%
    // Session Check (Redirect if not admin)
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp?error=Access Denied!");
        return;
    }

    List<User> users = new ArrayList<>();
    int totalBookings = 0;
    int totalDrivers = 0;

    try (Connection con = DatabaseConnection.getConnection()) {
        // Fetch all users
        String userQuery = "SELECT id, username, role FROM users";
        PreparedStatement userStmt = con.prepareStatement(userQuery);
        ResultSet rsUsers = userStmt.executeQuery();
        while (rsUsers.next()) {
            users.add(new User(rsUsers.getInt("id"), rsUsers.getString("username"), null, rsUsers.getString("role")));
        }

        // Fetch total bookings
        String bookingQuery = "SELECT COUNT(*) AS total FROM rides";
        PreparedStatement bookingStmt = con.prepareStatement(bookingQuery);
        ResultSet rsBookings = bookingStmt.executeQuery();
        if (rsBookings.next()) {
            totalBookings = rsBookings.getInt("total");
        }

        // Fetch total drivers
        String driverQuery = "SELECT COUNT(*) AS total FROM drivers";
        PreparedStatement driverStmt = con.prepareStatement(driverQuery);
        ResultSet rsDrivers = driverStmt.executeQuery();
        if (rsDrivers.next()) {
            totalDrivers = rsDrivers.getInt("total");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Admin Dashboard</h1>

        <div class="stats">
            <p><strong>Total Bookings:</strong> <%= totalBookings %></p>
            <p><strong>Total Drivers:</strong> <%= totalDrivers %></p>
        </div>

        <h2>Manage Users</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <% for (User user : users) { %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <% if (!user.getRole().equals("admin")) { %>
                            <a href="../DeleteUserServlet?id=<%= user.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
                        <% } %>
                    </td>
                </tr>
            <% } %>
        </table>

        <a href="../LogoutServlet"><button>Logout</button></a>
    </div>
</body>
</html>
