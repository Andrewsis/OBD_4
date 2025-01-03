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
