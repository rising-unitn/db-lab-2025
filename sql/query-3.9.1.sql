CREATE VIEW TopTenPctCustomers AS (
  WITH TopPercent AS (
    SELECT C.customer_id, C.company_name, -- optional
      SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) as Sum,
      NTILE(10) OVER (ORDER BY SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) desc) as Percent
    FROM customers C
    JOIN orders O ON O.customer_id = C.customer_id
    JOIN order_details OD on OD.order_id = O.order_id
    GROUP BY C.customer_id, C.company_name
  )
  SELECT * FROM TopPercent
  WHERE PERCENT = 1
);

CREATE VIEW TopTenPctEmployees AS (
  WITH TopPercent AS (
    SELECT E.employee_id, E.first_name, E.last_name, -- optional
      SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) as Sum,
      NTILE(10) OVER (ORDER BY SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) desc) as Percent
    FROM employees E
    JOIN orders O ON O.employee_id = E.employee_id
    JOIN order_details OD on OD.order_id = O.order_id
    GROUP BY NE.employee_id, E.first_name, E.last_name
  )
  SELECT * FROM TopPercent
  WHERE PERCENT = 1
);

CREATE VIEW TopTenPctProducts AS (
  WITH TopPercent AS (
    SELECT P.product_id, P.product_name,
      SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) as Sum,
      NTILE(10) OVER (ORDER BY SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) desc) as Percent
    FROM Products P
    JOIN Order_Details OD ON OD.product_id = P.product_id 
    JOIN Orders O on OD.order_id = O.order_id
    GROUP BY P.product_id, P.product_name
  )
  SELECT * FROM TopPercent
  WHERE PERCENT = 1
);

CREATE VIEW TopTenPctSuppliers AS (
  WITH TopPercent AS (
    SELECT S.supplier_id, S.company_name,
      SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) as Sum,
      NTILE(10) OVER (ORDER BY SUM(OD.quantity * OD.unit_price * (1 - OD.discount)) desc) as Percent
    FROM Suppliers S
    JOIN Products P ON S.supplier_id = P.supplier_id
    JOIN Order_Details OD ON OD.product_id = P.product_id 
    JOIN Orders O on OD.order_id = O.order_id
    GROUP BY S.supplier_id, S.company_name
  )
  SELECT * FROM TopPercent
  WHERE PERCENT = 1
);
