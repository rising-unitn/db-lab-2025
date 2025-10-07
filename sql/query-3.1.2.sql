SELECT Product_Name, Unit_Price
FROM Products
WHERE Discontinued = 0
AND units_on_order > units_in_stock
ORDER BY Unit_Price DESC
