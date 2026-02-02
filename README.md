# Summary
This project analyses Spotify music data to identify patterns behind artist popularity and track success.

## Key Findings

- (to add)
  

<p align="center">
  <img src="Resources/video.gif" width="1000">
</p>
 
# Quick links
The data used in this project is from: [Spotify Global Music Dataset](https://www.kaggle.com/datasets/wardabilal/spotify-global-music-dataset-20092025?resource=download)

Find the SQL queries here: [Project SQL folder](/SQL/project_sql/)

Find the Excel analysis here: [Excel folder](/Excel/)
 
Find the Power BI dashboard here: [Track Analysis Dashboard](https://app.powerbi.com/links/KlMuJSW2Ic?ctid=e11b3463-1afc-40f2-94ae-ed3f2c1f4880&pbi_source=linkShare&bookmarkGuid=e88ab947-4640-4ebd-a059-0672df8f634d)
 
# Business Questions
 
- What characteristics appear in high performing tracks?
- Are featured tracks more successful than solo releases?
- Does the artists popularity correlate with the tracks popularity?
- When is the best time to release a new track?
- How should you position tracks within an album?

# Approach
Data was extracted and standardised in SQL, analysed in Excel, and visualised in Power BI.

## SQL Data Preparation

**Goal:** Convert raw Spotify data into an analysis ready relational schema.

- Designed a relational schema with fact and dimension tables.
- Standardised CSV format before joining data.
- Built bridge tables to handle many-to-many genre relationships.
- Queried the data to validate assumptions before indepth analysis.

### Top 10 Highest Impact Artists

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

# Excel

**Goal:** Prepare a clean analytical dataset and create a star schema model.

- Converted duration fields into a unified metric.
- Removed duplicates while preserving most recent artist records.
- Created fact and dimension tables for modelling.
- Built relationships in Power Pivot for structured analysis.

## Star Schema Data Model
<img width="936" height="419" alt="image" src="https://github.com/user-attachments/assets/5b6e8178-a8cf-48bf-958b-05f1de39a70a" />


# Power BI

**Goal: ** Understand how artist reach, track characteristics and timing relate to popularity in order to identify patterns behind music performance.

**Functionality**
- Explore artist performance, track popularity and trends over time using filters, slicers and drill downs.
- Compare individual artists and tracks to assess which factors are associated with stronger performance.
- Examine how collaborations and explicit status relate to popularity outcomes.
- Identify when highly popular tracks tend to be released to inform release timing.

---

## Limitations & Assumptions
(Add later)

## Notes
Popularity in this dataset is defined by...

## Conclusions
(Add later)
