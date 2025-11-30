SELECT *
FROM staging_spotify_raw
WHERE album_name = 'DAMN.'
ORDER BY track_number ASC

SELECT COUNT(*)
FROM staging_spotify_2009_to_2023

SELECT COUNT(*)
FROM staging_spotify_2025