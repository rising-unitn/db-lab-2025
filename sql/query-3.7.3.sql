SELECT CC.country, 
       CC.company_name,
       CC.total as spent_by_company, 
       AvgSpent.total as average_spent_in_country,
       CompanyCount.companies
FROM CountriesWithCustomers CC
JOIN (
  SELECT country, AVG(total) as total
  FROM CountriesWithCustomers
  GROUP BY country
) AS AvgSpent ON CC.country = AvgSpent.country 
JOIN (
  SELECT country, COUNT(DISTINCT company_name) as companies
  FROM CountriesWithCustomers
  GROUP BY country
) AS CompanyCount ON CC.country = CompanyCount.country
WHERE CC.total >= (
  SELECT MAX(total)
  FROM CountriesWithCustomers CC2
  WHERE CC2.country = CC.country
)
ORDER BY CC.country
