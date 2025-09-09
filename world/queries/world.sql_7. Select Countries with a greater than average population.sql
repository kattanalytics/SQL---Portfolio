-- Countries with population > average population
-- Demonstraites subqueries in WHERE

SELECT Name, Population
FROM country
WHERE Population > (
	SELECT AVG(Population) FROM country
)
ORDER BY Population DESC;