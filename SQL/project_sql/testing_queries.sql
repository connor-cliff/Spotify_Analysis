SELECT *
FROM staging.staging_spotify_raw
where artist_name = 'Miss Li'
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
where genre_key = 8
limit 100

SELECT artist_name,
unnest(string_to_array(artist_genres, ',')) AS genre
FROM staging.staging_spotify_raw

select *
from artist_genre
where genre_key = 8
limit 100

select *
from artists
where artist_key = 53108
limit 100

select MAX(artist_key)
FROM public.artist_genre;
SELECT nextval(pg_get_serial_sequence('artist_genre', 'artist_key'));
