USE Mookit;

-- Insert data into MarketingPlatform
INSERT INTO MarketingPlatform (PlatformName, PlatformType, CostStructure, AdFormat)
VALUES 
('Facebook Ads', 'Social Media', 'Cost-per-click', 'Image/Video'),
('Google Ads', 'Search Engine', 'Cost-per-click', 'Text/Image'),
('Instagram Ads', 'Social Media', 'Cost-per-impression', 'Image/Story'),
('LinkedIn Ads', 'Professional Network', 'Cost-per-click', 'Image/Text'),
('Twitter Ads', 'Social Media', 'Cost-per-click', 'Text/Image'),
('YouTube Ads', 'Video Platform', 'Cost-per-view', 'Video'),
('Pinterest Ads', 'Social Media', 'Cost-per-click', 'Image'),
('Snapchat Ads', 'Social Media', 'Cost-per-impression', 'Image/Video'),
('TikTok Ads', 'Social Media', 'Cost-per-view', 'Video'),
('Reddit Ads', 'Forum', 'Cost-per-click', 'Text/Image');

-- Insert data into MarketingCampaign
INSERT INTO MarketingCampaign (StartDate, EndDate, TargetAudience)
VALUES 
('2024-01-01', '2024-02-01', 'International Students'),
('2024-03-01', '2024-04-01', 'College Freshmen'),
('2024-05-01', '2024-06-01', 'Young Professionals'),
('2024-07-01', '2024-08-01', 'Graduate Students'),
('2024-09-01', '2024-10-01', 'New Families'),
('2024-11-01', '2024-12-01', 'Remote Workers'),
('2024-01-15', '2024-02-15', 'City Movers'),
('2024-03-15', '2024-04-15', 'Shared Apartment Residents'),
('2024-05-15', '2024-06-15', 'First-Time Renters'),
('2024-07-15', '2024-08-15', 'Suburban Movers');

-- Insert data into Customer
INSERT INTO Customer (Name, Email, Address, Phone, PlatformID)
VALUES 
('John Doe', 'john@example.com', '123 Maple St', '555-1234', 1),
('Jane Smith', 'jane@example.com', '456 Oak St', '555-5678', 2),
('Emily Davis', 'emily@example.com', '789 Pine St', '555-8765', 3),
('Michael Brown', 'michael@example.com', '321 Cedar St', '555-4321', 4),
('Sarah Wilson', 'sarah@example.com', '654 Elm St', '555-7890', 5),
('David Johnson', 'david@example.com', '987 Willow St', '555-2345', 6),
('Laura Lee', 'laura@example.com', '123 Birch St', '555-6789', 7),
('Chris Martinez', 'chris@example.com', '456 Redwood St', '555-3456', 8),
('Anna White', 'anna@example.com', '789 Cypress St', '555-9876', 9),
('Tom Harris', 'tom@example.com', '321 Spruce St', '555-4567', 10);



-- Insert data into CampaignTarget
INSERT INTO CampaignTarget (CustomerID, CampaignID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert data into CustomerSupport
INSERT INTO CustomerSupport (InquiryDate, ResolutionStatus, CustomerID)
VALUES 
('2024-01-02', 'Resolved', 1),
('2024-01-05', 'Pending', 2),
('2024-01-10', 'In Progress', 3),
('2024-01-15', 'Resolved', 4),
('2024-01-20', 'Pending', 5),
('2024-01-25', 'Resolved', 6),
('2024-02-01', 'In Progress', 7),
('2024-02-05', 'Pending', 8),
('2024-02-10', 'Resolved', 9),
('2024-02-15', 'Resolved', 10);

-- Insert data into QualityAssuranceTeam
INSERT INTO QualityAssuranceTeam (QAName, QARole, Email, Phone)
VALUES 
('QA Team A', 'Tester', 'qa1@example.com', '555-0011'),
('QA Team B', 'Lead', 'qa2@example.com', '555-0022'),
('QA Team C', 'Analyst', 'qa3@example.com', '555-0033'),
('QA Team D', 'Manager', 'qa4@example.com', '555-0044'),
('QA Team E', 'Tester', 'qa5@example.com', '555-0055'),
('QA Team F', 'Lead', 'qa6@example.com', '555-0066'),
('QA Team G', 'Analyst', 'qa7@example.com', '555-0077'),
('QA Team H', 'Manager', 'qa8@example.com', '555-0088'),
('QA Team I', 'Tester', 'qa9@example.com', '555-0099'),
('QA Team J', 'Lead', 'qa10@example.com', '555-0100');

-- Insert data into PaymentProcessor
INSERT INTO PaymentProcessor (Name, TransactionFee)
VALUES 
('PayPal', 2.9),
('Stripe', 2.7),
('Square', 2.6),
('Apple Pay', 2.8),
('Google Pay', 2.5),
('Amazon Pay', 2.4),
('Visa', 2.9),
('MasterCard', 3.0),
('American Express', 3.1),
('Discover', 2.8);

-- Insert data into LogisticsProvider
INSERT INTO LogisticsProvider (LP_Name, LP_ContactInfo, ServiceArea)
VALUES 
('FedEx', 'contact@fedex.com', 'USA'),
('UPS', 'contact@ups.com', 'USA'),
('DHL', 'contact@dhl.com', 'Global'),
('Blue Dart', 'contact@bluedart.com', 'India'),
('Aramex', 'contact@aramex.com', 'Middle East'),
('USPS', 'contact@usps.com', 'USA'),
('Canada Post', 'contact@canadapost.com', 'Canada'),
('Royal Mail', 'contact@royalmail.com', 'UK'),
('Australia Post', 'contact@auspost.com', 'Australia'),
('Japan Post', 'contact@japanpost.com', 'Japan');

-- Insert data into MooPackage
INSERT INTO MooPackage (PackageName, Description, Price, Availability, QAID)
VALUES 
('Starter Kit', 'Basic move-in essentials', 100.00, 'In Stock', 1),
('Standard Kit', 'Standard move-in kit', 150.00, 'In Stock', 2),
('Deluxe Kit', 'Deluxe move-in kit', 200.00, 'Limited', 3),
('Premium Kit', 'Premium move-in kit', 250.00, 'Out of Stock', 4),
('Student Kit', 'Affordable essentials for students', 80.00, 'In Stock', 5),
('Professional Kit', 'Essentials for working professionals', 180.00, 'In Stock', 6),
('Family Kit', 'Kit for small families', 220.00, 'Limited', 7),
('Travel Kit', 'Travel essentials', 50.00, 'In Stock', 8),
('Eco Kit', 'Eco-friendly essentials', 120.00, 'In Stock', 9),
('Compact Kit', 'Compact move-in kit', 70.00, 'In Stock', 10);

-- Insert data into Order table
INSERT INTO [Order] (OrderDate, TotalAmount, Status, QAID, ProviderID, CustomerID, ProcessorID)
VALUES 
('2024-01-01', 120.00, 'Completed', 1, 1, 1, 1),
('2024-01-05', 250.00, 'Pending', 2, 2, 2, 2),
('2024-01-10', 180.00, 'Shipped', 3, 3, 3, 3),
('2024-01-15', 220.00, 'Delivered', 4, 4, 4, 4),
('2024-01-20', 150.00, 'Completed', 5, 5, 5, 5),
('2024-01-25', 100.00, 'Pending', 6, 6, 6, 6),
('2024-02-01', 130.00, 'Shipped', 7, 7, 7, 7),
('2024-02-05', 90.00, 'Delivered', 8, 8, 8, 8),
('2024-02-10', 160.00, 'Completed', 9, 9, 9, 9),
('2024-02-15', 110.00, 'Completed', 10, 10, 10, 10);

-- Insert data into OrderLine table
INSERT INTO OrderLine (OrderID, PackageID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert data into Product table
INSERT INTO Product (Name, Description, Price, Category)
VALUES 
('Chair', 'Comfortable office chair', 75.00, 'Furniture'),
('Desk', 'Spacious study desk', 150.00, 'Furniture'),
('Lamp', 'LED desk lamp', 20.00, 'Lighting'),
('Duvet', 'Warm bed duvet', 50.00, 'Bedding'),
('Pillow', 'Soft sleeping pillow', 15.00, 'Bedding'),
('Coffee Maker', 'Single-serve coffee maker', 40.00, 'Appliance'),
('Bookshelf', 'Wooden bookshelf', 80.00, 'Furniture'),
('Rug', 'Soft area rug', 35.00, 'Decor'),
('Curtain', 'Blackout curtain', 30.00, 'Decor'),
('Kettle', 'Electric kettle', 25.00, 'Appliance');

-- Insert data into Seller table
INSERT INTO Seller (SellerName, SellerContactInfo, Email, ContactInfo, City)
VALUES 
('HomeGoods', 'info@homegoods.com', 'seller1@homegoods.com', '555-1111', 'Boston'),
('FurnitureDepot', 'info@furnituredepot.com', 'seller2@furnituredepot.com', '555-2222', 'New York'),
('LightingStore', 'info@lightingstore.com', 'seller3@lightingstore.com', '555-3333', 'Chicago'),
('ApplianceMart', 'info@appliancemart.com', 'seller4@appliancemart.com', '555-4444', 'Los Angeles'),
('BedBathStore', 'info@bedbathstore.com', 'seller5@bedbathstore.com', '555-5555', 'Houston'),
('RugWorld', 'info@rugworld.com', 'seller6@rugworld.com', '555-6666', 'Phoenix'),
('CurtainCo', 'info@curtainco.com', 'seller7@curtainco.com', '555-7777', 'Philadelphia'),
('DeskEmporium', 'info@deskemporium.com', 'seller8@deskemporium.com', '555-8888', 'San Antonio'),
('PillowPlace', 'info@pillowplace.com', 'seller9@pillowplace.com', '555-9999', 'San Diego'),
('HomeEssentials', 'info@homeessentials.com', 'seller10@homeessentials.com', '555-0000', 'Dallas');

-- Insert data into FactorySupplier table
INSERT INTO FactorySupplier (SupplierID, FactoryName, FactoryStreet, FactoryCity)
VALUES 
(1, 'Factory A', 'Industrial Ave', 'Boston'),
(2, 'Factory B', 'Manufacture St', 'New York'),
(3, 'Factory C', 'Production Rd', 'Chicago'),
(4, 'Factory D', 'Assembly Blvd', 'Los Angeles'),
(5, 'Factory E', 'Craft Ln', 'Houston'),
(6, 'Factory F', 'Workshop Way', 'Phoenix'),
(7, 'Factory G', 'Construct Ct', 'Philadelphia'),
(8, 'Factory H', 'Fabricate Dr', 'San Antonio'),
(9, 'Factory I', 'Forge Pl', 'San Diego'),
(10, 'Factory J', 'Build Path', 'Dallas');

-- Insert data into ProductSeller table
INSERT INTO ProductSeller (SellerID, ProductID, ListedPrice, StockQuantity)
VALUES 
(1, 1, 70.00, 20),
(2, 2, 140.00, 15),
(3, 3, 18.00, 30),
(4, 4, 45.00, 25),
(5, 5, 13.00, 40),
(6, 6, 35.00, 10),
(7, 7, 75.00, 15),
(8, 8, 32.00, 20),
(9, 9, 28.00, 25),
(10, 10, 23.00, 15);

-- Insert data into IndividualSeller table
INSERT INTO IndividualSeller (IndSellerID, HouseStreet, HouseCity, HouseNumber)
VALUES 
(1, 'Main St', 'Boston', '123A'),
(2, 'Broadway', 'New York', '456B'),
(3, 'Market St', 'Chicago', '789C'),
(4, 'Sunset Blvd', 'Los Angeles', '321D'),
(5, 'River Rd', 'Houston', '654E'),
(6, 'Central Ave', 'Phoenix', '987F'),
(7, 'Liberty St', 'Philadelphia', '246G'),
(8, 'King St', 'San Antonio', '135H'),
(9, 'Pacific St', 'San Diego', '864I'),
(10, 'Elm St', 'Dallas', '753J');

-- Insert data into Admin table
INSERT INTO Admin (Name, EmployeeID)
VALUES 
('Admin A', 'EMP001'),
('Admin B', 'EMP002'),
('Admin C', 'EMP003'),
('Admin D', 'EMP004'),
('Admin E', 'EMP005'),
('Admin F', 'EMP006'),
('Admin G', 'EMP007'),
('Admin H', 'EMP008'),
('Admin I', 'EMP009'),
('Admin J', 'EMP010');

-- Insert data into PackageCreation table
INSERT INTO PackageCreation (PackageID, AdminID, ProductID, CreationDate, CreationTime, Description)
VALUES 
(1, 1, 1, '2024-01-01', '08:00:00', 'Initial creation of Starter Kit'),
(2, 2, 2, '2024-01-02', '09:00:00', 'Standard Kit setup'),
(3, 3, 3, '2024-01-03', '10:00:00', 'Deluxe Kit addition'),
(4, 4, 4, '2024-01-04', '11:00:00', 'Premium Kit development'),
(5, 5, 5, '2024-01-05', '12:00:00', 'Student Kit creation'),
(6, 6, 6, '2024-01-06', '13:00:00', 'Professional Kit setup'),
(7, 7, 7, '2024-01-07', '14:00:00', 'Family Kit finalization'),
(8, 8, 8, '2024-01-08', '15:00:00', 'Travel Kit creation'),
(9, 9, 9, '2024-01-09', '16:00:00', 'Eco Kit preparation'),
(10, 10, 10, '2024-01-10', '17:00:00', 'Compact Kit final touch');
