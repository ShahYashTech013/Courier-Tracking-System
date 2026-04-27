# COURIER TRACKING SYSTEM - COMPLETE SETUP GUIDE

## ✅ System Overview
Your Courier Tracking System is now **fully functional** with:
- User Authentication (Login/Register)
- Admin Dashboard with Courier Management
- User Dashboard with Tracking
- Real-time Database Integration

---

## 🗄️ STEP 1: Set Up Database

### Run the SQL Setup Script
1. **Open SQL Server Management Studio** or **SQL Server Object Explorer** in Visual Studio
2. Connect to: `(localdb)\mssqllocaldb`
3. **Right-click** on `Databases` → **New Database** → Name it `CourierDB`
4. **Right-click** on `CourierDB` → **New Query**
5. **Copy & Paste the SQL below** and click Execute:

```sql
-- Create Users Table
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    Role NVARCHAR(10) NOT NULL DEFAULT 'user',
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Couriers Table
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

-- Insert Sample Users
INSERT INTO Users (Username, Password, Role) VALUES ('admin', 'admin123', 'admin');
INSERT INTO Users (Username, Password, Role) VALUES ('user1', 'password1', 'user');
INSERT INTO Users (Username, Password, Role) VALUES ('user2', 'password2', 'user');

-- Insert Sample Couriers
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

-- Create Indexes
CREATE INDEX IX_TrackingNumber ON Couriers(TrackingNumber);
CREATE INDEX IX_Username ON Users(Username);
```

✅ You should see: **Command(s) completed successfully**

---

## 🔐 STEP 2: Test Login System

### Restart the Application
1. **Stop Debugging** in Visual Studio (Shift+F5)
2. **Start Debugging** (F5)
3. Navigate to: `https://localhost:44338/`

### Test Credentials

| Page | Username | Password | Role |
|------|----------|----------|------|
| Admin | `admin` | `admin123` | Administrator |
| User 1 | `user1` | `password1` | Regular User |
| User 2 | `user2` | `password2` | Regular User |

---

## 📦 STEP 3: Admin Dashboard - Add Courier

1. **Login** with `admin` / `admin123`
2. Click **"Add Courier"** in the sidebar
3. Fill in the form:
   - Sender Name: `Ravi Sharma`
   - Sender Phone: `+91 98765 43210`
   - Receiver Name: `Priya Patel`
   - Receiver Phone: `+91 91234 56789`
   - Origin City: `Mumbai`
   - Destination City: `Delhi`
   - Weight (kg): `2.5`
   - Status: `Pickup`
4. Click **"Generate Tracking ID & Add"**
5. ✅ You'll see: **✅ Courier added successfully! Tracking ID: CT[XXXXX]**

---

## 🔄 STEP 4: Admin Dashboard - Update Status

1. Click **"Update Status"** in the sidebar
2. Enter a Tracking ID (e.g., `CT123456`)
3. Select new status from dropdown (e.g., `In Transit`)
4. Click **"Update Status"**
5. ✅ Status will be updated in the database

---

## 👤 STEP 5: User Dashboard - Track Shipment

1. **Logout** from Admin account
2. **Login** as user: `user1` / `password1`
3. Enter a Tracking ID (e.g., `CT123456`)
4. Click **"Track"**
5. ✅ See real-time shipment details and tracking stages

---

## 🏠 STEP 6: Home Page - Public Tracking

1. Go to `https://localhost:44338/Default.aspx` (or just Home)
2. Scroll to **"🔍 Track Your Shipment"** section
3. Enter a Tracking ID (e.g., `CT123456`)
4. Click **"Track"**
5. ✅ See tracking status even without login

---

## 📋 Available Test Tracking IDs

```
CT123456 - In Transit (Mumbai → Delhi)
CT654321 - Out for Delivery (Bangalore → Chennai)
CT999000 - Delivered (Pune → Hyderabad)
CT111222 - Pickup (Delhi → Kolkata)
CT333444 - Parcel Hub (Chennai → Mumbai)
```

---

## 🔧 System Architecture

### Files Created/Updated:
1. **Auth.aspx** - Login & Register page
2. **Auth.aspx.cs** - Database authentication
3. **AdminDashboard.aspx** - Admin interface
4. **AdminDashboard.aspx.cs** - Add/Update courier logic
5. **UserDashboard.aspx** - User tracking page
6. **UserDashboard.aspx.cs** - Fetch shipment data
7. **Default.aspx** - Home page with public tracking
8. **Default.aspx.cs** - Tracking WebMethod
9. **Setup_Database.sql** - Database schema
10. **Web.config** - Connection strings & routing

### Database Flow:
```
Admin adds Courier → Stored in SQL Server
User enters Tracking ID → Query Database → Display Status
```

---

## ⚠️ Troubleshooting

### Error: "Invalid object name 'Users'"
- Run the SQL setup script again
- Verify CourierDB exists with tables created

### 404 Error on Login
- Ensure URL is `https://localhost:44338/Auth.aspx` (with .aspx extension)
- Rebuild solution (Ctrl+Shift+B)

### Tracking ID not found
- Verify you're using exact Tracking IDs from the database
- Check capitalization (system converts to uppercase automatically)

---

## ✨ Features Implemented

✅ User Registration & Login with Password  
✅ Admin-only Dashboard Access  
✅ Add New Courier with Auto-generated Tracking ID  
✅ Update Shipment Status (6 stages)  
✅ Real-time Database Integration  
✅ Public Tracking (No login required)  
✅ Role-based Access Control  
✅ Responsive UI Design  
✅ SQL Server LocalDB Integration  

---

## 🚀 Next Steps (Optional)

- [ ] Add password hashing for security
- [ ] Add email notifications
- [ ] Implement SMS alerts
- [ ] Add payment gateway
- [ ] Create mobile app API
- [ ] Add admin analytics dashboard

---

**System Status: ✅ FULLY FUNCTIONAL**

Your Courier Tracking System is ready to use!