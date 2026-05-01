CREATE TABLE Events (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    TicketPrice DECIMAL(18, 2) NOT NULL
);

-- Seed some data
INSERT INTO Events (Name, EventDate, Location, TicketPrice) VALUES ('Annual Tech Conference', '2025-10-15', 'San Francisco, CA', 99.99);
INSERT INTO Events (Name, EventDate, Location, TicketPrice) VALUES ('Charity Gala', '2025-11-20', 'New York, NY', 50.00);
INSERT INTO Events (Name, EventDate, Location, TicketPrice) VALUES ('Web Dev Workshop', '2025-09-05', 'Remote', 0.00);
INSERT INTO Events (Name, EventDate, Location, TicketPrice) VALUES ('Networking Mixer', '2025-12-12', 'Austin, TX', 25.00);
