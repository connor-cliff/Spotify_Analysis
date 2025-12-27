/* 
Task: Return the track(s) with the highest popularity for each year. 

This analysis identifies yearly trends in the music industry which can be used to provide
insight into popularity patterns and help predict what will be populary in the future.

Firstly, tracks are unduplicated to account for multiple entries which have the same names. 
From this set, the maximum popularity per year is calculated and joined back to return the
corrasponding track(s).

Limitations: tracks with the same name from different artists will be grouped together. This
was accepted as this analysis just aims to give a quick overview of popular tracks before the 
dataset is properly cleaned.
*/

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
ORDER BY u.album_year DESC
LIMIT 100;

/*
Results:
[
  {
    "track_name": "The Fate of Ophelia",
    "track_popularity": 100,
    "album_year": "2025"
  },
  {
    "track_name": "BIRDS OF A FEATHER",
    "track_popularity": 94,
    "album_year": "2024"
  },
  {
    "track_name": "One Of The Girls (with JENNIE, Lily Rose Depp)",
    "track_popularity": 91,
    "album_year": "2023"
  },
  {
    "track_name": "End of Beginning",
    "track_popularity": 89,
    "album_year": "2022"
  },
  {
    "track_name": "traitor",
    "track_popularity": 86,
    "album_year": "2021"
  },
  {
    "track_name": "Blinding Lights",
    "track_popularity": 89,
    "album_year": "2020"
  },
  {
    "track_name": "Cruel Summer",
    "track_popularity": 87,
    "album_year": "2019"
  },
  {
    "track_name": "All The Stars (with SZA) - From Black Panther: The Album\"\"",
    "track_popularity": 89,
    "album_year": "2018"
  },
  {
    "track_name": "All The Stars (with SZA) - From \"Black Panther: The Album\"",
    "track_popularity": 89,
    "album_year": "2018"
  },
  {
    "track_name": "Perfect",
    "track_popularity": 88,
    "album_year": "2017"
  },
  {
    "track_name": "See You Again (feat. Kali Uchis)",
    "track_popularity": 88,
    "album_year": "2017"
  },
  {
    "track_name": "Shape of You",
    "track_popularity": 88,
    "album_year": "2017"
  },
  {
    "track_name": "Starboy",
    "track_popularity": 89,
    "album_year": "2016"
  },
  {
    "track_name": "The Night We Met",
    "track_popularity": 89,
    "album_year": "2015"
  },
  {
    "track_name": "I Love You So",
    "track_popularity": 87,
    "album_year": "2014"
  },
  {
    "track_name": "I Wanna Be Yours",
    "track_popularity": 91,
    "album_year": "2013"
  },
  {
    "track_name": "Sweater Weather",
    "track_popularity": 91,
    "album_year": "2013"
  },
  {
    "track_name": "Locked out of Heaven",
    "track_popularity": 88,
    "album_year": "2012"
  },
  {
    "track_name": "Give Me Everything (feat. Nayer)",
    "track_popularity": 87,
    "album_year": "2011"
  },
  {
    "track_name": "Love The Way You Lie",
    "track_popularity": 85,
    "album_year": "2010"
  },
  {
    "track_name": "Only Girl (In The World)",
    "track_popularity": 85,
    "album_year": "2010"
  },
  {
    "track_name": "Bad Romance",
    "track_popularity": 85,
    "album_year": "2009"
  },
  {
    "track_name": "Breakin' Dishes",
    "track_popularity": 87,
    "album_year": "2008"
  },
  {
    "track_name": "505",
    "track_popularity": 86,
    "album_year": "2007"
  },
  {
    "track_name": "Promiscuous",
    "track_popularity": 86,
    "album_year": "2006"
  },
  {
    "track_name": "Feel Good Inc.",
    "track_popularity": 89,
    "album_year": "2005"
  },
  {
    "track_name": "Mr. Brightside",
    "track_popularity": 88,
    "album_year": "2004"
  },
  {
    "track_name": "Numb",
    "track_popularity": 87,
    "album_year": "2003"
  },
  {
    "track_name": "Bring Me To Life",
    "track_popularity": 87,
    "album_year": "2003"
  },
  {
    "track_name": "The Scientist",
    "track_popularity": 88,
    "album_year": "2002"
  },
  {
    "track_name": "How You Remind Me",
    "track_popularity": 85,
    "album_year": "2001"
  },
  {
    "track_name": "Chop Suey!",
    "track_popularity": 85,
    "album_year": "2001"
  },
  {
    "track_name": "Sparks",
    "track_popularity": 90,
    "album_year": "2000"
  },
  {
    "track_name": "Yellow",
    "track_popularity": 90,
    "album_year": "2000"
  },
  {
    "track_name": "Scar Tissue",
    "track_popularity": 85,
    "album_year": "1999"
  },
  {
    "track_name": "Iris",
    "track_popularity": 92,
    "album_year": "1998"
  },
  {
    "track_name": "Let Down",
    "track_popularity": 88,
    "album_year": "1997"
  },
  {
    "track_name": "Wannabe",
    "track_popularity": 80,
    "album_year": "1996"
  },
  {
    "track_name": "Gangsta's Paradise",
    "track_popularity": 86,
    "album_year": "1995"
  },
  {
    "track_name": "Lover, You Should've Come Over",
    "track_popularity": 84,
    "album_year": "1994"
  },
  {
    "track_name": "Creep",
    "track_popularity": 90,
    "album_year": "1993"
  },
  {
    "track_name": "Like a Tattoo",
    "track_popularity": 80,
    "album_year": "1992"
  },
  {
    "track_name": "Smells Like Teen Spirit",
    "track_popularity": 84,
    "album_year": "1991"
  },
  {
    "track_name": "Thunderstruck",
    "track_popularity": 85,
    "album_year": "1990"
  },
  {
    "track_name": "Wicked Game",
    "track_popularity": 83,
    "album_year": "1989"
  },
  {
    "track_name": "Everywhere",
    "track_popularity": 68,
    "album_year": "1988"
  },
  {
    "track_name": "Sweet Child O' Mine",
    "track_popularity": 87,
    "album_year": "1987"
  },
  {
    "track_name": "There Is a Light That Never Goes Out - 2011 Remaster",
    "track_popularity": 83,
    "album_year": "1986"
  },
  {
    "track_name": "Everybody Wants To Rule The World",
    "track_popularity": 87,
    "album_year": "1985"
  },
  {
    "track_name": "Dancing In the Dark",
    "track_popularity": 82,
    "album_year": "1984"
  },
  {
    "track_name": "Every Breath You Take",
    "track_popularity": 90,
    "album_year": "1983"
  },
  {
    "track_name": "Africa",
    "track_popularity": 86,
    "album_year": "1982"
  },
  {
    "track_name": "Don't Stop Believin' (2022 Remaster)",
    "track_popularity": 83,
    "album_year": "1981"
  },
  {
    "track_name": "Back In Black",
    "track_popularity": 84,
    "album_year": "1980"
  },
  {
    "track_name": "Highway to Hell",
    "track_popularity": 85,
    "album_year": "1979"
  },
  {
    "track_name": "Sultans Of Swing",
    "track_popularity": 83,
    "album_year": "1978"
  },
  {
    "track_name": "The Chain - 2004 Remaster",
    "track_popularity": 86,
    "album_year": "1977"
  },
  {
    "track_name": "Dancing Queen",
    "track_popularity": 84,
    "album_year": "1976"
  },
  {
    "track_name": "Wish You Were Here",
    "track_popularity": 81,
    "album_year": "1975"
  },
  {
    "track_name": "Bohemian Rhapsody - Remastered 2011",
    "track_popularity": 81,
    "album_year": "1975"
  },
  {
    "track_name": "Jolene",
    "track_popularity": 72,
    "album_year": "1974"
  },
  {
    "track_name": "Piano Man",
    "track_popularity": 83,
    "album_year": "1973"
  },
  {
    "track_name": "A Horse with No Name",
    "track_popularity": 81,
    "album_year": "1972"
  },
  {
    "track_name": "Ain't No Sunshine",
    "track_popularity": 81,
    "album_year": "1971"
  },
  {
    "track_name": "Have You Ever Seen The Rain",
    "track_popularity": 85,
    "album_year": "1970"
  },
  {
    "track_name": "Here Comes The Sun - Remastered 2009",
    "track_popularity": 82,
    "album_year": "1969"
  },
  {
    "track_name": "All Along the Watchtower",
    "track_popularity": 74,
    "album_year": "1968"
  },
  {
    "track_name": "White Rabbit",
    "track_popularity": 68,
    "album_year": "1967"
  },
  {
    "track_name": "Paint It, Black",
    "track_popularity": 82,
    "album_year": "1966"
  },
  {
    "track_name": "My Girl",
    "track_popularity": 79,
    "album_year": "1965"
  },
  {
    "track_name": "You Really Got Me",
    "track_popularity": 71,
    "album_year": "1964"
  },
  {
    "track_name": "Surf Rider",
    "track_popularity": 54,
    "album_year": "1963"
  },
  {
    "track_name": "Stand By Me",
    "track_popularity": 77,
    "album_year": "1962"
  },
  {
    "track_name": "Misirlou",
    "track_popularity": 47,
    "album_year": "1960"
  },
  {
    "track_name": "Johnny B. Goode",
    "track_popularity": 74,
    "album_year": "1959"
  },
  {
    "track_name": "I'm A Man",
    "track_popularity": 55,
    "album_year": "1958"
  },
  {
    "track_name": "Alone And Forsaken",
    "track_popularity": 45,
    "album_year": "1952"
  },
  {
    "track_name": null,
    "track_popularity": 0,
    "album_year": "-1"
  }
]
*/