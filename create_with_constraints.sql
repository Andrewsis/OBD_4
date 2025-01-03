CREATE TABLE CarBrands (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL CHECK (LENGTH(Name) > 0)
);

CREATE TABLE CarStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL CHECK (LENGTH(Name) > 0)
);

CREATE TABLE CarModels (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL CHECK (LENGTH(Name) > 0)
);

CREATE TABLE Cars (
    Id INT PRIMARY KEY NOT NULL,
    BrandId INT NOT NULL,
    StatusId INT NOT NULL,
    ModelId INT NOT NULL,
    Colour VARCHAR(50) NOT NULL,
    VIN VARCHAR(17) NOT NULL UNIQUE,
    LicensePlate VARCHAR(50) NOT NULL,
    YearOfRelease DATE NOT NULL CHECK (YearOfRelease >= TO_DATE('1900-01-01', 'YYYY-MM-DD') AND YearOfRelease <= TO_DATE('2025-01-03', 'YYYY-MM-DD')),
    Tax FLOAT NOT NULL CHECK (Tax >= 0),
    Kilometrage FLOAT CHECK (Kilometrage >= 0),
    FOREIGN KEY (BrandId) REFERENCES CarBrands(Id),
    FOREIGN KEY (StatusId) REFERENCES CarStatuses(Id),
    FOREIGN KEY (ModelId) REFERENCES CarModels(Id)
);

CREATE OR REPLACE TRIGGER check_YearOfRelease_Cars
    BEFORE INSERT OR UPDATE ON Cars
    FOR EACH ROW
BEGIN
    IF :NEW.YearOfRelease >= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'RepairDate must be earlier than SYSDATE');
    ELSIF :NEW.YearOfRelease < TO_DATE('1900-01-01', 'YYYY-MM-DD') THEN
        RAISE_APPLICATION_ERROR(-20002, 'RepairDate must be later than 1900-01-01');
    END IF;
END;
/

CREATE TABLE Repairs (
    Id INT PRIMARY KEY NOT NULL,
    RepairDate DATE NOT NULL,
    Description VARCHAR(255)
);

CREATE OR REPLACE TRIGGER check_RepairDate_Repairs
    BEFORE INSERT OR UPDATE ON Repairs
    FOR EACH ROW
    BEGIN
    	IF :NEW.RepairDate >= SYSDATE THEN
    		RAISE_APPLICATION_ERROR(-20001, 'RepairDate must be earlier than SYSDATE');
		END IF;
	END;
/

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
    Longitude VARCHAR(50) NOT NULL CHECK (Longitude BETWEEN '-180' AND '180'),
    Latitude VARCHAR(50) NOT NULL CHECK (Latitude BETWEEN '-90' AND '90')
);

CREATE TABLE Customers (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Rating FLOAT CHECK (Rating BETWEEN 0 AND 5)
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
    DrivingExpirience INT NOT NULL CHECK (DrivingExpirience >= 0),
    Rating INT CHECK (Rating BETWEEN 0 AND 5)
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
    Reward FLOAT NOT NULL CHECK (Reward > 0),
    OrdersCount INT NOT NULL CHECK (OrdersCount >= 0)
);

CREATE OR REPLACE TRIGGER check_start_end_dates_Tasks
BEFORE INSERT OR UPDATE ON Tasks
FOR EACH ROW
BEGIN
    IF :NEW.StartDate >= :NEW.EndDate THEN
        RAISE_APPLICATION_ERROR(-20001, 'StartDate must be earlier than EndDate');
    END IF;
END;
/

CREATE TABLE DriverTasks (
    DriverId INT NOT NULL,
    TaskId INT NOT NULL,
    StatusId INT NOT NULL,
    PRIMARY KEY(DriverId, TaskId),
    FOREIGN KEY (DriverId) REFERENCES Drivers(Id),
    FOREIGN KEY (TaskId) REFERENCES Tasks(Id),
    FOREIGN KEY (StatusId) REFERENCES TaskStatuses(Id)
);

CREATE TABLE DriverStatuses (
    Id INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    Id INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(20) NOT NULL CHECK (LENGTH(FirstName) <= 20),
    LastName VARCHAR(20) NOT NULL CHECK (LENGTH(LastName) <= 20),
    MiddleName VARCHAR(20) CHECK (LENGTH(MiddleName) <= 20),
    Phone VARCHAR(20) NOT NULL,
    CreditCard VARCHAR(20),
    Email VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL CHECK (LENGTH(Password) >= 8),
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
    Days INT NOT NULL CHECK (Days > 0),
    FOREIGN KEY (DriverId) REFERENCES Drivers(Id),
    FOREIGN KEY (CarId) REFERENCES Cars(Id),
    FOREIGN KEY (StatusId) REFERENCES RentStatuses(Id)
);

CREATE OR REPLACE TRIGGER check_StartDate_Rents
    BEFORE INSERT OR UPDATE ON Rents
    FOR EACH ROW
    BEGIN
    	IF :NEW.StartDate >= SYSDATE THEN
    		RAISE_APPLICATION_ERROR(-20001, 'StartDate must be earlier than SYSDATE');
		END IF;
	END;
/
    
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
    PassangerCount INT CHECK (PassangerCount >= 0),
    Distance FLOAT,
    PaymentTypeId INT NOT NULL,
    TotalAmount FLOAT CHECK (TotalAmount >= 0),
    AggregatorAmount FLOAT CHECK (AggregatorAmount >= 0),
    DriverAmount FLOAT CHECK (DriverAmount >= 0),
    DriverRating FLOAT CHECK (DriverRating BETWEEN 0 AND 5),
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (RentId) REFERENCES Rents(Id),
    FOREIGN KEY (StatusId) REFERENCES OrderStatuses(Id),
    FOREIGN KEY (PickupAddressId) REFERENCES Addresses(Id),
    FOREIGN KEY (DropoffAddressId) REFERENCES Addresses(Id),
    FOREIGN KEY (PaymentTypeId) REFERENCES PaymentTypeStatuses(Id)
);
