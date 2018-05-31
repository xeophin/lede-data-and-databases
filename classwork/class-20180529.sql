-- DISTINCT removes any duplicates from the query
SELECT DISTINCT name, percentage
FROM language
WHERE percentage = 100;

SELECT country, name, percentage
FROM language
WHERE name IN ('English',
    'Spanish') AND percentage >= 50;

-- Combine tables
SELECT language.country, language.name, language.percentage, economy.gdp
FROM language
  JOIN economy ON language.country = economy.country
WHERE name IN ('English',
    'Spanish') AND percentage >= 50;

-- as select just creates a new (virtual) table, we can actually name that 
-- table and then use that in another query
WITH spengdp AS (SELECT language.country, language.name, language.percentage, economy.gdp
                 FROM language
                   JOIN economy ON language.country = economy.country
                 WHERE name IN ('English',
                     'Spanish') AND percentage >= 50)
    -- and then we can use that table to create an aggregated version
SELECT name, count(name), avg(gdp)
FROM spengdp
GROUP BY name;

-- this is equivalent to
SELECT spengdp.name, count(spengdp.name), avg(spengdp.gdp)
FROM (SELECT language.country, language.name, language.percentage, economy.gdp
      FROM language
        JOIN economy ON language.country = economy.country
      WHERE name IN ('English',
          'Spanish') AND percentage >= 50) AS spengdp
GROUP BY spengdp.name;

-- joins using our own generated tables
SELECT language.name, country.name, language.percentage, mostspk.mycount
FROM (SELECT name, count(country) AS mycount
      FROM language
      GROUP BY name) AS mostspk
  JOIN language ON language.name = mostspk.name
  JOIN country ON language.country = country.code
ORDER BY mostspk.mycount DESC, language.name, language.percentage DESC;