package com.mycompany.megacitycabsystemn.model;

public class Ride {
    private int rideId;
    private String customerName;
    private String pickupLocation;
    private String dropoffLocation;
    private double fare;

    public Ride(int rideId, String customerName, String pickupLocation, String dropoffLocation, double fare) {
        this.rideId = rideId;
        this.customerName = customerName;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.fare = fare;
    }

    public int getRideId() { return rideId; }
    public String getCustomerName() { return customerName; }
    public String getPickupLocation() { return pickupLocation; }
    public String getDropoffLocation() { return dropoffLocation; }
    public double getFare() { return fare; }
}
