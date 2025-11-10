SELECT country, company_name, total, count
FROM CountriesWithCustomers C1
WHERE total > (
    SELECT AVG(total)
    FROM CountriesWithCustomers C2
    WHERE C2.country = C1.country
    GROUP BY country
)
ORDER BY total DESC
