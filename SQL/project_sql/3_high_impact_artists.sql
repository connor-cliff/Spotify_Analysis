/* 
Task: Identify the artist with the biggest impact: those with the highest artists popularity score 
and most followers.

This analysis helps to highlight the artist with the greatest influence in the dataset. These are 
the artists who drive trends and haev the broadest audience reach.

Limitation: The dataset used in this analysis lacked a unique ID for artists. This resulted in there 
being multiple artists with the same name and different popularity and follower value which is likely 
due to this dataset being from 2009-2025 so these different values represent the artists stats over 
this time period. To get around this, artists were given a surrogate key based on there name. 
This causes artist with the same name to be grouped together but for the sake of this exercise there
wasn't another choice given the dataset used.
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
WHERE 
    rn = 1
ORDER BY
    artist_popularity DESC,
    artist_followers DESC
LIMIT 10; 
