-- Load data from staging table into relational tables with correct data types

-- Load data into artists table
INSERT INTO artists (artist_name, artist_popularity, artist_followers)
SELECT DISTINCT
    artist_name, 
    CAST(CAST(artist_popularity AS FLOAT) AS INT), 
    CAST(CAST(artist_followers AS FLOAT) AS INT)
FROM staging.staging_spotify_raw;

-- Load data into albums table
INSERT INTO albums (album_id, artist_key, album_name, album_release_date, album_total_tracks, album_type)
SELECT 
    s.album_id, 
    a.artist_key,
    s.album_name, 
    TO_DATE(s.album_release_date, 'YYYY MM DD'), 
    CAST(s.album_total_tracks AS INT), 
    s.album_type
FROM staging.staging_spotify_raw s
INNER JOIN public.artists a
    ON s.artist_name = a.artist_name;

-- Load data into tracks table
INSERT INTO tracks (track_id, album_key, track_name, track_number, track_popularity, track_duration_min, is_explicit)
SELECT 
    track_id, 
    album_key, 
    track_name, 
    CAST(track_number AS INT),
    CAST(track_popularity AS INT),
    CAST(track_duration_min AS FLOAT), 
    CAST(is_explicit AS BOOLEAN)
FROM staging.staging_spotify_raw s
INNER JOIN public.albums a
    ON s.album_id = a.album_id;

-- Load data into genres table
INSERT INTO genres (genre_name)
SELECT DISTINCT
    artist_genres
FROM staging.staging_spotify_raw;

-- Load keys in artist_genre bridge table
INSERT INTO artist_genre (artist_key, genre_key)
SELECT
    artist_key,
    genre_key
FROM artists
INNER JOIN public.artists a 
    ON 