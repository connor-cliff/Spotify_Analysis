/* return a row for each years from 2009 to 2025 with the most popular track.
Will need to join tracks to albums ot get the date.
must extract year from date
*/

SELECT album_release_date::DATE
FROM albums
WHERE EXTRACT
LIMIT 100;
