-- Procedures Script

-- 1. Get Product Count in Each Category
CREATE PROCEDURE CategoryProductCount
AS
BEGIN
    SELECT C.Name AS Category_Name, COUNT(P.Product_ID) AS Product_Count
    FROM Category C
    JOIN Product P ON C.Category_ID = P.Category_ID
    GROUP BY C.Name;
END;

-- 2. Get Total Orders and Average Order Value for a Customer
CREATE PROCEDURE GetCustomerOrderStats
    @CustomerID INT,
    @OrderCount INT OUTPUT,
    @AvgOrderValue DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @OrderCount = COUNT(Order_ID)
    FROM OrderInfo
    WHERE Customer_ID = @CustomerID;

    SELECT @AvgOrderValue = AVG(Total_Amount)
    FROM OrderInfo
    WHERE Customer_ID = @CustomerID;
END;

-- 3. Get Customer Count by City
CREATE PROCEDURE CustomerCountByCity
AS
BEGIN
    SELECT A.City, COUNT(C.Customer_ID) AS Customer_Count
    FROM Customer C
    JOIN Address A ON C.Address_ID = A.Address_ID
    GROUP BY A.City;
END;

-- 4. List Orders with Product and Customer Details
CREATE PROCEDURE OrderDetails
AS
BEGIN
    SELECT OI.Order_ID, OI.Order_Date, C.First_Name + ' ' + C.Last_Name AS Customer_Name,
           P.Name AS Product_Name, OI.Quantity, OI.Unit_Price * OI.Quantity AS Total_Amount
    FROM OrderInfo OI
    JOIN OrderItem O ON OI.Order_ID = O.Order_ID
    JOIN Customer C ON OI.Customer_ID = C.Customer_ID
    JOIN Product P ON O.Product_ID = P.Product_ID
    ORDER BY OI.Order_Date DESC;
END;
