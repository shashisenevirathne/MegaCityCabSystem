package com.mycompany.megacitycabsystemn.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.megacitycabsystemn.dao.BookingDAO;
import com.mycompany.megacitycabsystemn.model.Booking;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookingDAO bookingDao = new BookingDAO();
        List<Booking> bookings = bookingDao.getAllBookings();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("report.jsp").forward(request, response);
    }
}