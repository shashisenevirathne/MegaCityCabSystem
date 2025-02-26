CREATE DATABASE MegaCityCabDB;
USE MegaCityCabDB;

-- User Table
CREATE TABLE User (
    userID VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    userType ENUM('Admin', 'Driver', 'Customer') NOT NULL
);

-- Admin Table
CREATE TABLE Admin (
    adminID VARCHAR(50) PRIMARY KEY,
    userID VARCHAR(50),
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE
);

-- Driver Table
CREATE TABLE Driver (
    driverID VARCHAR(50) PRIMARY KEY,
    userID VARCHAR(50),
    driverName VARCHAR(100) NOT NULL,
    phoneNo VARCHAR(20) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE
);

-- Customer Table
CREATE TABLE Customer (
    customerID VARCHAR(50) PRIMARY KEY,
    userID VARCHAR(50),
    customerName VARCHAR(100) NOT NULL,
    customerAddress VARCHAR(255),
    customerPhoneNo VARCHAR(20) NOT NULL,
    customerEmail VARCHAR(100) UNIQUE,
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE
);

-- Cab Table
CREATE TABLE Cab (
    cabID VARCHAR(50) PRIMARY KEY,
    registrationNo VARCHAR(50) UNIQUE NOT NULL,
    model VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

-- BookingStatus Enumeration
CREATE TABLE BookingStatus (
    status ENUM('pending', 'confirmed', 'completed', 'cancelled') PRIMARY KEY
);

-- Booking Table
CREATE TABLE Booking (
    bookingID VARCHAR(50) PRIMARY KEY,
    customerID VARCHAR(50),
    driverID VARCHAR(50),
    pickupLocation VARCHAR(255) NOT NULL,
    dropupLocation VARCHAR(255) NOT NULL,
    phoneNo VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    bookingDate DATE NOT NULL,
    distance DOUBLE NOT NULL,
    status ENUM('pending', 'confirmed', 'completed', 'cancelled') NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE,
    FOREIGN KEY (driverID) REFERENCES Driver(driverID) ON DELETE SET NULL,
    FOREIGN KEY (status) REFERENCES BookingStatus(status)
);

-- Bill Table
CREATE TABLE Bill (
    billID VARCHAR(50) PRIMARY KEY,
    bookingID VARCHAR(50),
    fare DOUBLE NOT NULL,
    tax DOUBLE NOT NULL,
    discount DOUBLE DEFAULT 0.0,
    totalAmount DOUBLE NOT NULL,
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID) ON DELETE CASCADE
);
