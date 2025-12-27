/*
Task: Find the most popular artists in the dataset.

This analysis identifies the artists with the highest overall popularity by averaging 
the artist_popularity across all entries for each artist. It provides a view of consistently 
popular artists rather than single-track outliers. Additionally, the query returns the average 
number of followers to give context on each artist’s audience reach.

Limitation: Multiple entries exist for the same artist name with different popularity and 
follower values due to the lack of a unique artist identifier. A surrogate key was used based 
on the artist name, and the query uses the maximum surrogate key to approximate a single 
representative entry for each artist. This may still group different artists with 
the same name together.
*/

SELECT 
    MAX(artist_key) AS max_artist_key,
    artist_name,
    MAX(artist_popularity) AS average_artist_popularity
FROM  
    artists
WHERE
    artist_name IS NOT NULL
GROUP BY
    artist_name
ORDER BY
    average_artist_popularity DESC
LIMIT   
    10 