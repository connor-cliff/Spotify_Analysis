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

-- Create artists table with primary key
CREATE TABLE public.artists
(
    artist_key INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    artist_id VARCHAR(50), -- original spotify id
    artist_name TEXT,
    artist_popularity FLOAT,
    artist_followers FLOAT
);

-- Create genres table with primary key
CREATE TABLE public.genres
(
    genre_key INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    genre_name VARCHAR(255)
);

-- Create albums table with primary key
CREATE TABLE public.albums
(
    album_key INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    album_id VARCHAR(50), -- original spotify id
    artist_key INT,
    album_name VARCHAR(255),
    album_release_date DATE,
    album_total_tracks INT,
    album_type VARCHAR(255),
    FOREIGN KEY (artist_key) REFERENCES public.artists (artist_key)
);

-- Create tracks table with primary key
CREATE TABLE public.tracks
(
    track_key INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    track_id VARCHAR(50), -- original spotify id
    album_key INT,
    track_name VARCHAR(255),
    track_number INT,
    track_popularity INT,
    track_duration_min FLOAT,
    is_explicit BOOLEAN,
    FOREIGN KEY (album_key) REFERENCES public.albums (album_key)
);

-- Create artist_genre table with composite primary and foreign keys
CREATE TABLE public.artist_genre
(
    artist_key INT,
    genre_key INT,
    PRIMARY KEY (artist_key, genre_key),
    FOREIGN KEY (artist_key) REFERENCES public.artists (artist_key),
    FOREIGN KEY (genre_key) REFERENCES public.genres (genre_key)
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.artists OWNER to postgres;
ALTER TABLE public.genres OWNER to postgres;
ALTER TABLE public.albums OWNER to postgres;
ALTER TABLE public.tracks OWNER to postgres;
ALTER TABLE public.artist_genre OWNER to postgres;

-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_artist_key ON public.artists (artist_key);
CREATE INDEX idx_genre_key ON public.genres (genre_key);
CREATE INDEX idx_album_key ON public.albums (album_key);
CREATE INDEX idx_track_key ON public.tracks (track_key);