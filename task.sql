CREATE TABLE CarBrands (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE CarStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE CarModels (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Cars (
    Id INT PRIMARY KEY NOT NULL,
    BrandId INT NOT NULL,
    StatusId INT NOT NULL,
    ModelId INT NOT NULL,
    Colour VARCHAR(50) NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    LicensePlate VARCHAR(50) NOT NULL,
    YearOfRelease DATE NOT NULL,
    Tax FLOAT NOT NULL,
    Kilometrage FLOAT,
    FOREIGN KEY (BrandId) REFERENCES CarBrands(Id),
    FOREIGN KEY (StatusId) REFERENCES CarStatuses(Id),
    FOREIGN KEY (ModelId) REFERENCES CarModels(Id)
);

CREATE TABLE Repairs (
    Id INT PRIMARY KEY NOT NULL,
    RepairDate DATE NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE CarRepairs (
    CarId INT NOT NULL,
    RepairId INT NOT NULL,
    PRIMARY KEY (CarId, RepairId),
    FOREIGN KEY (CarId) REFERENCES Cars(Id),
    FOREIGN KEY (RepairId) REFERENCES Repairs(Id)
);

CREATE TABLE Addresses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Longitude VARCHAR(50) NOT NULL,
    Latitude VARCHAR(50) NOT NULL
);

CREATE TABLE Customers (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Rating FLOAT
);

CREATE TABLE OrderOptions (
    OrderId INT NOT NULL,
    ServiceId INT NOT NULL,
    PRIMARY KEY (OrderId, ServiceId)
);

CREATE TABLE Options (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE PaymentTypeStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE RentStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE OrderStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Drivers (
    Id INT PRIMARY KEY NOT NULL,
    UserId INT NOT NULL, 
    StatusId INT NOT NULL,
    DrivingExpirience INT NOT NULL,
    Rating INT
);

CREATE TABLE TaskStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Tasks (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    StartDate TIMESTAMP NOT NULL,
    EndDate TIMESTAMP NOT NULL,
    Reward FLOAT NOT NULL,
    OrdersCount INT NOT NULL
);

CREATE TABLE DriverTasks (
    DriverId INT NOT NULL,
    TaskId INT NOT NULL,
    StatusId INT NOT NULL,
    PRIMARY KEY(DriverId, TaskId),
    FOREIGN KEY (DriverId) REFERENCES Drivers(Id),
    FOREIGN KEY (TaskId) REFERENCES TaskStatuses(Id),
    FOREIGN KEY (TaskId) REFERENCES Tasks(Id)
);

CREATE TABLE DriverStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    Id INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    MiddleName VARCHAR(20),
    Phone VARCHAR(20) NOT NULL,
    CreditCard VARCHAR(20),
    Email VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    PassportSeries VARCHAR(4) NOT NULL,
    PassportNumber VARCHAR(20) NOT NULL,
    DateOfEmployment DATE
);

CREATE TABLE Rents (
    Id INT PRIMARY KEY NOT NULL,
    DriverId INT NOT NULL,
    CarId INT NOT NULL,
    StatusId INT NOT NULL,
    StartDate DATE NOT NULL,
    Days INT NOT NULL,
    FOREIGN KEY (DriverId) REFERENCES Drivers(Id),
    FOREIGN KEY (CarId) REFERENCES Cars(Id),
    FOREIGN KEY (StatusId) REFERENCES RentStatuses(Id)
);

CREATE TABLE Orders (
    Id INT PRIMARY KEY NOT NULL,
    CustomerId INT NOT NULL,
    RentId INT NOT NULL,
    StatusId INT NOT NULL,
    PickupAddressId INT,
    DropoffAddressId INT,
    PickupDatetime TIMESTAMP,
    DropoffDatetime TIMESTAMP,
    TripTimeSecs INT,
    PassangerCount INT,
    Distance FLOAT,
    PaymentTypeId INT NOT NULL,
    TotalAmount FLOAT,
    AggregatorAmount FLOAT,
    DriverAmount FLOAT,
    DriverRating FLOAT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (RentId) REFERENCES Rents(Id),
    FOREIGN KEY (StatusId) REFERENCES OrderStatuses(Id),
    FOREIGN KEY (PickupAddressId) REFERENCES Addresses(Id),
    FOREIGN KEY (DropoffAddressId) REFERENCES Addresses(Id),
    FOREIGN KEY (PaymentTypeId) REFERENCES PaymentTypeStatuses(Id)
);


INSERT INTO Users 
VALUES (1, 'Andrew', 'Kruglykh', 'Vladimirovich', '+38012345678', '124125125', 'mock1@gmail.com', 'mockPassword1', 'ABCD', '123124', TO_DATE('01-01-2001', 'DD-MM-YYYY'));
INSERT INTO Users 
VALUES (2, 'Jon', 'Snow', 'Targaryen', '+12345678901', '987654321', 'jonsnow@nightwatch.com', 'stark123', 'ADBC', '234567', TO_DATE('12-12-1990', 'DD-MM-YYYY'));
INSERT INTO Users 
VALUES (3, 'Daenerys', 'Targaryen', 'Stormborn', '+19876543210', '567890123', 'daenerys@dragonqueen.com', 'fireandblood', 'ABC', '345678', TO_DATE('03-03-1985', 'DD-MM-YYYY'));

INSERT INTO CarBrands
VALUES (1, 'Toyota'); 
INSERT INTO CarBrands
VALUES (2, 'Ford');
INSERT INTO CarBrands
VALUES (3, 'BMW');

INSERT INTO CarStatuses
VALUES (1, 'Available'); 
INSERT INTO CarStatuses
VALUES (2, 'In Repair'); 
INSERT INTO CarStatuses
VALUES (3, 'Rented');

INSERT INTO CarModels
VALUES (1, 'Corolla');
INSERT INTO CarModels
VALUES (2, 'Focus');
INSERT INTO CarModels
VALUES (3, 'X5');
   
INSERT INTO Cars
VALUES (1, 1, 1, 1, 'Red', '1NXBR32E54Z204672', 'AA123BB', TO_DATE('01-01-2005', 'DD-MM-YYYY'), 500, 100000);
INSERT INTO Cars
VALUES (2, 2, 1, 2, 'Blue', '1FAFP404X8F424080', 'BB456CC', TO_DATE('10-06-2008', 'DD-MM-YYYY'), 400, 50000);
INSERT INTO Cars
VALUES (3, 3, 2, 3, 'Black', 'WBA3B1C56FP340582', 'CC789DD', TO_DATE('15-09-2020', 'DD-MM-YYYY'), 600, 20000);


UPDATE Cars
SET StatusId = 3
WHERE Id = 2;

UPDATE Cars
SET Colour = 'Green'
WHERE Id = 1;


DELETE FROM Cars
WHERE Id = 3;

DELETE FROM Cars
WHERE StatusId = 2;


CREATE SEQUENCE seq_carbrands_id
START WITH 4
INCREMENT BY 1;

CREATE SEQUENCE seq_cars_id
START WITH 4
INCREMENT BY 1;

INSERT INTO CarBrands
VALUES (seq_carbrands_id.NEXTVAL, 'Audi');
INSERT INTO CarBrands
VALUES	(seq_carbrands_id.NEXTVAL, 'Mercedes');

INSERT INTO Cars
VALUES (seq_cars_id.NEXTVAL, 4, 1, 1, 'White', 'WAUZC68E78A223657', 'DD123EE', TO_DATE('10-05-2017', 'DD-MM-YYYY'), 550, 80000);


CREATE VIEW CarDetails AS
SELECT
    Cars.Id AS CarId,
    CarBrands.Name AS BrandName,
    CarModels.Name AS ModelName,
    CarStatuses.Name AS StatusName,
    Cars.Colour AS Colour,
    Cars.VIN AS VIN,
    Cars.LicensePlate AS LicensePlate,
    Cars.YearOfRelease AS YearOfRelease,
    Cars.Tax AS Tax,
    Cars.Kilometrage AS Kilometrage
FROM
    Cars
JOIN
    CarBrands ON Cars.BrandId = CarBrands.Id
JOIN
    CarModels ON Cars.ModelId = CarModels.Id
JOIN
    CarStatuses ON Cars.StatusId = CarStatuses.Id;

SELECT * FROM CarDetails;
