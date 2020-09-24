/* Query 1. What are the last names and emails of all customer who made purchased in the store?*/ 
   SELECT DISTINCT c.LastName, c.Email
   FROM customers c , invoices i
   WHERE c.CustomerId = i.CustomerId;


/*Query 2.What are the names of each albums and the artist who created it?*/
  SELECT DISTINCT albums.Title 'Album Title', artists.Name 'Artist'
  FROM albums , artists
  WHERE albums.ArtistId = artists.ArtistId;

/*3.What are the total number of unique customers for each state, ordered alphabetically by state?*/ 
  SELECT customers.State, COUNT(CustomerId) 'Cusomer count'
  FROM customers 
  WHERE customers.state IS NOT NULL
  GROUP BY customers.state
  ORDER BY customers.state;
		
/*4.Which states have more than 10 unique customers customers?*/ 
 SELECT customers.State
 FROM customers
 WHERE customers.state IS NOT NULL 
 GROUP BY customers.state
 HAVING COUNT(CustomerID)>10;

/*5.What are the names of the artists who made an album containing the substring "symphony" in the album title?*/ 
 SELECT artists.Name 'Artist'
 FROM artists,albums
 WHERE artists.ArtistId=albums.ArtistId
 AND albums.Title LIKE '%symphony%';

/*6.What are the names of all artists who performed MPEG (video or audio) tracks in the "Brazilian Music" and "Grunge" playlists?*/ 
 SELECT DISTINCT artists.name 'Artist'
 FROM playlists, playlist_track,tracks,media_types,albums,artists
 WHERE playlists.Name IN ('Grunge','Brazilian Music')
 AND media_types.Name LIKE '%MPEG%'
 AND playlists.PlaylistId= playlist_track.PlaylistId
 AND playlist_track.TrackId=tracks.TrackId
 AND tracks.MediaTypeId=media_types.MediaTypeId
 AND tracks.AlbumId=albums.AlbumId
 AND artists.ArtistId=albums.ArtistId

/*7.How many artists published at least 10 MPEG tracks?*/ 
 SELECT count(artists.Name) 'Artist Count'
 FROM artists 
 WHERE artists.name IN(
 SELECT  artists.Name
 FROM tracks,media_types,albums,artists
 WHERE media_types.name LIKE '%MPEG%'
 AND media_types.MediaTypeId=tracks.MediaTypeId
 AND tracks.AlbumId=albums.AlbumId
 AND artists.ArtistId=ALBUMS.ArtistId
 GROUP BY artists.Name
 HAVING COUNT(media_types.MediaTypeId)>=10
 );


/*8.What is the total length of each playlist in hours? List the playlist id and name of only those playlists that are longer than 2 hours, along with the length in hours rounded to two decimals.*/ 
 SELECT ROUND(SUM(tracks.Milliseconds)/1000.0/60.0/60.0,2) 'Length in  Hours',playlist_track.PlaylistId 'PlaylistID', playlists.Name 'Playlist  Name'
 FROM tracks, playlist_track, playlists
 WHERE 
 playlists.PlaylistId=playlist_track.PlaylistId
 AND playlist_track.TrackId=tracks.TrackId
 GROUP BY playlist_track.PlaylistId
 HAVING SUM(tracks.Milliseconds)/1000.0/60.0/60.0>2;











