-- Top 5 spoken languages

SELECT Language, SUM(Population * Percentage / 100) AS Speakers
FROM countrylanguage cl
JOIN country c ON cl.CountryCode = c.Code
GROUP BY Language
ORDER BY Speakers DESC
LIMIT 5;