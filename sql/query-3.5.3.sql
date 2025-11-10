WITH Offending_Customers as (
   SELECT * FROM Customers C -- take care of changing the columns
   LEFT JOIN Orders O
   ON O.customer_id = C.customer_id
   EXCEPT
   SELECT * FROM Customers C
   JOIN Orders O
   ON O.customer_id = C.customer_id
)
SELECT S.contact_name, OC.contact_name
FROM Offending_Customers OC
JOIN Suppliers S
ON OC.country = S.country
