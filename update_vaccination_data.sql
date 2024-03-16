
CREATE TEMPORARY TABLE CountryMedians AS
SELECT 
    country, 
    MEDIAN(daily_vaccinations) AS median_daily_vaccinations
FROM 
    vaccination_data
WHERE 
    daily_vaccinations IS NOT NULL
GROUP BY 
    country;


UPDATE 
    vaccination_data AS t
SET 
    daily_vaccinations = COALESCE(t.daily_vaccinations, m.median_daily_vaccinations)
FROM 
    vaccination_data AS t
JOIN 
    CountryMedians AS m ON t.country = m.country;

UPDATE 
    vaccination_data
SET 
    daily_vaccinations = 0
WHERE 
    daily_vaccinations IS NULL;
