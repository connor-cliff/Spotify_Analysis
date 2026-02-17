---Level 1---
--Q1
SELECT ROUND(AVG(track_popularity), 2)
FROM tracks
 
--Q2
SELECT
    CASE
        WHEN is_explicit = TRUE THEN 'Explicit'
        ELSE 'Not Explicit'
    END AS explicit_status,
    COUNT(is_explicit)
FROM tracks
GROUP BY explicit_status;

--Q3
SELECT DISTINCT(track_name), track_popularity
FROM tracks
ORDER BY track_popularity DESC
LIMIT 10;

--Q4
SELECT album_name, ROUND(AVG(track_duration_min)::numeric, 2) AS average_track_duration
FROM tracks
LEFT JOIN albums ON tracks.album_key = albums.album_key
GROUP BY album_name;

--Q5
SELECT COUNT(DISTINCT(artist_key))
FROM artists;

--Q6 !!!
SELECT * FROM (
    SELECT 'min' AS type, album_name, album_release_date
    FROM albums
    WHERE album_name IS NOT NULL
    ORDER BY album_release_date ASC
    LIMIT 1
) AS oldest

UNION ALL

SELECT * FROM (
    SELECT 'max' AS type, album_name, album_release_date
    FROM albums
    WHERE album_name IS NOT NULL
    ORDER BY album_release_date DESC
    LIMIT 1
) AS newest;

--Q7
SELECT AVG(artist_popularity), albums.album_type
FROM artists
LEFT JOIN albums ON albums.artist_key = artists.artist_key
WHERE artist_name IS NOT NULL
GROUP BY albums.album_type
LIMIT 10

---Level 2---
--Q8

SELECT artist_name, AVG(track_popularity) AS avg_pop, COUNT(DISTINCT(track_name)) AS track_count
FROM artists
LEFT JOIN albums ON albums.artist_key = artists.artist_key
LEFT JOIN tracks ON tracks.album_key = albums.album_key
WHERE artist_name IS NOT NULL
GROUP BY artist_name
HAVING  COUNT(DISTINCT(track_name)) > 4
ORDER BY avg_pop DESC
LIMIT 5;

--Q9  
SELECT albums.album_key, album_name, AVG(track_popularity) AS avg_album_track_pop
FROM albums
LEFT JOIN tracks ON tracks.album_key = albums.album_key
WHERE album_name IS NOT NULL
GROUP BY albums.album_key
HAVING AVG(track_popularity) > (SELECT avg(track_popularity)
                                FROM tracks)

--Q10

WITH count_of_explicit_type AS(
SELECT artist_name, 
SUM(CASE WHEN tracks.is_explicit = TRUE THEN 1 ELSE 0 END) AS explicit_count,
SUM(CASE WHEN tracks.is_explicit = FALSE THEN 1 ELSE 0 END) AS not_explicit_count
FROM artists
LEFT JOIN albums ON albums.artist_key = artists.artist_key
LEFT JOIN tracks ON tracks.album_key = albums.album_key
GROUP BY artist_name
ORDER BY artist_name
)

SELECT artist_name
FROM count_of_explicit_type
WHERE explicit_count > 0 AND not_explicit_count > 0
ORDER BY artist_name
LIMIT 100

--Q11
SELECT artists.artist_name, MAX(track_duration_min) AS longest_track
FROM tracks
LEFT JOIN albums ON albums.album_key = tracks.album_key
LEFT JOIN artists ON artists.artist_key = albums.artist_key
--WHERE artists.artist_name = 'Pink Floyd'
GROUP BY artists.artist_name
ORDER BY artist_name ASC;

--Q12
SELECT EXTRACT(year FROM album_release_date) AS year, 
SUM(
    CASE WHEN EXTRACT(year FROM album_release_date) = 
    EXTRACT(year FROM album_release_date) THEN 1 ELSE 0 END) 
    AS track_count
FROM albums
GROUP BY year
ORDER BY year DESC;

--Q13
WITH albums_dataset_tracks AS (
SELECT album_name,
SUM( CASE WHEN tracks.album_key = albums.album_key THEN 1 ELSE 0 END) AS dataset_track_count
FROM albums
LEFT JOIN tracks ON tracks.album_key = albums.album_key
GROUP BY album_name
-- HAVING album_total_tracks <> SUM( CASE WHEN tracks.album_key = albums.album_key THEN 1 ELSE 0 END)
)

SELECT album_name
FROM albums_dataset_tracks
WHERE albums_dataset_tracks <> (
    SELECT MAX(album_total_tracks) AS album_total_tracks
    FROM albums
    GROUP BY album_name
)
