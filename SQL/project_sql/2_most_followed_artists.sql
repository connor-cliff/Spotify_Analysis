/*
Task: Find the top 10 most followed artists.

This query identifies the artists with the largest follower count in the dataset, highlighting 
those with the broadest audience reach. The maximum popularity and follower count are used per 
artist name to ensure that the most representative peak values are captured.

Limitation: Similar to the previous query, multiple entries for the same artist name exist 
with different popularity and follower values. The lack of a unique artist ID means that this 
method may group different artists who share the same name, which can skew results.

*/

SELECT
    MAX(artist_key) AS artist_key,
    artist_name,
    MAX(artist_followers) AS max_artist_followers
FROM 
    artists
WHERE 
    artist_name IS NOT NULL
GROUP BY 
    artist_name
ORDER BY 
    max_artist_followers DESC
LIMIT 10;
