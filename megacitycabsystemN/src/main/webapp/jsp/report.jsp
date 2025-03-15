<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.megacitycabsystemn.dao.BookingDAO" %>
<%@ page import="com.mycompany.megacitycabsystemn.model.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Reports</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Booking Reports</h1>
        <table border="1">
            <tr>
                <th>Customer Name</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Destination</th>
                <th>Fare</th>
            </tr>
            <% 
                BookingDAO bookingDao = new BookingDAO();
                List<Booking> bookings = bookingDao.getAllBookings();
                if (bookings != null && !bookings.isEmpty()) {
                    for (Booking b : bookings) { %>
                    <tr>
                        <td><%= b.getCustomerName() %></td>
                        <td><%= b.getAddress() %></td>
                        <td><%= b.getPhone() %></td>
                        <td><%= b.getDestination() %></td>
                        <td><%= b.getFare() %></td>
                    </tr>
                <% } 
                } else { %>
                    <tr><td colspan="5">No bookings found.</td></tr>
                <% } %>
        </table>
    </div>
</body>
</html>
