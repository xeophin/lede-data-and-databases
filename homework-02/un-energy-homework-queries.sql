-- Oh, hi there.
-- We use this file to set up the queries used in Homework_2SQL.ipynb

-- Question 1
SELECT country, usage
FROM solar
WHERE year = 2014
ORDER BY usage DESC
LIMIT 15;

-- Question 2
SELECT round(avg(usage)) AS average, country
FROM solar
GROUP BY country
HAVING avg(usage) > 500
ORDER BY average DESC;

-- Question 3
SELECT min(year), country
FROM solar
GROUP BY country
HAVING min(year) = 2012
ORDER BY country;

-- Question 4
SELECT wind.country, wind.year, wind.usage, solar.usage
FROM wind
  JOIN solar ON wind.country = solar.country AND wind.year = solar.year
WHERE wind.country = 'Germany'
ORDER BY wind.year;

-- Question 5:
SELECT wind.country, avg(wind.usage) AS avg_wind, avg(solar.usage) AS avg_solar
FROM wind
  JOIN solar ON wind.country = solar.country AND wind.year = solar.year
GROUP BY wind.country
ORDER BY avg_solar DESC
LIMIT 10;

-- Question 6
SELECT wind.country, avg(wind.usage) AS avg_wind, avg(solar.usage) AS avg_solar
FROM wind
  JOIN solar ON wind.country = solar.country AND wind.year = solar.year
WHERE wind.year >= 2010
GROUP BY wind.country
ORDER BY avg_solar DESC
LIMIT 10;

-- Question 7
WITH countries_with_data_from_2000 AS (SELECT wind.country
                                       FROM wind
                                         JOIN solar
                                           ON wind.country = solar.country AND
                                               wind.year = solar.year
                                       GROUP BY wind.country
                                       HAVING min(wind
                                           .year) <= 2000 AND min(solar.year) <=
                                           2000)

SELECT countries_with_data_from_2000.country, avg(wind.usage) AS avg_wind, avg(
    solar.usage) AS avg_solar
FROM countries_with_data_from_2000
  RIGHT JOIN solar ON countries_with_data_from_2000.country = solar.country
  JOIN wind ON countries_with_data_from_2000.country = wind.country AND wind
    .year = solar.year
WHERE solar.year >= 2000
GROUP BY countries_with_data_from_2000.country
ORDER BY avg_solar DESC;

-- Question 8
SELECT country, min(year), max(year)
FROM solar
GROUP BY country
LIMIT 15;

-- Question 9
-- Alternative version without the with clause
SELECT timeseries.country, min_year, max_year, solar1.usage AS start_usage, solar2.usage AS last_usage
FROM (SELECT country, min(year) AS min_year, max(year) AS max_year
      FROM solar
      GROUP BY country) as timeseries
  JOIN solar as solar1 ON timeseries.country = solar1.country AND solar1.year =
    timeseries.min_year
  JOIN solar as solar2 ON timeseries.country = solar2.country AND solar2.year =
    timeseries.max_year
ORDER BY last_usage DESC
LIMIT 15;

-- Question 10
SELECT solar.country, avg(hydro.usage) AS avg_hydro, avg(
    solar.usage) AS avg_solar, avg(wind
    .usage) AS avg_wind
FROM solar
  JOIN wind ON solar.country = wind.country
  JOIN hydro ON solar.country = hydro.country
GROUP BY solar.country
ORDER BY avg_hydro DESC
LIMIT 10;