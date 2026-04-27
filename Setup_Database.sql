-- ===== COURIER TRACKING SYSTEM DATABASE SETUP =====

-- Create Users Table for Authentication
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Role NVARCHAR(10) NOT NULL DEFAULT 'user',
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Couriers Table for Tracking
CREATE TABLE Couriers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TrackingNumber NVARCHAR(50) UNIQUE NOT NULL,
    SenderName NVARCHAR(100) NOT NULL,
    SenderPhone NVARCHAR(20) NOT NULL,
    ReceiverName NVARCHAR(100) NOT NULL,
    ReceiverPhone NVARCHAR(20) NOT NULL,
    Origin NVARCHAR(100) NOT NULL,
    Destination NVARCHAR(100) NOT NULL,
    Weight DECIMAL(10, 2) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    Stage INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Insert sample users for testing
INSERT INTO Users (Username, Password, Role) VALUES ('admin', 'admin123', 'admin');
INSERT INTO Users (Username, Password, Role) VALUES ('user1', 'password1', 'user');
INSERT INTO Users (Username, Password, Role) VALUES ('user2', 'password2', 'user');

-- Insert sample courier tracking data
INSERT INTO Couriers (TrackingNumber, SenderName, SenderPhone, ReceiverName, ReceiverPhone, Origin, Destination, Weight, Status, Stage) 
VALUES ('CT123456', 'Ravi Sharma', '+91 98765 43210', 'Priya Patel', '+91 91234 56789', 'Mumbai', 'Delhi', 2.5, 'In Transit', 2);

INSERT INTO Couriers (TrackingNumber, SenderName, SenderPhone, ReceiverName, ReceiverPhone, Origin, Destination, Weight, Status, Stage) 
VALUES ('CT654321', 'Amit Kumar', '+91 87654 32109', 'Neha Singh', '+91 98765 43210', 'Bangalore', 'Chennai', 1.8, 'Out for Delivery', 4);

INSERT INTO Couriers (TrackingNumber, SenderName, SenderPhone, ReceiverName, ReceiverPhone, Origin, Destination, Weight, Status, Stage) 
VALUES ('CT999000', 'Vikram Desai', '+91 76543 21098', 'Anjali Verma', '+91 87654 32109', 'Pune', 'Hyderabad', 3.2, 'Delivered', 5);

INSERT INTO Couriers (TrackingNumber, SenderName, SenderPhone, ReceiverName, ReceiverPhone, Origin, Destination, Weight, Status, Stage) 
VALUES ('CT111222', 'Suresh Gupta', '+91 65432 10987', 'Isha Reddy', '+91 76543 21098', 'Delhi', 'Kolkata', 1.5, 'Pickup', 0);

INSERT INTO Couriers (TrackingNumber, SenderName, SenderPhone, ReceiverName, ReceiverPhone, Origin, Destination, Weight, Status, Stage) 
VALUES ('CT333444', 'Rohan Patel', '+91 54321 09876', 'Maya Kapoor', '+91 65432 10987', 'Chennai', 'Mumbai', 2.1, 'Parcel Hub', 1);

-- Create indexes for faster lookups
CREATE INDEX IX_TrackingNumber ON Couriers(TrackingNumber);
CREATE INDEX IX_Username ON Users(Username);
