SELECT * FROM (
  SELECT country,
    SUM(total) as total_rev,
    RANK() OVER (ORDER BY sum(total) desc) as rank
  FROM CountriesWithCustomers
  GROUP BY country
  ORDER BY rank asc
  OFFSET 4 LIMIT 6
) ORDER BY country ASC
