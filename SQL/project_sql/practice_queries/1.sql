---Level 1---
--Q1
SELECT ROUND(AVG(track_popularity), 2)
FROM tracks

--Q2
SELECT
    CASE
        WHEN is_explicit = TRUE THEN 'Explicit'
        ELSE 'Not Explicit'
    END AS explicit_status,
    COUNT(is_explicit)
FROM tracks
GROUP BY explicit_status;

--Q3
SELECT DISTINCT(track_name), track_popularity
FROM tracks
ORDER BY track_popularity DESC
LIMIT 10;

--Q4
SELECT AVG(track_duration_min)
FROM tracks