CREATE VIEW CountriesCompaniesWithCustomers AS (
  SELECT C.country, C.region,
    SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) as Total,
    COUNT(DISTINCT O.order_id) as Count
  FROM Orders O
  JOIN Order_Details OD ON OD.order_id = O.order_id
  JOIN Customers C ON O.Customer_ID = C.Customer_ID
  GROUP BY C.country, C.region
  ORDER BY Total DESC
);

SELECT country, region,
  SUM(total) as total_rev,
  RANK() OVER (PARTITION BY country ORDER BY SUM(total) DESC) as Rank
FROM CountriesCompaniesWithCustomers
GROUP BY country, region
ORDER BY country ASC
