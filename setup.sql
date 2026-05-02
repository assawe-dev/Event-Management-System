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
    Role NVARCHAR(20) NOT NULL
);

-- Seed some data for Events
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Annual Tech Conference', 'San Francisco, CA', '2025-10-15', 500, 450);
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Charity Gala', 'New York, NY', '2025-11-20', 200, 150);
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Web Dev Workshop', 'Remote', '2025-09-05', 100, 100);
INSERT INTO Events (EventName, Location, EventDate, Capacity, AvailableSeats) VALUES ('Networking Mixer', 'Austin, TX', '2025-12-12', 150, 120);

-- Seed some data for Users
INSERT INTO Users (Username, Password, Role) VALUES ('admin', 'admin123', 'Admin');
INSERT INTO Users (Username, Password, Role) VALUES ('user', 'user123', 'User');
INSERT INTO Users (Username, Password, Role) VALUES ('employee', 'emp123', 'Employee');
