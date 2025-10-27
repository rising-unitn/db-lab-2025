SELECT S.company_name,
  COUNT(*) as "Late orders",
  AVG(O.Shipped_Date - O.Required_Date) as "Average delay"
FROM Orders O
JOIN Shippers S ON S.shipper_id = O.ship_via
WHERE O.Shipped_Date > O.Required_Date
GROUP BY S.shipper_id
ORDER BY "Late orders" DESC;
