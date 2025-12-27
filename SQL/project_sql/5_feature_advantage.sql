/*
Task: Determine if tracks that have a featured artist have a higher popularity score on average.

This analysis compares the average popularity of tracks that feature additional artists 
(ft. or feat. in the track name) versus tracks without features. It provides insight into 
whether collaborations tend to perform better in terms of popularity.

Limitation: The analysis relies solely on the track name to identify features, which may miss 
some collaborations if they are not formatted consistently. Case variations are accounted for 
using case-insensitive matching.
*/

SELECT
    CASE 
        WHEN track_name ILIKE '%ft.%' OR track_name ILIKE '%feat.%' OR
             track_name ILIKE '%Ft.%' OR track_name ILIKE '%Feat.%' THEN 'Has Feature'
        ELSE 'No Feature'
    END AS feature_status,
    AVG(track_popularity) AS avg_popularity,
    COUNT(*) AS track_count
FROM 
    tracks
GROUP BY 
    feature_status;

/*
Summary:
Tracks that include a featured artist have a higher average popularity (~59.38) compared to tracks without a feature (~53.47).
While featured tracks account for a smaller portion of the dataset (~50,600 tracks vs ~642,500 tracks without features), 
the analysis suggests that collaborations tend to perform better in terms of popularity.

Results:
[
  {
    "feature_status": "Has Feature",
    "avg_popularity": "59.3798213721150806",
    "track_count": "50608"
  },
  {
    "feature_status": "No Feature",
    "avg_popularity": "53.4730200824213449",
    "track_count": "642552"
  }
]
*/