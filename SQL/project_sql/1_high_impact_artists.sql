/* Identify the artist with the biggest impact: those with the highest artists popularity score and most followers.

The dataset used in this analysis lacked a unique id for artists so they were given a surrogate key based on there name.
This resulted in there being multiple artist with the same name and different popularity and follower value which is 
likely due to this dataset being from 2009-2025 so these different values represent the artists stats over this time period.

This query uses a windows function to return the artist row which represents the best version of that artist.
*/

SELECT
    artist_key,
    artist_name,
    artist_popularity,
    artist_followers
FROM (
    SELECT
        artist_key,
        artist_name,
        artist_popularity,
        artist_followers,
        ROW_NUMBER() OVER (
            PARTITION BY artist_name
            ORDER BY artist_popularity DESC, artist_followers DESC
        ) AS rn
    FROM artists
    WHERE artist_name IS NOT NULL
) w
WHERE rn = 1
ORDER BY
    artist_popularity DESC,
    artist_followers DESC
LIMIT 10;
