CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    EventDate DATETIME NOT NULL,
    Capacity INT NOT NULL,
    AvailableSeats INT NOT NULL
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) NOT NULL
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    EventID INT NOT NULL,
    BookingDate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- Seed some data for Events
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Annual Tech Conference', 'San Francisco, CA', '2025-10-15', 500, 450);
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Charity Gala', 'New York, NY', '2025-11-20', 200, 150);
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Web Dev Workshop', 'Remote', '2025-09-05', 100, 100);
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Networking Mixer', 'Austin, TX', '2025-12-12', 150, 120);

-- Seed some data for Users
INSERT INTO Users (Username, Password, FullName, Role) VALUES ('admin', 'admin123', 'System Administrator', 'Admin');
INSERT INTO Users (Username, Password, FullName, Role) VALUES ('user', 'user123', 'John Doe', 'User');
INSERT INTO Users (Username, Password, FullName, Role) VALUES ('employee', 'emp123', 'Jane Smith', 'Employee');
