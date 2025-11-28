-- Load raw data into the staging tables
COPY staging_spotify_2009_to_2023
FROM 'C:\Developer\My Projects\Spotify_Analysis\csv\spotify_data_2009-2023.csv'
DELIMITER ',' 
CSV HEADER;

COPY staging_spotify_2025
FROM 'C:\Developer\My Projects\Spotify_Analysis\csv\spotify_data_2025_fixed.csv'
DELIMITER ',' 
CSV HEADER;

-- Merge initial staging tables into one with unified columns and units for track duration
INSERT INTO staging_spotify_raw (
      track_id,
    track_name,
    track_number,
    track_popularity,
    track_duration_min,
    is_explicit,
    artist_name,
    artist_popularity,
    artist_followers,
    artist_genres,
    album_id,
    album_name,
    album_release_date,
    album_total_tracks,
    album_type,
    source_file
)

SELECT
    track_id,
    track_name,
    track_number,
    track_popularity,
    CAST(track_duration_ms AS FLOAT)/60000 AS track_duration_min,
    is_explicit,
    artist_name,
    artist_popularity,
    artist_followers,
    artist_genres,
    album_id,
    album_name,
    album_release_date,
    album_total_tracks,
    album_type,
    '2009-2023'
FROM staging_spotify_2009_to_2023;

INSERT INTO staging_spotify_raw (
      track_id,
    track_name,
    track_number,
    track_popularity,
    track_duration_min,
    is_explicit,
    artist_name,
    artist_popularity,
    artist_followers,
    artist_genres,
    album_id,
    album_name,
    album_release_date,
    album_total_tracks,
    album_type,
    source_file
)

SELECT
    track_id,
    track_name,
    track_number,
    track_popularity,
    CAST(track_duration_min AS FLOAT),
    is_explicit,
    artist_name,
    artist_popularity,
    artist_followers,
    artist_genres,
    album_id,
    album_name,
    album_release_date,
    album_total_tracks,
    album_type,
    '2025'
FROM staging_spotify_2025;