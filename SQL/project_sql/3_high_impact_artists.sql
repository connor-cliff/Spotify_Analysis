/* 
Task: Identify the artist with the biggest impact: those with the highest artists popularity score 
and most followers.

This analysis helps to highlight the artist with the greatest influence in the dataset. These are 
the artists who drive trends and haev the broadest audience reach.

Limitation: The dataset used in this analysis lacked a unique ID for artists. This resulted in there 
being multiple artists with the same name and different popularity and follower value which is likely 
due to this dataset being from 2009-2025 so these different values represent the artists stats over 
this time period. To get around this, artists were given a surrogate key based on there name. 
This causes artist with the same name to be grouped together but for the sake of this exercise there
wasn't another choice given the dataset used.
*/

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

/*
Summary:
The top 10 artists with the greatest overall impact in the dataset, considering both popularity and followers, 
include globally recognized pop and hip-hop stars. Taylor Swift ranks first with a perfect popularity score of 
100 and over 145 million followers.

This analysis highlights artists who not only achieve high popularity for their tracks but also maintain large, 
engaged audiences, demonstrating their influence in driving trends across the dataset.

Results:
[
  {
    "artist_key": 53437,
    "artist_name": "Taylor Swift",
    "artist_popularity": 100,
    "artist_followers": 145542136
  },
  {
    "artist_key": 52877,
    "artist_name": "Drake",
    "artist_popularity": 95,
    "artist_followers": 103126025
  },
  {
    "artist_key": 53317,
    "artist_name": "Bad Bunny",
    "artist_popularity": 95,
    "artist_followers": 102610644
  },
  {
    "artist_key": 55160,
    "artist_name": "The Weeknd",
    "artist_popularity": 94,
    "artist_followers": 113039308
  },
  {
    "artist_key": 55459,
    "artist_name": "Justin Bieber",
    "artist_popularity": 91,
    "artist_followers": 85050158
  },
  {
    "artist_key": 54833,
    "artist_name": "Sabrina Carpenter",
    "artist_popularity": 91,
    "artist_followers": 26559943
  },
  {
    "artist_key": 53560,
    "artist_name": "Billie Eilish",
    "artist_popularity": 90,
    "artist_followers": 118797451
  },
  {
    "artist_key": 54708,
    "artist_name": "Ariana Grande",
    "artist_popularity": 90,
    "artist_followers": 107418606
  },
  {
    "artist_key": 54798,
    "artist_name": "Bruno Mars",
    "artist_popularity": 90,
    "artist_followers": 75513910
  },
  {
    "artist_key": 54433,
    "artist_name": "Rihanna",
    "artist_popularity": 90,
    "artist_followers": 69050055
  }
]
*/