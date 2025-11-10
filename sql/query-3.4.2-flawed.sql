SELECT E.employee_id, O.ship_country,
      AVG(shipped_date - order_date) as Average_Delay,
      COUNT(DISTINCT product_id)
FROM Employees E
NATURAL JOIN Orders O
NATURAL JOIN Order_details OD
WHERE E.employee_id IN (
   -- same query as 3.4.1

SELECT E.employee_id -- remember to change the SELECT clause!
  FROM Employees E
  NATURAL JOIN Orders O
  WHERE (E.hire_date - birth_date)/365 < 35
  AND E.country = 'UK'
  GROUP BY E.employee_id
  HAVING COUNT(*) >= 45
) AND O.shipped_date IS NOT NULL
GROUP BY E.employee_id, O.ship_country
