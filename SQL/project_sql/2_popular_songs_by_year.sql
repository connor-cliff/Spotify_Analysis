/* return a row for each years from 2009 to 2025 with the most popular track.
Will need to join tracks to albums ot get the date.
must extract year from date

- what if multiple tracks have the same popularity?
use a windows fucntion to get each tracks row where the highest popularity for that year
is equal to their popularity score?
*/

SELECT 
   -- a.album_key,
    --a.album_name,
    t.track_key,
    t.track_name,
    t.track_popularity
    --a.album_release_date
FROM (
    SELECT
        t.track_name,
        t.track_popularity,
        MAX() OVER (
            PARTITION BY t.track_key
            ORDER BY t.track_popularity DESC
        ) AS m
    FROM tracks
    ) w
WHERE m = MAX(t.track_popularity)
ORDER BY 
    t.track_popularity
/*
LEFT JOIN tracks as t
    ON a.album_key = t.album_key
GROUP BY
    --album_year,
    t.track_name
ORDER BY
    album_year DESC
    */
LIMIT 100;


/*
SELECT 
   -- a.album_key,
    --a.album_name,
    t.track_name,
    MAX(t.track_popularity),
    EXTRACT(YEAR FROM a.album_release_date) AS album_year
FROM 
    albums as a
LEFT JOIN tracks as t
    ON a.album_key = t.album_key
GROUP BY
    album_year,
    t.track_name
ORDER BY
    album_year DESC
LIMIT 100;
*/