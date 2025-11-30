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

-- Create master staging table with merged data 
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

-- Create relational tables --

-- Create artists_dim table with primary key
CREATE TABLE public.artists_dim
(
    artist_id INT PRIMARY KEY,
    artist_name TEXT,
    CAST(artist_popularity AS INT),
    CAST(artist_followers AS INT),
)

-- Create genres_dim table with primary key
CREATE TABLE public.genres_dim
(
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(255)
)

-- Create albums_dim table with primary key
CREATE TABLE public.albums_dim
(
    album_id INT PRIMARY KEY, -- original spotify id
    artist_id INT,
    album_name VARCHAR(255),
    album_release_date DATE,
    album_total_tracks INT,
    album_type VARCHAR(255),
    FOREIGN KEY (artist_id) REFERENCES public.artists_dim (artist_id)
)

-- Create tracks_dim table with primary key
CREATE TABLE public.tracks_dim
(
    track_id INT PRIMARY KEY,
    track_name VARCHAR(255),
    track_number INT,
    track_popularity INT,
    track_duration_min FLOAT,
    is_explicit BOOLEAN,
)




-- Create artist_genre_dim table with composite primary and foreign keys
CREATE TABLE public.artist_genre_dim
(
    artist_id INT,
    track_id VARCHAR(50), -- original spotify id
    album_id INT,
    genre_id INT,
    PRIMARY KEY (artist_id, genre_id),
    FOREIGN KEY (artist_id) REFERENCES public.artists_dim (artist_id),
    FOREIGN KEY (genre_id) REFERENCES public.genres_dim (genre_id),
)


CREATE INDEX idx_