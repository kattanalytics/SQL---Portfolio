-- What are the top 5 most populous countries?

SELECT Name, Population
FROM country
ORDER BY Population DESC
LIMIT 5;
