CREATE TABLE IF NOT EXISTS Events (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    EventDate TEXT NOT NULL,
    Location TEXT NOT NULL
);

-- Seed some data
INSERT INTO Events (Name, EventDate, Location) VALUES ('Annual Tech Conference', '2025-10-15', 'San Francisco, CA');
INSERT INTO Events (Name, EventDate, Location) VALUES ('Charity Gala', '2025-11-20', 'New York, NY');
INSERT INTO Events (Name, EventDate, Location) VALUES ('Web Dev Workshop', '2025-09-05', 'Remote');
INSERT INTO Events (Name, EventDate, Location) VALUES ('Networking Mixer', '2025-12-12', 'Austin, TX');
