-- City with the largest population in each country
-- Classic window function with ROW_NUMBER

SELECT CountryCode, Name AS CityName, Population
FROM (
	SELECT 	
		CountryCode, NAme, Population,
        ROW_NUMBER() OVER (PARTITION BY CountryCode ORDER BY Population DESC) AS rn
	FROM city
)ranked
WHERE rn = 1
ORDER BY Population DESC;