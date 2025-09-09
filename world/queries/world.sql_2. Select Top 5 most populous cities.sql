-- Top 5 most populous cities

SELECT Name, Population
FROM city
ORDER BY Population DESC
LIMIT 5;