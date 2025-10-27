SELECT country, SUM(total) as total_rev
FROM CountriesWithCustomers
GROUP BY country
ORDER BY total_rev desc
OFFSET 4 LIMIT 6
