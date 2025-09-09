-- Top 5 Languages per continent 
-- (ROW_NUMBERS) Use JOIN Aggregation, and Window function

WITH language_counts AS (
	SELECT 
		c.Continent,
        cl.language,
        SUM(C.Population * cl.Percentage/100) AS Speakers
        FROM countrylanguage cl
        JOIN country c ON cl.CountryCode = c.Code 
        GROUP BY c.Continent, cl.Language
        )
SELECT Continent, language, Speakers
FROM(
	SELECT 
		Continent, Language, Speakers,
        ROW_NUMBER() OVER (PARTITION BY Continent ORDER BY Speakers DESC) AS rn
	FROM language_counts
)ranked
WHERE rn <= 5
ORDER BY COntinent, rn;
    