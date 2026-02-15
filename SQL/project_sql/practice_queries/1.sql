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