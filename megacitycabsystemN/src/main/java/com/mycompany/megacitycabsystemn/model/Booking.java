package com.mycompany.megacitycabsystemn.model;

public class Booking {
    private int id;
    private String customerName;
    private String address;
    private String phone;
    private String destination;
    private double fare;

    // Constructor for fetching data from the database (with ID)
    public Booking(int id, String customerName, String address, String phone, String destination, double fare) {
        this.id = id;
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.destination = destination;
        this.fare = fare;
    }

    // ✅ Fixed Constructor for new bookings (without ID)
    public Booking(String customerName, String address, String phone, String destination, double fare) {
        this.customerName = customerName;
        this.address = address;
        this.phone = phone;
        this.destination = destination;
        this.fare = fare;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }
}
