-- Top 5 Languages per region
-- Row Numbers, JOIN, Aggregation, and Windows Functions

WITH language_counts AS (
	SELECT
		c.Region,
        cl.Language,
        SUM(c.Population * cl.Percentage/100) AS Speakers
	FROM countrylanguage cl
    JOIN country c ON cl.CountryCode = c.Code
    GROUP BY c.Region, cl.Language
)
SELECT Region, Language, Speakers
FROM (
	SELECT
		Region, Language, Speakers,
        ROW_NUMBER() OVER (PARTITION BY Region ORDER BY Speakers DESC) AS rn
	FROM language_counts
)ranked
WHERE rn <= 5
ORDER BY Region, rn;