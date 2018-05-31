/*
Course: Date & Databases
Date: 2018-05-31
Author: Kaspar Manz
 */

-- Let's see how JOINS work

SELECT *
FROM messages;

-- normal (standard) join
SELECT *
FROM messages
  INNER JOIN friends ON messages.friend_id = friends
    .friend_id;

-- left join
SELECT *
FROM friends
  LEFT JOIN messages ON messages.friend_id = friends.friend_id;

-- cross join – joins every line with every line from the other table. there 
-- might not be any good use case for this
SELECT *
FROM friends
  CROSS JOIN messages;

----------------------------------------------------------------
-- some stuff about sub queries --------------------------------
----------------------------------------------------------------

-- we try to figure out how many times the lake appears in the table
SELECT count(*)
FROM geo_lake
WHERE lake = 'Bodensee'
GROUP BY lake;

-- And now we group by country:
SELECT count(*)
FROM geo_lake
WHERE lake = 'Bodensee'
GROUP BY country;

-- this actually gives the number of distinct countries in the table for the 
-- lake
SELECT count(DISTINCT country)
FROM geo_lake
WHERE lake = 'Bodensee';

-- this actually will give a row for each country
SELECT count(DISTINCT country)
FROM geo_lake
WHERE lake = 'Bodensee'
GROUP BY country;

-- as compared to this, where the lake borders on several provinces in the 
-- same country
SELECT count(country)
FROM geo_lake
WHERE lake = 'Bodensee'
GROUP BY country;

-- trying to find the lake that exists in the most provinces - and which 
-- provinces these are
SELECT count(lake), lake
FROM geo_lake
GROUP BY lake
ORDER BY count(lake) DESC;
-- this gives us the number of provinces for each lake, but loses the 
-- province information

-- getting lakes with the most provinces
SELECT count(lake), lake
FROM geo_lake
GROUP BY lake
HAVING count(lake) > 4 -- HAVING tests aggregates, WHERE the table itself
ORDER BY count(lake) DESC;

-- so we join the information back in
SELECT *
FROM (SELECT count(lake) AS ct, lake
      FROM geo_lake
      GROUP BY lake
      HAVING count(lake) > 4
      ORDER BY count(lake) DESC) AS sub
  JOIN geo_lake ON sub.lake = geo_lake.lake
ORDER BY sub.ct DESC, geo_lake.lake;
-- this gives us two lake colums, since we didn't specify the actual colums 
-- we want, and the join ust slaps everything on that it can

