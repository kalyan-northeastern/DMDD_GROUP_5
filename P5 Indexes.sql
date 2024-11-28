---Index 1: On Product Name
DROP INDEX IX_ProductName ON Product
GO

CREATE NONCLUSTERED INDEX IX_ProductName
ON Product (Name);

SELECT * FROM Product WHERE Name = 'Chair';

---Index 2: On Customer Name
DROP INDEX IX_CustomerName ON Customer
GO

CREATE NONCLUSTERED INDEX IX_CustomerName
ON Customer (Name);

SELECT * FROM Customer Where Name = 'John Doe';

---Index 3: On Customer Email
DROP INDEX IX_OrderDate ON [Order]
GO

CREATE NONCLUSTERED INDEX IX_OrderDate
ON [Order] (OrderDate);

SELECT * FROM [Order] WHERE OrderDate = '2024-01-01';

---Index 4: On Order Amount
DROP INDEX IX_OrderAmount ON [Order]
GO

CREATE NONCLUSTERED INDEX IX_OrderAmount
ON [Order] (TotalAmount);

SELECT * FROM [Order] WHERE TotalAmount = '100';

---Index 5: On Stock Quantity
DROP INDEX IX_ProductStock ON ProductSeller
GO

CREATE NONCLUSTERED INDEX IX_ProductStock
ON ProductSeller (StockQuantity);

SELECT * FROM ProductSeller WHERE StockQuantity > 20;