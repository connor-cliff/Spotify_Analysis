-- Load data from staging table into relational tables with correct data types

-- Load data into artists table
INSERT INTO artists (artist_name, artist_popularity, artist_followers)
SELECT 
    artist_name, 
    CAST(CAST(artist_popularity AS FLOAT) AS INT), 
    CAST(CAST(artist_followers AS FLOAT) AS INT)
FROM staging.staging_spotify_raw;

-- Load data into genres table
INSERT INTO genres (genre_name)
SELECT 
    artist_genres
FROM staging.staging_spotify_raw;

-- Load data into albums table
INSERT INTO albums (album_id, album_name, album_release_date, album_total_tracks, album_type)
SELECT 
    album_id, 
    album_name, 
    TO_DATE(album_release_date, 'YYYY MM DD'), 
    CAST(album_total_tracks AS INT), 
    album_type
FROM staging.staging_spotify_raw;

-- Load data into tracks table
INSERT INTO tracks (track_id, track_name, track_number, track_popularity, track_duration_min, is_explicit)
SELECT 
    track_id, 
    track_name, 
    CAST(track_number AS INT),
    CAST(track_popularity AS INT),
    CAST(track_duration_min AS FLOAT), 
    CAST(is_explicit AS BOOLEAN)
FROM staging.staging_spotify_raw;

-- Add foreign keys to tables
ALTER TABLE albums
ADD CONSTRAINT fk_artists
FOREIGN KEY (artist_key) 
REFERENCES public.artists (artist_key);