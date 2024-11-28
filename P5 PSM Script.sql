---Stored Procedure 1: Retrieve Orders for a Customer
DROP PROCEDURE IF EXISTS usp_GetOrdersForCustomer;
GO

CREATE PROCEDURE usp_GetOrdersForCustomer
    @CustomerID INT,
    @OrderCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [OrderID], [OrderDate], [TotalAmount]
    FROM [Order]
    WHERE [CustomerID] = @CustomerID;

    SELECT @OrderCount = COUNT(*)
    FROM [Order]
    WHERE [CustomerID] = @CustomerID;
END;


---Test the Procedure 1
DECLARE @OrderCount INT;
EXEC usp_GetOrdersForCustomer @CustomerID = 1, @OrderCount = @OrderCount OUTPUT;
PRINT 'Total Orders for Customer: ' + CAST(@OrderCount AS NVARCHAR);



---Stored Procedure 2: Update Product Price
DROP PROCEDURE IF EXISTS usp_UpdateProductPrice
GO

CREATE PROCEDURE usp_UpdateProductPrice
    @ProductID INT,
    @NewPrice DECIMAL(10, 2),
    @UpdatedRows INT OUTPUT
AS
BEGIN
    UPDATE Product
    SET Price = @NewPrice
    WHERE ProductID = @ProductID;

    SET @UpdatedRows = @@ROWCOUNT;
END;


---Test the Procedure 2
DECLARE @UpdatedRows INT;
EXEC usp_UpdateProductPrice @ProductID = 1, @NewPrice = 35.00, @UpdatedRows = @UpdatedRows OUTPUT;
PRINT 'Rows Updated: ' + CAST(@UpdatedRows AS NVARCHAR);




---Stored Procedure 3: Retrieve Product Details
DROP PROCEDURE IF EXISTS usp_UpdateProductPrice
GO

CREATE PROCEDURE usp_GetProductDetails
    @ProductID INT,
    @ProductName NVARCHAR(100) OUTPUT,
    @ProductPrice DECIMAL(18, 2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT @ProductName = Name, @ProductPrice = Price
        FROM Product
        WHERE [ProductID] = @ProductID;
    END TRY
    BEGIN CATCH
        PRINT 'Error: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;

---Test the Procedure 3
DECLARE @ProductName NVARCHAR(100);
DECLARE @ProductPrice DECIMAL(18, 2);

EXEC usp_GetProductDetails 
    @ProductID = 1,
    @ProductName = @ProductName OUTPUT,
    @ProductPrice = @ProductPrice OUTPUT;

SELECT @ProductName AS ProductName, @ProductPrice AS ProductPrice;



---Stored Procedure 4: Update Order Total
DROP PROCEDURE IF EXISTS usp_UpdateOrderTotal
GO

CREATE OR ALTER PROCEDURE usp_UpdateOrderTotal
    @OrderID INT,
    @NewTotal DECIMAL(18, 2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM [Order] WHERE [OrderID] = @OrderID)
        BEGIN
            PRINT 'Error: OrderID does not exist.';
            RETURN;
        END
        UPDATE [Order]
        SET TotalAmount = @NewTotal
        WHERE [OrderID] = @OrderID;

        PRINT 'Order total updated successfully.';
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        PRINT 'Error: ' + @ErrorMessage;
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;


---Test Procedure 4
SELECT [OrderID], [TotalAmount]
FROM [Order]
WHERE [OrderID] = 1;

EXEC usp_UpdateOrderTotal 
    @OrderID = 1,
    @NewTotal = 450.50;

SELECT [OrderID], [TotalAmount]
FROM [Order]
WHERE [OrderID] = 1;



---Stored Procedure 5: Calculating Total Sales
DROP PROCEDURE IF EXISTS usp_CalculateTotalSales
GO

CREATE PROCEDURE usp_CalculateTotalSales
    @ProviderID INT,
    @TotalSales DECIMAL(10, 2) OUTPUT
AS
BEGIN
    IF @ProviderID IS NULL
    BEGIN
        RAISERROR('ProviderID cannot be NULL', 16, 1);
        RETURN;
    END

    SET @TotalSales = 0;

    SELECT @TotalSales = SUM(TotalAmount)
    FROM [Order]
    WHERE ProviderID = @ProviderID;

    IF @TotalSales IS NULL
        SET @TotalSales = 0;
END;
GO


---Test Procedure 5
DECLARE @TotalSales DECIMAL(10, 2);

EXEC usp_CalculateTotalSales @ProviderID = 1, @TotalSales = @TotalSales OUTPUT;

SELECT @TotalSales AS TotalSales;






----View 1: Top Customers by Revenue
DROP VIEW vw_TopCustomersByRevenue
GO

CREATE VIEW vw_TopCustomersByRevenue
AS
SELECT 
    C.CustomerID,
    C.Name AS CustomerName,
    SUM(O.TotalAmount) AS TotalRevenue
FROM Customer C
JOIN [Order] O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name;

---Test
SELECT * FROM vw_TopCustomersByRevenue


----View 2: Monthly Revenue Trends
DROP VIEW vw_MonthlyRevenueTrends
GO 

CREATE VIEW vw_MonthlyRevenueTrends
AS
SELECT 
    YEAR(O.OrderDate) AS OrderYear,
    MONTH(O.OrderDate) AS OrderMonth,
    SUM(O.TotalAmount) AS MonthlyRevenue
FROM [Order] O
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate);

---Test
SELECT * FROM vw_MonthlyRevenueTrends


----View 3: Inventory Status Report
DROP VIEW vw_InventoryStatus
GO

CREATE VIEW vw_InventoryStatus
AS
SELECT 
    P.ProductID,
    P.Name AS ProductName,
    PS.StockQuantity,
    CASE 
        WHEN PS.StockQuantity > 20 THEN 'In Stock'
        WHEN PS.StockQuantity > 0 THEN 'Low Stock'
        ELSE 'Out of Stock'
    END AS StockStatus
FROM Product P
JOIN ProductSeller PS ON P.ProductID = PS.ProductID;

---Test
SELECT * FROM vw_InventoryStatus


----View 4: Order Details with Customer Info
DROP VIEW vw_OrderDetailsWithCustomer
GO

CREATE VIEW vw_OrderDetailsWithCustomer
AS
SELECT 
    O.OrderID,
    O.OrderDate,
    C.Name AS CustomerName,
    C.Email AS CustomerEmail,
    O.TotalAmount
FROM [Order] O
JOIN Customer C ON O.CustomerID = C.CustomerID;

---Test
SELECT * FROM vw_OrderDetailsWithCustomer


----View 5: Customer Support Summary
DROP VIEW vw_CustomerSupportSummary
GO

CREATE VIEW vw_CustomerSupportSummary
AS
SELECT 
    cs.ResolutionStatus,
    COUNT(cs.SupportID) AS TotalInquiries
FROM 
    CustomerSupport cs
GROUP BY 
    cs.ResolutionStatus;

---Test
SELECT * FROM vw_CustomerSupportSummary



-----Function 1: Calculate Discounted Price
DROP FUNCTION IF EXISTS fn_CalculateDiscountedPrice
GO

CREATE FUNCTION fn_CalculateDiscountedPrice
(
    @Price DECIMAL(10, 2),
    @DiscountPercent DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Price - (@Price * @DiscountPercent / 100);
END;

-----TEST
SELECT dbo.fn_CalculateDiscountedPrice(450, 10) AS DiscountedPrice;



-----Function 2: Get Customer's Full Name
DROP FUNCTION IF EXISTS fn_GetFullName
GO

CREATE FUNCTION fn_GetFullName
(
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50)
)
RETURNS NVARCHAR(101)
AS
BEGIN
    RETURN CONCAT(@FirstName, ' ', @LastName);
END;

-----TEST
SELECT dbo.fn_GetFullName('John', 'Doe') AS FullName;



-----Function 3: Calculate Tax on Order
DROP FUNCTION IF EXISTS fn_CalculateTax
GO

CREATE FUNCTION fn_CalculateTax
(
    @OrderAmount DECIMAL(10, 2),
    @TaxRate DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @OrderAmount * @TaxRate / 100;
END;


-----TEST
SELECT dbo.fn_CalculateTax(450, 2) AS TaxAmount;



-----Function 4: Days Since Last Purchase
DROP FUNCTION IF EXISTS fn_DaysSinceLastPurchase
GO

CREATE FUNCTION fn_DaysSinceLastPurchase
(
    @LastPurchaseDate DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @LastPurchaseDate, GETDATE());
END;


-----TEST
SELECT dbo.fn_DaysSinceLastPurchase('2024-08-01') AS DaysSincePurchase;



-----Function 5: Calculate Net Amount (After Tax and Discount)
DROP FUNCTION IF EXISTS CalculateNetAmount
GO

CREATE FUNCTION dbo.CalculateNetAmount
(
    @TotalAmount DECIMAL(18, 2),
    @DiscountRate DECIMAL(5, 2), -- e.g., 10 for 10%
    @TaxRate DECIMAL(5, 2)      -- e.g., 5 for 5%
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @DiscountAmount DECIMAL(18, 2) = (@TotalAmount * @DiscountRate) / 100;
    DECLARE @TaxAmount DECIMAL(18, 2) = ((@TotalAmount - @DiscountAmount) * @TaxRate) / 100;
    RETURN @TotalAmount - @DiscountAmount + @TaxAmount;
END;


-----TEST
SELECT dbo.CalculateNetAmount(450, 10, 2) AS [Net Amount (After Tax and Discount)];




------Trigger 1: Prevent Duplicate Product Names
DROP TRIGGER IF EXISTS trg_PreventDuplicateProductNames
GO

CREATE TRIGGER trg_PreventDuplicateProductNames
ON Product
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT Name
        FROM Product
        GROUP BY Name
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('Duplicate product names are not allowed.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;



------TEST
UPDATE Product
SET Name = 'Chair'
WHERE ProductID = 2;



------Trigger 2: Enforce Minimum Order Total
CREATE TRIGGER trg_EnforceMinimumOrderTotal
ON [Order]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE TotalAmount < 100
    )
    BEGIN
        RAISERROR ('Order Total must be at least 100.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


------TEST
UPDATE [Order]
SET TotalAmount = 80
WHERE OrderID = 1;