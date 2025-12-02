SELECT *
FROM staging.staging_spotify_raw
limit 100

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name = 'artist_popularity'

select *
from artists

SELECT COUNT(*)
FROM staging_spotify_2009_to_2023

SELECT COUNT(*)
FROM staging_spotify_2025

select *
from genres
limit 100