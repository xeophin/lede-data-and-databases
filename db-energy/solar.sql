-- test whether we have more or less common countries
SELECT DISTINCT country
FROM solar
ORDER BY country;

-- is data continous
SELECT DISTINCT country, year
FROM solar
ORDER BY country, year;

-- let's do some counting
SELECT count(*)
FROM (SELECT DISTINCT country, year FROM solar ORDER BY country, year) AS sub;
-- this gives 1105 rows, but
SELECT count(*)
FROM solar;
-- gives 1107 row. we have duplicates

SELECT count(country), country, year
FROM solar
GROUP BY country, year
HAVING count(country) > 1
ORDER BY count(country) DESC;

-- now that we have some data, we can drill down
SELECT *
FROM solar
WHERE country = 'Australia' AND year = 2009;

-- remove the offending row
DELETE
FROM solar
WHERE country = 'Australia' AND year = 2009 AND usage = 16;

-- and now the other one
SELECT *
FROM solar
WHERE country = 'Australia' AND year = 2001;

-- This is a hidden column with a ... ID of the row?
SELECT ctid
FROM solar
WHERE country = 'Australia' AND year = 2001;

-- and then remove this from the table
DELETE
FROM solar
WHERE ctid NOT IN
    (SELECT MAX(dt.ctid) FROM solar AS dt GROUP BY country, year, usage);