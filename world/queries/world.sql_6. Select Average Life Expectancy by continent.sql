-- Average Life expectancy by continent
-- Sinple Aggregation

SELECT Continent, AVG(LifeExpectancy) AS AVGLifeExpectancy
FROM country
WHERE LifeExpectancy IS NOT NULL
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;