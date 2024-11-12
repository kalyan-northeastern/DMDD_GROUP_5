-- Drop all tables if they exist to avoid errors on re-run
DROP TABLE IF EXISTS CampaignTarget;
DROP TABLE IF EXISTS CustomerSupport;
DROP TABLE IF EXISTS OrderLine;
DROP TABLE IF EXISTS PackageCreation;
DROP TABLE IF EXISTS ProductSeller;
DROP TABLE IF EXISTS IndividualSeller;
DROP TABLE IF EXISTS FactorySupplier;
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS MooPackage;
DROP TABLE IF EXISTS LogisticsProvider;
DROP TABLE IF EXISTS PaymentProcessor;
DROP TABLE IF EXISTS QualityAssuranceTeam;
DROP TABLE IF EXISTS MarketingCampaign;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS MarketingPlatform;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Seller;
DROP TABLE IF EXISTS Admin;

-- Create the Mookit database
CREATE DATABASE Mookit;
USE Mookit;

-- Marketing Platform table
CREATE TABLE MarketingPlatform (
    PlatformID INT PRIMARY KEY IDENTITY(1,1),
    PlatformName NVARCHAR(100) NOT NULL,
    PlatformType NVARCHAR(50),
    CostStructure NVARCHAR(100),
    AdFormat NVARCHAR(50)
);

-- Marketing Campaign table
CREATE TABLE MarketingCampaign (
    CampaignID INT PRIMARY KEY IDENTITY(1,1),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TargetAudience NVARCHAR(100),
    CONSTRAINT chk_end_date_after_start_date CHECK (EndDate > StartDate)
);

-- Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Address NVARCHAR(255),
    Phone NVARCHAR(15),
    PlatformID INT,
    FOREIGN KEY (PlatformID) REFERENCES MarketingPlatform(PlatformID),
    CONSTRAINT chk_customer_phone_length CHECK (LEN(Phone) BETWEEN 7 AND 15)
);


-- Campaign Target table
CREATE TABLE CampaignTarget (
    CustomerID INT NOT NULL,
    CampaignID INT NOT NULL,
    PRIMARY KEY (CustomerID, CampaignID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CampaignID) REFERENCES MarketingCampaign(CampaignID)
);

-- Customer Support table
CREATE TABLE CustomerSupport (
    SupportID INT PRIMARY KEY IDENTITY(1,1),
    InquiryDate DATE NOT NULL,
    ResolutionStatus NVARCHAR(50),
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Quality Assurance Team table
CREATE TABLE QualityAssuranceTeam (
    QAID INT PRIMARY KEY IDENTITY(1,1),
    QAName NVARCHAR(100) NOT NULL,
    QARole NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(15)
);

-- Payment Processor table
CREATE TABLE PaymentProcessor (
    ProcessorID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    TransactionFee DECIMAL(10, 2),
    CONSTRAINT chk_transaction_fee_non_negative CHECK (TransactionFee >= 0)
);

-- Logistics Provider table
CREATE TABLE LogisticsProvider (
    ProviderID INT PRIMARY KEY IDENTITY(1,1),
    LP_Name NVARCHAR(100) NOT NULL,
    LP_ContactInfo NVARCHAR(100),
    ServiceArea NVARCHAR(100)
);

-- MooPackage table
CREATE TABLE MooPackage (
    PackageID INT PRIMARY KEY IDENTITY(1,1),
    PackageName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Price DECIMAL(10, 2),
    Availability NVARCHAR(50),
    QAID INT,
    FOREIGN KEY (QAID) REFERENCES QualityAssuranceTeam(QAID)
);


-- Order table
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status NVARCHAR(50),
    QAID INT NOT NULL,
    ProviderID INT NOT NULL,
    CustomerID INT NOT NULL,
    ProcessorID INT NOT NULL,
    FOREIGN KEY (QAID) REFERENCES QualityAssuranceTeam(QAID),
    FOREIGN KEY (ProviderID) REFERENCES LogisticsProvider(ProviderID),
    FOREIGN KEY (ProcessorID) REFERENCES PaymentProcessor(ProcessorID),
    CONSTRAINT chk_total_amount_positive CHECK (TotalAmount > 0)
);

-- OrderLine table
CREATE TABLE OrderLine (
    OrderID INT NOT NULL,
    PackageID INT NOT NULL,
    PRIMARY KEY (OrderID, PackageID),
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    FOREIGN KEY (PackageID) REFERENCES MooPackage(PackageID)
);

-- Product table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255),
    Description NVARCHAR(500),
    Price DECIMAL(10, 2),
    Category NVARCHAR(100)
);

-- Seller table
CREATE TABLE Seller (
    SellerID INT PRIMARY KEY IDENTITY(1,1),
    SellerName NVARCHAR(255),
    SellerContactInfo TEXT,
    Email NVARCHAR(255),
    ContactInfo NVARCHAR(255),
    City NVARCHAR(100)
);

-- Factory Supplier table
CREATE TABLE FactorySupplier (
    SupplierID INT PRIMARY KEY,
    FactoryName NVARCHAR(255),
    FactoryStreet NVARCHAR(255),
    FactoryCity NVARCHAR(100),
    FOREIGN KEY (SupplierID) REFERENCES Seller(SellerID)
);


-- Product Seller table
CREATE TABLE ProductSeller (
    SellerID INT,
    ProductID INT,
    ListedPrice DECIMAL(10, 2),
    StockQuantity INT,
    PRIMARY KEY (SellerID, ProductID),
    FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT chk_stock_quantity_non_negative CHECK (StockQuantity >= 0)
);

-- Individual Seller table
CREATE TABLE IndividualSeller (
    IndSellerID INT PRIMARY KEY,
    HouseStreet NVARCHAR(255),
    HouseCity NVARCHAR(100),
    HouseNumber NVARCHAR(50),
    FOREIGN KEY (IndSellerID) REFERENCES Seller(SellerID)
);


-- Admin table
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255),
    EmployeeID NVARCHAR(50)
);

-- Package Creation table
CREATE TABLE PackageCreation (
    CreationID INT PRIMARY KEY IDENTITY(1,1),
    PackageID INT NOT NULL,
    AdminID INT NOT NULL,
    ProductID INT NOT NULL,
    CreationDate DATE NOT NULL,
    CreationTime TIME NOT NULL,
    Description TEXT,
    FOREIGN KEY (PackageID) REFERENCES MooPackage(PackageID),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);