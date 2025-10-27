CREATE VIEW TopThreeEachCategory AS (
  (SELECT 'Customer' as category, company_name as name, sum as total,
  RANK() OVER (ORDER BY sum DESC) as rank
  FROM TopTenPctCustomers
  ORDER BY sum DESC
  LIMIT 3)
  UNION
  (SELECT 'Employee' as category, first_name || ' ' || last_name as name, sum as total,
  RANK() OVER (ORDER BY sum DESC) as rank
  FROM TopTenPctEmployees
  ORDER BY sum DESC
  LIMIT 3)
  UNION
  (SELECT 'Product' as category, product_name as name, sum as total,
  RANK() OVER (ORDER BY sum DESC) as rank
  FROM TopTenPctProducts
  ORDER BY sum DESC
  LIMIT 3)
  UNION
  (SELECT 'Supplier' as category, company_name as name, sum as total,
  RANK() OVER (ORDER BY sum DESC) as rank
  FROM TopTenPctSuppliers
  ORDER BY sum DESC
  LIMIT 3)
  ORDER BY total DESC
);
