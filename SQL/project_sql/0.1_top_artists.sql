-- Finds the top 10 artists based on popularity score. 
-- *This dataset has multiple different value in columns such as artist_popularity
-- for the some artist_name. Due to the artist_key being generated from artist name, 
-- the resulting dataset has multiple entries of the same artist name with different 
-- values for other columns, including the primary key. This will be cleaned later in 
-- Power Query but the following query has been constructed to work around this and use the 
-- highest value primary key and average of other scores.

SELECT 
    MAX(artist_key) AS max_artist_key,
    artist_name,
    AVG(artist_popularity) AS average_artist_popularity
    -- AVG(artist_followers) AS artist_followers 
FROM  
    artists
WHERE
    artist_name IS NOT NULL
GROUP BY
    artist_key, -- adding key to groupby returns multiple of the same artist?
    artist_name,
    artist_popularity
ORDER BY
    artist_popularity DESC
LIMIT   
    10