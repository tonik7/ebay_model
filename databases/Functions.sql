-- Functions Script

-- 1. Calculate Average Rating for a Product
CREATE FUNCTION ProductAverageRating(@ProductID INT) RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @ProductName VARCHAR(100), @AvgRating NUMERIC(3,2);
    SELECT @ProductName = Name, @AvgRating = AVG(Rating)
    FROM Product P
    JOIN ProductReview R ON P.Product_ID = R.Product_ID
    WHERE P.Product_ID = @ProductID
    GROUP BY P.Product_ID, Name;
    RETURN @ProductName + ' (ID = ' + CAST(@ProductID AS VARCHAR) + '), average rating: ' + CAST(@AvgRating AS VARCHAR) + '.';
END;

-- 2. Get Total Orders for a Customer
CREATE FUNCTION TotalOrdersByCustomer(@CustomerID INT) RETURNS INT
AS
BEGIN
    DECLARE @OrderCount INT;
    SELECT @OrderCount = COUNT(Order_ID)
    FROM OrderInfo
    WHERE Customer_ID = @CustomerID;
    RETURN @OrderCount;
END;

-- 3. Get Total Stock for a Category
CREATE FUNCTION CategoryTotalStock(@CategoryID INT) RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @CategoryName VARCHAR(50), @TotalStock INT;
    SELECT @CategoryName = Name, @TotalStock = SUM(Stock)
    FROM Category C
    JOIN Product P ON C.Category_ID = P.Category_ID
    WHERE C.Category_ID = @CategoryID
    GROUP BY C.Category_ID, Name;
    RETURN @CategoryName + ' (ID = ' + CAST(@CategoryID AS VARCHAR) + '), total stock: ' + CAST(@TotalStock AS VARCHAR) + '.';
END;

-- 4. Get Total Sales for a Product
CREATE FUNCTION ProductTotalSales(@ProductID INT) RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @ProductName VARCHAR(100), @TotalSales DECIMAL(10,2);
    SELECT @ProductName = Name, @TotalSales = SUM(Quantity * Unit_Price)
    FROM Product P
    JOIN OrderItem OI ON P.Product_ID = OI.Product_ID
    WHERE P.Product_ID = @ProductID
    GROUP BY P.Product_ID, Name;
    RETURN @ProductName + ' (ID = ' + CAST(@ProductID AS VARCHAR) + '), total sales: $' + CAST(@TotalSales AS VARCHAR) + '.';
END;

-- 5. Get All Products and Categories
CREATE FUNCTION ProductsInCategory() RETURNS TABLE
AS
RETURN
    SELECT P.Name AS Product_Name, P.Price, C.Name AS Category_Name
    FROM Product P
    JOIN Category C ON P.Category_ID = C.Category_ID;
