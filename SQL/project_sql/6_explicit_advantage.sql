/*
Task: Determine if tracks which are marked as explicit perform better than those which are not.


This analysis compares the average popularity of tracks marked as explicit versus non-explicit
tracks. It provides insight into whether explicit content is associated with higher popularity
within the dataset.

*/

SELECT
    CASE
        WHEN is_explicit = TRUE THEN 'explicit'
        ELSE 'non-explicit'
    END AS explicit_status,
    AVG(track_popularity) AS avg_popularity,
    COUNT(*) AS track_count
FROM
    tracks
GROUP BY
    explicit_status;

/*
Summary:
Explicit tracks have a noticeably higher average popularity (~61.97) compared to non-explicit
tracks (~50.56). Although non-explicit tracks make up a larger portion of the dataset, the
results suggest that tracks containing explicit content tend to perform better in terms of
popularity.

Results:
[
  {
    "explicit_status": "explicit",
    "avg_popularity": "61.9680249455670387",
    "track_count": "203002"
  },
  {
    "explicit_status": "non-explicit",
    "avg_popularity": "50.5646281403139396",
    "track_count": "490158"
  }
]
*/