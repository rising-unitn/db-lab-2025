SELECT Customer_ID, Order_ID, Shipped_Date - Required_Date AS Overshot
FROM Orders
WHERE Shipped_Date > Required_Date
