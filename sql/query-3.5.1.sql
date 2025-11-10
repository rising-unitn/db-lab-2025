SELECT C.customer_id, C.company_name
FROM Customers C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id
