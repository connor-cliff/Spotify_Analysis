-- Create staging tables for the raw data with forgiving data types 

CREATE TABLE public.staging_spotify_2009_to_2023
(
    track_id VARCHAR(255),
    track_name VARCHAR(255),
    track_number VARCHAR(255),
    track_popularity VARCHAR(255),
    track_duration_ms VARCHAR(255),
    is_explicit VARCHAR(255),
    artist_name VARCHAR(255),
    artist_popularity VARCHAR(255),
    artist_followers VARCHAR(255),
    artist_genres VARCHAR(255),
    album_id VARCHAR(255),
    album_name VARCHAR(255),
    album_release_date VARCHAR(255),
    album_total_tracks VARCHAR(255),
    album_type VARCHAR(255)
);

CREATE TABLE public.staging_spotify_2025
(
    track_id VARCHAR(255),
    track_name VARCHAR(255),
    track_number VARCHAR(255),
    track_popularity VARCHAR(255),
    is_explicit VARCHAR(255),
    artist_name VARCHAR(255),
    artist_popularity VARCHAR(255),
    artist_followers VARCHAR(255),
    artist_genres VARCHAR(255),
    album_id VARCHAR(255),
    album_name VARCHAR(255),
    album_release_date VARCHAR(255),
    album_total_tracks VARCHAR(255),
    album_type VARCHAR(255),
    track_duration_min VARCHAR(255)
);

-- Create master staging table for merge data 
CREATE TABLE staging_spotify_raw (
    track_id VARCHAR(255),
    track_name VARCHAR(255),
    track_number VARCHAR(255),
    track_popularity VARCHAR(255),
    track_duration_min VARCHAR(255),
    is_explicit VARCHAR(255),
    artist_name VARCHAR(255),
    artist_popularity VARCHAR(255),
    artist_followers VARCHAR(255),
    artist_genres VARCHAR(255),
    album_id VARCHAR(255),
    album_name VARCHAR(255),
    album_release_date VARCHAR(255),
    album_total_tracks VARCHAR(255),
    album_type VARCHAR(255),
    source_file VARCHAR(50)
);