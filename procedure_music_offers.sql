USE mymusic;


DROP PROCEDURE IF EXISTS music_offers;

DELIMiTER //

CREATE PROCEDURE music_offers(for_user_id BIGINT UNSIGNED)
BEGIN
	
	((SELECT # Песни по подписке
		prf.name as 'performer',
		songs.name as 'song'	
	FROM users
	JOIN subscribers sub ON users.id = sub.subscribers_id 
	JOIN playlists_songs pls ON sub.playlists_owner_id = pls.playlists_id
	JOIN songs ON pls.songs_id = songs.id 
	JOIN performers_songs prfs ON songs.id = prfs.songs_id 
	JOIN performers prf ON prfs.performers_id  = prf.id 
		WHERE (users.id = 5) 
		AND (sub.playlists_owner_id IS NOT NULL)
		AND (pls.songs_id IS NOT NULL)
	ORDER BY prf.name)
	
	UNION
	
	(SELECT # Песни любимого исполнителя
		prf.name as 'performer',
		songs.name as 'song'
	FROM songs
	JOIN performers_songs prfs ON songs.id = prfs.songs_id
	JOIN performers prf ON prfs.performers_id  = prf.id 
	WHERE prf.id = (
		SELECT 
			prf.id			
		FROM performers_songs prfs
		JOIN performers prf ON prfs.performers_id = prf.id 
		JOIN songs ON prfs.songs_id = songs.id 
		JOIN playlists_songs pls ON songs.id = pls.songs_id 
		JOIN playlists pl ON pls.playlists_id = pl.id 
		JOIN profiles pf ON pl.users_id = pf.users_id 
		JOIN users ON pf.users_id = users.id 
		WHERE users.id = 5
		GROUP BY performers_id
		ORDER BY count(*) DESC
		LIMIT 1)))
		
	UNION
	
	(SELECT # Песни жанра любимого исполнителя
		prf.name as 'performer',
 		songs.name as 'song'
	FROM songs
	JOIN performers_songs prfs ON songs.id = prfs.songs_id
	JOIN performers prf ON prfs.performers_id  = prf.id 
	JOIN genres g ON prf.genres_id = g.id 
	WHERE g.id  = (
		SELECT 
			g.id			
		FROM genres g
		JOIN performers prf ON g.id  = prf.genres_id 
		JOIN performers_songs prfs ON prf.id = prfs.performers_id 
		JOIN songs ON prfs.songs_id = songs.id 
		JOIN playlists_songs pls ON songs.id = pls.songs_id 
		JOIN playlists pl ON pls.playlists_id = pl.id 
		JOIN profiles pf ON pl.users_id = pf.users_id 
		JOIN users ON pf.users_id = users.id 
		WHERE users.id = 5
		GROUP BY performers_id
		ORDER BY count(*) DESC
		LIMIT 1))
	ORDER BY rand()
	LIMIT 5;
	
END//

DELIMiTER ;

CALL music_offers(5);





















