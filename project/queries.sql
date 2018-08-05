-- countries that had a top 3 ranking
SELECT country, count(id)
FROM finalists
WHERE ranking < 4
GROUP BY country
ORDER BY count DESC;

-- vs countries that won
SELECT country, count(id)
FROM finalists
WHERE ranking = 1
GROUP BY country
ORDER BY count DESC;
-- actually, that's not entirely fair – let's compare that number with the 
-- number the country has been in the finals, i.e. how well the country used 
-- the chance
SELECT finalists.country, sum(CASE WHEN ranking = 1
  THEN 1
                              ELSE 0 END) AS wins,
       count(id) AS finale_participation, sum(CASE WHEN ranking = 1
  THEN 1
                                              ELSE 0 END) :: FLOAT /
                                          count(id) AS realisation
FROM finalists
GROUP BY finalists.country
ORDER BY realisation DESC;
-- wait, why is Azerbaijan shown as not having won?

-- get the winner each year
SELECT c2.year, artist, song, country
FROM finalists
       JOIN contests c2 ON finalists.contest_id = c2.id
WHERE ranking = 1
ORDER BY c2.year DESC;
-- strange, we are missing winners between 2008 and 2011?
SELECT artist, song, country, ranking, c2.year
FROM finalists
       JOIN contests c2 ON finalists.contest_id = c2.id
WHERE 2007 < c2.year AND c2.year < 2012;
-- yepp, definitely missing data here.

-- Does the country even matter?
-- Get composers that had the most songs in the running in one year
SELECT c2.year, count(song_id), a.name
FROM composers
       JOIN finalists f ON composers.song_id = f.id
       JOIN contests c2 ON f.contest_id = c2.id
       JOIN artists a ON composers.artist_id = a.id
GROUP BY c2.year, a.name
HAVING count(song_id) > 1
ORDER BY count DESC;

-- Get the same with writers
SELECT c2.year, count(song_id), a.name
FROM writers
       JOIN finalists f ON writers.song_id = f.id
       JOIN contests c2 ON f.contest_id = c2.id
       JOIN artists a ON writers.artist_id = a.id
GROUP BY c2.year, a.name
HAVING count(song_id) > 1
ORDER BY count DESC;

-- composers with the most wins in the top 3
SELECT a.name, count(f.song)
FROM composers
       JOIN artists a ON composers.artist_id = a.id
       JOIN finalists f ON composers.song_id = f.id
WHERE f.ranking < 4
GROUP BY a.name
ORDER BY count DESC;

-- writers with the most wins in the top 3
SELECT a.name, count(f.song)
FROM writers
       JOIN artists a ON writers.artist_id = a.id
       JOIN finalists f ON writers.song_id = f.id
WHERE f.ranking < 4
GROUP BY a.name
ORDER BY count DESC;

-- get tag names for every year for every country
SELECT t.name, f.country, c2.year
FROM tags_conn
       JOIN finalists f ON tags_conn.song_id = f.id
       JOIN tags t ON tags_conn.tag_id = t.id
       JOIN contests c2 ON f.contest_id = c2.id;

-- the difficulty here being that most of the tags are just countries or 
-- country-related terms (like "swedish")
-- Well, this just does not really give a nice overview of the changing 
-- tastes and style, so we might have to look somewhere else.
-- We might try to create a list of genres to check against, but again that 
-- means that the data is skewed towards the genres that we chose, not what 
-- can be found in the last.fm tags.
SELECT t.name, f.country, c2.year
FROM tags_conn
       JOIN finalists f ON tags_conn.song_id = f.id
       JOIN tags t ON tags_conn.tag_id = t.id
       JOIN contests c2 ON f.contest_id = c2.id
WHERE t.name IN ('pop', 'dance', 'schlager', 'chanson', 'ballad', 'swing',
    'disco', 'pop-rock', 'rock', 'electro', 'synthpop',
    'alternative', 'funk', 'eurodance', 'world', 'rap', 'hip-hop', 'ethno');

-- Except ... if we do that, we only get tags for a low number of song each year
SELECT c2.year, COUNT(f.country) AS number_of_tagged_songs
FROM tags_conn
       JOIN finalists f ON tags_conn.song_id = f.id
       JOIN tags t ON tags_conn.tag_id = t.id
       JOIN contests c2 ON f.contest_id = c2.id
WHERE t.name IN ('pop', 'dance', 'schlager', 'chanson', 'ballad', 'swing',
    'disco', 'pop-rock', 'rock', 'electro', 'synthpop',
    'alternative', 'funk', 'eurodance', 'world', 'rap', 'hip-hop', 'ethno')
GROUP BY c2.year
ORDER BY c2.year DESC;
-- not enough to really create a visualisation
