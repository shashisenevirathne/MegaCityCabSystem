<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.mycompany.megacitycabsystemn.model.DatabaseConnection" %>
<%@ page import="java.util.*, com.mycompany.megacitycabsystemn.model.Ride" %>

<%
    // Simulating session (replace with actual session logic)
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp?error=Please login first!");
        return;
    }

    List<Ride> rides = new ArrayList<>();
    try (Connection con = DatabaseConnection.getConnection()) {
        String sql = "SELECT ride_id, customer_name, pickup_location, dropoff_location, fare FROM rides WHERE driver_username = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            rides.add(new Ride(rs.getInt("ride_id"), rs.getString("customer_name"), 
                rs.getString("pickup_location"), rs.getString("dropoff_location"), rs.getDouble("fare")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Welcome, <%= username %></h1>
        <h2>Your Ride History</h2>
        <table border="1">
            <tr>
                <th>Ride ID</th>
                <th>Customer Name</th>
                <th>Pickup</th>
                <th>Dropoff</th>
                <th>Fare</th>
            </tr>
            <% for (Ride ride : rides) { %>
                <tr>
                    <td><%= ride.getRideId() %></td>
                    <td><%= ride.getCustomerName() %></td>
                    <td><%= ride.getPickupLocation() %></td>
                    <td><%= ride.getDropoffLocation() %></td>
                    <td>$<%= ride.getFare() %></td>
                </tr>
            <% } %>
        </table>

        <a href="../LogoutServlet"><button>Logout</button></a>
    </div>
</body>
</html>
