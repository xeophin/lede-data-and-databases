-- Messing around with the Mondial DB
/*
In the console, use \d to get a list of tables, as long as you're not in some
 sensible editor like IntelliJ
 */

-- just show all rows in this table
SELECT * from mountainonisland;

-- We're trying to figure out which island has the most mountains on it
-- Arguments after SELECT: columns to be shown
SELECT island, COUNT(island) FROM mountainonisland GROUP BY island

-- add ordering
SELECT island, COUNT(island) FROM mountainonisland GROUP BY island ORDER BY 
COUNT(island) DESC;

-- add names to "generated" colums
SELECT island, COUNT(island) as mostmtn FROM mountainonisland GROUP BY island
 ORDER BY mostmtn DESC;

-- Let's go to the cities
SELECT * from city;

-- just show a few columns, and order by elevation, putting null values last
SELECT name, country, population, elevation 
  FROM city 
  ORDER BY elevation DESC NULLS LAST;

-- adding joins to combine tables
SELECT SUM(city.population), country.name
  FROM city
  -- take this table and take the rows that matches the ON clause
  JOIN country ON country.code = city.country
  GROUP BY country.name;

-- do mountains
SELECT * FROM mountain;
-- turns out this table does not contain the country (because mountains often
--  are part of several countries

SELECT name, mountains, elevation FROM mountain ORDER BY mountains, elevation;

-- Get 4000er
SELECT name, mountains, elevation 
  FROM mountain 
  WHERE elevation > 4000
  ORDER BY mountains, elevation;

-- Order descending
SELECT name, mountains, elevation 
  FROM mountain 
  WHERE elevation > 4000
  ORDER BY elevation DESC;

-- BETWEEN clause
SELECT name, mountains, elevation 
  FROM mountain 
  WHERE elevation BETWEEN 4000 AND 6000
  ORDER BY elevation DESC;

-- Complex clauses
SELECT name, mountains, elevation 
  FROM mountain 
  WHERE elevation > 4000 AND mountains IS NULL 
  ORDER BY elevation DESC;

-- Count mountains in mountain ranges
SELECT mountains, COUNT(mountains)
  FROM mountain
  GROUP BY mountains
  ORDER BY COUNT(mountains) DESC;

-- So, whats the average height of these mountains?
SELECT mountains, COUNT(mountains), AVG(elevation)
  FROM mountain
  GROUP BY mountains
  ORDER BY COUNT(mountains) DESC;

SELECT geo_mountain.country, mountain.name, mountain.elevation, mountain.type
  FROM geo_mountain
  JOIN mountain ON mountain.name = geo_mountain.mountain
  WHERE geo_mountain.country = 'GR';