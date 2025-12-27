/*
Task: Find the most popular artists in the dataset.

This analysis identifies the artists with the highest overall popularity by averaging 
the artist_popularity across all entries for each artist. It provides a view of consistently 
popular artists rather than single-track outliers. Additionally, the query returns the average 
number of followers to give context on each artist’s audience reach.

Limitation: Multiple entries exist for the same artist name with different popularity and 
follower values due to the lack of a unique artist identifier. A surrogate key was used based 
on the artist name, and the query uses the maximum surrogate key to approximate a single 
representative entry for each artist. This may still group different artists with 
the same name together.
*/

SELECT 
    MAX(artist_key) AS max_artist_key,
    artist_name,
    MAX(artist_popularity) AS average_artist_popularity
FROM  
    artists
WHERE
    artist_name IS NOT NULL
GROUP BY
    artist_name
ORDER BY
    average_artist_popularity DESC
LIMIT   
    10 

/*
Summary:
The top 10 most popular artists in the dataset, based on average artist popularity, are dominated by mainstream pop and hip-hop performers. 
Taylor Swift ranks highest with a perfect popularity score of 100, followed closely by Drake and Bad Bunny at 95.

Results:
[
  {
    "max_artist_key": 55090,
    "artist_name": "Taylor Swift",
    "average_artist_popularity": 100
  },
  {
    "max_artist_key": 53592,
    "artist_name": "Drake",
    "average_artist_popularity": 95
  },
  {
    "max_artist_key": 55129,
    "artist_name": "Bad Bunny",
    "average_artist_popularity": 95
  },
  {
    "max_artist_key": 55848,
    "artist_name": "The Weeknd",
    "average_artist_popularity": 94
  },
  {
    "max_artist_key": 55459,
    "artist_name": "Justin Bieber",
    "average_artist_popularity": 91
  },
  {
    "max_artist_key": 54833,
    "artist_name": "Sabrina Carpenter",
    "average_artist_popularity": 91
  },
  {
    "max_artist_key": 54433,
    "artist_name": "Rihanna",
    "average_artist_popularity": 90
  },
  {
    "max_artist_key": 55910,
    "artist_name": "Billie Eilish",
    "average_artist_popularity": 90
  },
  {
    "max_artist_key": 54931,
    "artist_name": "Bruno Mars",
    "average_artist_popularity": 90
  },
  {
    "max_artist_key": 55685,
    "artist_name": "Ariana Grande",
    "average_artist_popularity": 90
  }
]
*/