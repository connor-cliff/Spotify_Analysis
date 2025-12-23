/* Return the track(s) with the highest popularity for each year. 

This analysis identifies which track reached the highest popularity score for each given year. 

Firstly, tracks are unduplicated to account for multiple entries which have the same names. 
From this set, the maximum popularity per year is calculated and joined back to return the
corrasponding track(s).

Limitations: tracks with the same name from different artists will be grouped together. This
was accepted as this analysis just aims to give a quick overview of popular tracks before the 
dataset is properly cleaned.
*/

WITH unduplicated AS (
    SELECT
        t.track_name,
        EXTRACT(YEAR FROM a.album_release_date) AS album_year,
        MAX(t.track_popularity) AS track_popularity
    FROM albums a
    JOIN tracks t
        ON a.album_key = t.album_key
    GROUP BY
        album_year,
        t.track_name
),
yearly_max AS (
    SELECT
        album_year,
        MAX(track_popularity) AS max_popularity
    FROM unduplicated
    GROUP BY album_year
)
SELECT
    u.track_name,
    u.track_popularity,
    u.album_year
FROM unduplicated u
JOIN yearly_max y
    ON u.album_year = y.album_year
   AND u.track_popularity = y.max_popularity
ORDER BY u.album_year DESC
LIMIT 100;