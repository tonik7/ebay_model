-- Triggers Script

-- 1. Update Stock When Order is Placed
CREATE TRIGGER UpdateStockOnOrder
ON OrderItem
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Product
    SET Stock = Stock - I.Quantity
    FROM Inserted I
    WHERE Product.Product_ID = I.Product_ID;
END;

-- 2. Revert Stock When Order is Canceled
CREATE TRIGGER RevertStockOnCancel
ON OrderInfo
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(Status)
    BEGIN
        DECLARE @OrderID INT;
        SELECT @OrderID = Order_ID FROM Inserted WHERE Status = 'Canceled';
        IF @OrderID IS NOT NULL
        BEGIN
            UPDATE Product
            SET Stock = Stock + OI.Quantity
            FROM OrderItem OI
            WHERE OI.Order_ID = @OrderID AND Product.Product_ID = OI.Product_ID;
        END;
    END;
END;
