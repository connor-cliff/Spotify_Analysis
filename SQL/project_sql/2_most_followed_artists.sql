/*
Task: Find the top 10 most followed artists.

This query identifies the artists with the largest follower count in the dataset, highlighting 
those with the broadest audience reach. The maximum popularity and follower count are used per 
artist name to ensure that the most representative peak values are captured.

Limitation: Similar to the previous query, multiple entries for the same artist name exist 
with different popularity and follower values. The lack of a unique artist ID means that this 
method may group different artists who share the same name, which can skew results.

*/

SELECT
    MAX(artist_key) AS artist_key,
    artist_name,
    MAX(artist_followers) AS max_artist_followers
FROM 
    artists
WHERE 
    artist_name IS NOT NULL
GROUP BY 
    artist_name
ORDER BY 
    max_artist_followers DESC
LIMIT 10;

/*
Results:
[
  {
    "artist_key": 55090,
    "artist_name": "Taylor Swift",
    "max_artist_followers": 145542136
  },
  {
    "artist_key": 54365,
    "artist_name": "Ed Sheeran",
    "max_artist_followers": 122802777
  },
  {
    "artist_key": 55910,
    "artist_name": "Billie Eilish",
    "max_artist_followers": 118797451
  },
  {
    "artist_key": 55848,
    "artist_name": "The Weeknd",
    "max_artist_followers": 113039308
  },
  {
    "artist_key": 55685,
    "artist_name": "Ariana Grande",
    "max_artist_followers": 107418606
  },
  {
    "artist_key": 55216,
    "artist_name": "Eminem",
    "max_artist_followers": 104584370
  },
  {
    "artist_key": 53592,
    "artist_name": "Drake",
    "max_artist_followers": 103126025
  },
  {
    "artist_key": 55129,
    "artist_name": "Bad Bunny",
    "max_artist_followers": 102610644
  },
  {
    "artist_key": 55459,
    "artist_name": "Justin Bieber",
    "max_artist_followers": 85050158
  },
  {
    "artist_key": 55737,
    "artist_name": "BTS",
    "max_artist_followers": 81197976
  }
]
*/