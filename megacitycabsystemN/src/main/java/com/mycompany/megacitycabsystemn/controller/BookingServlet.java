package com.mycompany.megacitycabsystemn.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.megacitycabsystemn.dao.BookingDAO;
import com.mycompany.megacitycabsystemn.model.Booking;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String destination = request.getParameter("destination");
        double fare = Double.parseDouble(request.getParameter("fare"));

        Booking booking = new Booking(name, address, phone, destination, fare);
        BookingDAO bookingDao = new BookingDAO();

        if (bookingDao.addBooking(booking)) {
            response.sendRedirect("jsp/report.jsp");
        } else {
            response.sendRedirect("jsp/booking.jsp?error=Failed to add booking");
        }
    }
}
