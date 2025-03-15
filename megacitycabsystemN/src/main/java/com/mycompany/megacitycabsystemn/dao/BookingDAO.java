package com.mycompany.megacitycabsystemn.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.mycompany.megacitycabsystemn.model.DatabaseConnection;
import com.mycompany.megacitycabsystemn.model.Booking;

public class BookingDAO {
    public boolean addBooking(Booking booking) {
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "INSERT INTO bookings (customer_name, address, phone, destination, fare) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, booking.getCustomerName());
            stmt.setString(2, booking.getAddress());
            stmt.setString(3, booking.getPhone());
            stmt.setString(4, booking.getDestination());
            stmt.setDouble(5, booking.getFare());
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT * FROM bookings";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getInt("id"),
                    rs.getString("customer_name"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getString("destination"),
                    rs.getDouble("fare")
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}
