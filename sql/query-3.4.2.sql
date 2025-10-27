WITH QualifyingEmployees AS (
  SELECT E.employee_id
  FROM Employees E
  NATURAL JOIN Orders O
  WHERE (E.hire_date - birth_date)/365 < 35
  AND E.country = 'UK'
  GROUP BY E.employee_id
  HAVING COUNT(*) >= 45
) 
SELECT employee_id, ship_country,
       AVG(order_delay) as Average_Delay,
       SUM(product_count) as total_products
FROM (
      SELECT E.employee_id, O.ship_country, O.order_id,
      O.shipped_date - O.order_date as order_delay
      FROM Employees E NATURAL JOIN Orders O
      WHERE E.employee_id IN (SELECT employee_id FROM QualifyingEmployees)
      AND O.shipped_date IS NOT NULL
) AS order_level
NATURAL JOIN (
      SELECT O.order_id, COUNT(DISTINCT OD.product_id) as product_count
      FROM Orders O NATURAL JOIN Order_details OD
      GROUP BY O.order_id
) AS product_level
GROUP BY employee_id, ship_country
