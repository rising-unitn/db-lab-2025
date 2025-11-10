SELECT E.first_name, E.last_name, COUNT(DISTINCT O.order_id)
FROM Employees E
NATURAL JOIN Orders O
WHERE (E.hire_date - birth_date)/365 < 35
AND E.country = 'UK'
GROUP BY E.employee_id
HAVING COUNT(DISTINCT O.order_id) >= 45
