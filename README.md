# Introduction
This project aims to explore trends in the music industry by analysing Spotify music data from 1960 to the present day. There will be a focus on influential artists, understanding trends and exploring factors which leads to a track's success, and much more.
 
# Quick links
The data used in this project is from: [Spotify Global Music Dataset](https://www.kaggle.com/datasets/wardabilal/spotify-global-music-dataset-20092025?resource=download)

Find the SQL queries here: [Project SQL folder](/SQL/project_sql/)

Find the Excel analysis here:

Find the Power BI dashboard here:

---  

# Key Questions

- Which artists have the greatest overall impact based on popularity and followers?
- Who are the most consistently popular artists in the dataset?
- Which artists have the largest audience reach?
- What are the most popular tracks for each year?
- Do tracks with featured artists perform better than solo tracks?
- Do explicit tracks tend to perform better or worse than non explicit tracks?

---

# Project Pipeline
This project follows an analytics pipeline which moves from data extraction to analysis and then visualisation.

## SQL
Shape the raw data into an analysis ready form.
- Host a database in pgAdmin and connect it to VSCode.
- Link project files to GitHub for version control.
- Split the columns into a relational schema.
- Standardise the fields.
- Create foreign keys and primary keys.
- Validate assumptions before indepth analysis.

## Excel
Analyse the prepared dataset.
- Explore the data using pivot tables and filters.
- Compare factors such as track length, popularity, and explicit status.
- Aggregate metrics withc counts, averages and medians.
- Create charts and dashboards to present findings.

## Power BI
Visualise insights from the analysis.
- Create an interactive dashboard with charts.
- Implement slicers, drill downs and filtering.
- Present findings in an easy to digest form.

---

# Stage 1: Database creation and querying in SQL

## Database creation and Standardisation
The original data for this project was split into a 2009-2023 version and a 2025 version. To allow proper analysis, it was important to standardise the raw data into a relational schema. This was achieved by firstly combining the two CSV files to get the most data and load them into a single staging table . The two files had slightly different column names, column orders and time unit which were unified.

The database was created:

```sql
CREATE DATABASE spotify_analysis;
```

Tables were created for each entity such as artists, albums, tracks and genre. Primary and foreign keys were added to tables for proper data warehousing while the original Spotify keys were kept:
```sql
CREATE TABLE public.albums
(
    album_key INT GENERATED ALWAYS AS IDENTITY,
    album_id VARCHAR(50), -- original spotify id
    artist_key INT NOT NULL,
    album_name VARCHAR(255),
    album_release_date DATE,
    album_total_tracks INT,
    album_type VARCHAR(255),
    PRIMARY KEY(album_key),
    CONSTRAINT fk_artist
        FOREIGN KEY (artist_key) 
            REFERENCES public.artists(artist_key)
);
```

Bridge tables were created for many-to-many relationships:
```SQL
CREATE TABLE public.artist_genre
(
    artist_key INT,
    genre_key INT,
    CONSTRAINT pk_artist_genre
        PRIMARY KEY (artist_key, genre_key),
    CONSTRAINT fk_artist
        FOREIGN KEY (artist_key) 
            REFERENCES public.artists (artist_key),
    CONSTRAINT fk_genre
        FOREIGN KEY (genre_key) 
            REFERENCES public.genres (genre_key)
);
```

Data was loaded into the database:
```SQL
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
```

## Querying
I developed queries to run on the database in order to validate my assumptions before moving on to further analysis.

The following are some examples of queries I wrote but full set of queries can be found here: [Project SQL folder](/SQL/project_sql/)

### Top 10 Highest Impact Artists

High impact artists are defined by those with the highest popularity score and the most followers, suggesting a large influence on the music industry. A windows function was used to preserve the integrity of each artist and avoid collapsing the results.


```sql
SELECT
    artist_key,
    artist_name,
    artist_popularity,
    artist_followers
FROM (
    SELECT
        artist_key,
        artist_name,
        artist_popularity,
        artist_followers,
        ROW_NUMBER() OVER (
            PARTITION BY artist_name
            ORDER BY artist_popularity DESC, artist_followers DESC
        ) AS rn
    FROM artists
    WHERE artist_name IS NOT NULL
) w
WHERE 
    rn = 1
ORDER BY
    artist_popularity DESC,
    artist_followers DESC
LIMIT 10; 
```

### Most Popular Songs For Each Year

This query produces a table of each year in the dataset with the corrasponding most popular track(s) for that year which can provide insights into yearly trends. This dataset contains multiple track entities which have all the same details but different popularity scores which can be explained by snapshots of the track as its popularity changes over time or re-releases of the same song. To work around this, the version of the track with the highest popularity score was selected for the results. These were then compared against the overall highest popularity score acheived by any track for each year to find the particular track(s) whos popularity score corrasponds to this value.

```sql
WITH unduplicated AS (
    SELECT
        t.track_name,
        EXTRACT(YEAR FROM a.album_release_date) AS album_year,
        MAX(t.track_popularity) AS track_popularity
    FROM albums a
    JOIN tracks t
        ON a.album_key = t.album_key
    GROUP BY
        album_year,
        t.track_name
),
yearly_max AS (
    SELECT
        album_year,
        MAX(track_popularity) AS max_popularity
    FROM unduplicated
    GROUP BY album_year
)
SELECT
    u.track_name,
    u.track_popularity,
    u.album_year
FROM unduplicated u
JOIN yearly_max y
    ON u.album_year = y.album_year
   AND u.track_popularity = y.max_popularity
ORDER BY u.album_year DESC;
```
---

# Stage 2: Excel Analysis

(Add later)

---

# Stage 3: Power BI Dashboard

(Add later)

---

## Visualisations
(Add later)

## Limitations & Assumptions
(Add later)

## Notes
Popularity in this dataset is defined by...

## Key Takeaways

- Developed advanced SQL skills with joins, CTEs, subqueries, windows functions and aggregations
- Learned to work with messy real world data
- Practised translating business questions into actionable queries
- Translated raw data into insights and visuals

This project strengthened my SQL abilities and provided insight into ...

## Conclusions
(Add later)
