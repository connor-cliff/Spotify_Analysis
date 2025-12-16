SELECT
    --MAX(artist_key) AS max_artist_key,
    artist_key,
    artist_name,
    MAX(artist_popularity) AS max_artist_popularity,
    MAX(artist_followers) AS max_artist_followers 
FROM  
    artists
WHERE
    artist_name IS NOT NULL
GROUP BY
    artist_name
ORDER BY
    artist_name,
    max_artist_popularity DESC,
    max_artist_followers  DESC
LIMIT   
    10 