USE jewelry;

-- Table 1: Master
CREATE TABLE Master
(
    MasterID   INT PRIMARY KEY AUTO_INCREMENT,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NOT NULL,
    FatherName VARCHAR(50)
);
-- Table 2: Customer
CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name        VARCHAR(100) NOT NULL,
    Email       VARCHAR(255)
);
-- Table 3: Product
CREATE TABLE Product
(
    ProductID      INT PRIMARY KEY AUTO_INCREMENT,
    Title       VARCHAR(255) NOT NULL,
    MasterID    INT NOT NULL,
    CustomerID INT NOT NULL,
    FOREIGN KEY (MasterID) REFERENCES Master (MasterID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);
