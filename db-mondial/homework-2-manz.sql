/*
Course: Data & Databases
Date: 2018-05-29
Author: Kaspar Manz
 */

-- More experiments with mondial
-- Get a combined list of mountains and lakes that are "part" of several 
-- countries, i.e. mark their border

-- get lakes
SELECT lakes_by_country.lake as name, lake.coordinates as coordinates
FROM (
      -- Basically dropping the province column from the table, since we 
      -- don't really need that information and it screws up our counts
      SELECT DISTINCT lake, country
      FROM geo_lake
      ) AS lakes_by_country
JOIN lake ON lakes_by_country.lake = lake.name
-- Making sure that we only have geographic features that belong to several 
-- countries at once
GROUP BY lakes_by_country.lake, lake.coordinates HAVING count(country) > 1
 
-- combine the table above with the one below
UNION 

-- get mountains, same procedure as above
SELECT mountains_by_country.mountain as name, mountain.coordinates as 
coordinates
FROM (
      SELECT DISTINCT mountain, country
      FROM geo_mountain
      ) AS mountains_by_country
JOIN mountain ON mountains_by_country.mountain = mountain.name
GROUP BY mountains_by_country.mountain, mountain.coordinates HAVING count
(country) > 1;

SELECT politics.country, politics.independence, economy.gdp 
FROM politics 
JOIN economy ON politics.country = economy.country
ORDER BY politics.independence ASC NULLS LAST LIMIT 10
UNION
SELECT politics.country, politics.independence, economy.gdp 
FROM politics 
JOIN economy ON politics.country = economy.country
ORDER BY politics.independence DESC NULLS LAST LIMIT 10;