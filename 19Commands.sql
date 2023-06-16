CREATE DATABASE Group3_Phase1;
GO

USE Group3_Phase1;



----------------------------------------------------------------
-- Create the Users table
CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  Name VARCHAR(50),
  Phone VARCHAR(15),
  Email VARCHAR(50),
  Role VARCHAR(20)
);

-- Create the Property table with the UserID column
CREATE TABLE Property (
  PropertyID INT PRIMARY KEY,
  UserID INT,
  Address VARCHAR(100),
  Neighborhood VARCHAR(50),
  SquareFeet INT,
  ParkingGarage BIT,
  PublicTransport BIT,
  FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create the Workspace table
CREATE TABLE Workspace (
  WorkspaceID INT PRIMARY KEY,
  PropertyID INT,
  Type VARCHAR(50),
  Capacity INT,
  SmokingAllowed BIT,
  AvailabilityDate DATE,
  LeaseTerm VARCHAR(20),
  Price DECIMAL(10, 2),
  FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);



-------------------------------------------------------------------------------
-- Insert data into the Users table
INSERT INTO Users (UserID, Name, Phone, Email, Role)
VALUES
  (1, 'CJ Apolina', '825-561-1051', 'CJApolinar@gmail.com', 'Owner'),
  (2, 'Nyajuol', '825-561-1052', 'Nyajuol@gmail.com', 'Owner'),
  (3, 'Yazan Baker', '825-561-1053', 'YazanBaker@gmail.com', 'Owner'),
  (4, 'Ahmad Baker', '555-123-4567', 'AhmadBakere@gmail.com', 'Owner');
-------------------------------------------------------------------------------
INSERT INTO Property (PropertyID, UserID, Address, Neighborhood, SquareFeet, ParkingGarage, PublicTransport)
VALUES
  (1, 1, '226-12th Ave SE', 'Downtown', 1000, 1, 1),
  (2, 1, '286-7th Ave NE', 'Northeast', 1500, 0, 1),
  (3, 2, '225 11 ave SW', 'NorthWest', 2000, 1, 0);

-------------------------------------------------------------------------------

-- Insert data into the Workspace table
INSERT INTO Workspace (WorkspaceID, PropertyID, Type, Capacity, SmokingAllowed, AvailabilityDate, LeaseTerm, Price)
VALUES
  (1, 1, 'Meeting Room', 10, 0, '2023-06-05', 'Day', 50),
  (2, 1, 'Private Room', 4, 1, '2023-06-05', 'Week', 100),
  (3, 2, 'Desk', 1, 0, '2023-06-05', 'Month', 20),
  (4, 2, 'Meeting Room', 15, 1, '2023-06-05', 'Day', 75),
  (5, 3, 'Meeting Room', 8, 0, '2023-06-10', 'Day', 80),
  (6, 3, 'Private Office', 1, 0, '2023-06-10', 'Month', 500);





----------------------------------------------------user stories-----------------
1)
-- Insert a new user
INSERT INTO Users (UserID, Name, Phone, Email, Role)
VALUES (5, 'Khaled Joe', '558-153-4557', 'KhaledJoe@gmail.com', 'Owner');


---------------------------------------------------------------------------------

2)
-- Insert a new property
INSERT INTO Property (PropertyID, Address, Neighborhood, SquareFeet, ParkingGarage, PublicTransport)
VALUES (4, '225 11 ave SW', 'NorthWest', 2000, 1, 0);


---------------------------------------------------------------------------------
3)
-- Insert workspaces for a property
INSERT INTO Workspace (WorkspaceID, PropertyID, Type, Capacity, SmokingAllowed, AvailabilityDate, LeaseTerm, Price)
VALUES
  (7, 3, 'Meeting Room', 8, 0, '2023-06-10', 'Day', 80),
  (8, 3, 'Private Office', 1, 0, '2023-06-10', 'Month', 500);

-----------------------------------------------------------------------
4)

-- Update property information
UPDATE Property
SET Neighborhood = 'Eastside'
WHERE PropertyID = 3;

-- Update workspace information
UPDATE Workspace
SET Price = 90
WHERE WorkspaceID = 5;

-----------------------------------------------------------------------

5) Make it last command so it doesn't effect other commands!
-- Delete a property
DELETE FROM Property
WHERE PropertyID = 3;

-- Delete a workspace
DELETE FROM Workspace
WHERE WorkspaceID = 5;

-----------------------------------------------------------------------
6)
-- Search workspaces by neighborhood and capacity
SELECT *
FROM Workspace w
INNER JOIN Property p ON w.PropertyID = p.PropertyID
WHERE p.Neighborhood = 'Downtown' AND w.Capacity >= 10;

-----------------------------------------------------------------------

7)
-- View workspace details
SELECT *
FROM Workspace
WHERE WorkspaceID = 6;

-----------------------------------------------------------------------
8)
-- Show property owner's name, phone and email
SELECT u.Name AS OwnerName, u.Phone AS OwnerPhone, u.Email AS OwnerEmail
FROM Users u
JOIN Property p ON u.UserID = p.UserID
JOIN Workspace w ON p.PropertyID = w.PropertyID
WHERE w.WorkspaceID = 1;


----------------------------------------------------------------
9) show all workspaces and who owns them
SELECT w.WorkspaceID, w.Type, w.Capacity, w.SmokingAllowed, w.AvailabilityDate, w.LeaseTerm, w.Price, u.Name AS OwnerName, u.Phone AS OwnerPhone, u.Email AS OwnerEmail
FROM Workspace w
JOIN Property p ON w.PropertyID = p.PropertyID
JOIN Users u ON p.UserID = u.UserID;

----------------------------------------------------------------
10)
As a coworker, I can search for workspaces with a specific seating capacity.

SELECT *
FROM Workspace
WHERE Capacity >= 10;

----------------------------------------------------------------
11)
As a coworker, I can search for workspaces that allow smoking.

SELECT *
FROM Workspace
WHERE SmokingAllowed = 1;


----------------------------------------------------------------
12)
As an owner, I can update the availability date of a workspace.

UPDATE Workspace
SET AvailabilityDate = '2023-06-20'
WHERE WorkspaceID = 1;

----------------------------------------------------------------

13) Be careful before deleting!:
As an owner, I can delete a property and all associated workspaces.

DELETE FROM Property
WHERE PropertyID = 1;

----------------------------------------------------------------

14)
As a coworker, I can search for workspaces that have parking available.

SELECT *
FROM Workspace w
JOIN Property p ON w.PropertyID = p.PropertyID
WHERE p.ParkingGarage = 1;
----------------------------------------------------------------

15)
As an owner, I can update the square footage of a property.

UPDATE Property
SET SquareFeet = 1200
WHERE PropertyID = 2;

----------------------------------------------------------------

16) As a coworker, I can search for workspaces with a specific lease term.

SELECT *
FROM Workspace
WHERE LeaseTerm = 'Month';

----------------------------------------------------------------

17) 
As a coworker, I can search for workspaces within a specific neighborhood and with a certain seating capacity.

SELECT *
FROM Workspace w
JOIN Property p ON w.PropertyID = p.PropertyID
WHERE p.Neighborhood = 'Northeast' AND w.Capacity >= 5;

----------------------------------------------------------------

18)
As an owner, I can update the price of a workspace.

UPDATE Workspace
SET Price = 80
WHERE WorkspaceID = 2;
----------------------------------------------------------------
19)
As a coworker, I can search for workspaces that are reachable by public transportation.

SELECT *
FROM Workspace w
JOIN Property p ON w.PropertyID = p.PropertyID
WHERE p.PublicTransport = 1;
