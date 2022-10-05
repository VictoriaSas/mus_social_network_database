
USE mymusic;

#---------------------------------------------------------SELECT-------------------------------------------------------------------------

# Пользователь имя, фамилия, город, страна
SELECT 
	firstname,
	lastname,
	(SELECT name FROM countries WHERE id = (
		SELECT country_id FROM cities WHERE id = (
			SELECT city_id FROM profiles WHERE users_id = users.id
	))) as 'country',
	
	(SELECT name FROM cities WHERE id = (
		SELECT city_id FROM profiles WHERE users_id = users.id
	)) as 'city'
	
FROM users
WHERE id = 1;


# Популярность жанра (сколько раз среди муз. групп встречается каждый из жанров)
SELECT 
	count(*),
	(SELECT name FROM genres WHERE id = performers.genres_id) as 'name genre'
	
FROM performers 
GROUP BY genres_id 


# Топ 3 исполнителя по количеству песен
SELECT 
	count(*) as cnt_of_songs,
	(SELECT name FROM performers WHERE id = performers_songs.performers_id) as 'performer'
	
FROM performers_songs 
GROUP BY performers_id
ORDER BY cnt_of_songs DESC
LIMIT 3;


# Заполнение данных в определенную ячейку
UPDATE profiles 
SET 
	birthday = '1979-09-19'
WHERE users_id = 1;

UPDATE profiles 
SET 
	birthday = '1980-07-31'
WHERE users_id = 2;

UPDATE profiles 
SET 
	birthday = '1980-03-01'
WHERE users_id = 3;

UPDATE profiles 
SET 
	birthday = '1981-08-11'
WHERE users_id = 4;

UPDATE profiles 
SET 
	birthday = '1978-04-01'
WHERE users_id = 5;

UPDATE profiles 
SET 
	birthday = '1978-04-01'
WHERE users_id = 6;

UPDATE profiles 
SET 
	birthday = '1981-02-13'
WHERE users_id = 7;

UPDATE profiles 
SET 
	birthday = '1980-06-05'
WHERE users_id = 8;

UPDATE profiles 
SET 
	birthday = '1980-08-30'
WHERE users_id = 10;


# Вывод пользователей, преобразование гендера, возраст
SELECT
	(SELECT firstname FROM users WHERE id = profiles.users_id) as 'name',
	(SELECT lastname FROM users WHERE id = profiles.users_id) as 'name',
	CASE (gender)
		WHEN '0' THEN 'men'
		WHEN '1' THEN 'female'
	END AS 'gender',
	TIMESTAMPDIFF(year, birthday, now()) as 'age'
	
FROM profiles;


# Вывод списка композиций по исполнителю
SELECT
	(SELECT name FROM performers WHERE id = performers_id) as 'name performer',
	(SELECT name FROM songs WHERE id = songs_id) as 'name song'

FROM performers_songs
WHERE performers_id = 1;


# Вывод несколько исполнителей с песнями в одной таблице
SELECT
	(SELECT name FROM performers WHERE id = performers_id) as 'name performer',
	(SELECT name FROM songs WHERE id = songs_id) as 'name song'
FROM performers_songs
WHERE performers_id = 1
UNION 
SELECT
	(SELECT name FROM performers WHERE id = performers_id) as 'name performer',
	(SELECT name FROM songs WHERE id = songs_id) as 'name song'
FROM performers_songs
WHERE performers_id = 2;


# Вывод списка композиций по жанру
SELECT  
	(SELECT name FROM genres WHERE id = genres_id) as 'name genres',
	performers.name as 'name performer',
-- 	(SELECT performers_songs.songs_id WHERE performers_id = performers.id) as 'id song', # Сопоставляет каждую песню с исполнителем
	(SELECT name FROM songs WHERE id = (
		SELECT performers_songs.songs_id WHERE performers_id = performers.id
	)) as 'name song'
	
FROM performers, performers_songs 
WHERE genres_id = 2 AND (SELECT performers_songs.songs_id WHERE performers_id = performers.id) IS NOT NULL;


# Вывод композиций по подписке
SELECT 
	users.firstname, users.lastname as 'name',
	
	(SELECT name FROM songs WHERE id = (
		SELECT playlists_songs.songs_id WHERE playlists_songs.playlists_id = (
			SELECT playlists_owner_id WHERE subscribers_id = users.id
	))) as 'name song'
	
FROM subscribers, users, playlists_songs
WHERE users.id = 1 
	AND (SELECT playlists_owner_id WHERE subscribers_id = users.id) IS NOT NULL
	AND (SELECT playlists_songs.songs_id WHERE playlists_songs.playlists_id = (
		SELECT playlists_owner_id WHERE subscribers_id = users.id
	)) IS NOT NULL;



#---------------------------------------------------------JOIN-------------------------------------------------------------------------


# Пользователь имя, фамилия, город, страна
SELECT 
	firstname,
	lastname,
	countries.name as 'country',
	cities.name as 'city'
	
FROM users
JOIN profiles ON profiles.users_id = users.id 
JOIN cities ON profiles.city_id = cities.id
JOIN countries ON cities.country_id = countries.id 
WHERE users.id = 1; 


# Популярность жанра (сколько раз среди муз. групп встречается каждый из жанров)
SELECT 
	count(*),
	genres.name as 'name genre'
	
FROM performers 
JOIN genres ON performers.genres_id = genres.id
GROUP BY genres_id 


# Топ 3 исполнителя по количеству песен
SELECT 
	count(*) as cnt_of_songs,
	performers.name as 'performer'
	
FROM performers_songs 
JOIN performers ON performers_songs.performers_id = performers.id 
GROUP BY performers_id
ORDER BY cnt_of_songs DESC
LIMIT 3;


# Вывод пользователей, преобразование гендера, возраст
SELECT
	users.firstname as 'firstname',
	users.lastname as 'lastname',
	CASE (gender)
		WHEN '0' THEN 'men'
		WHEN '1' THEN 'female'
	END AS 'gender',
	TIMESTAMPDIFF(year, birthday, now()) as 'age'
	
FROM profiles
JOIN users ON profiles.users_id = users.id ;


# Вывод списка композиций по исполнителю
SELECT
	performers.name as 'name performer',
	songs.name as 'name song'

FROM performers_songs
JOIN performers ON performers_songs.performers_id = performers.id 
JOIN songs ON performers_songs.songs_id = songs.id 
WHERE performers_songs.performers_id = 1;


# Вывод несколько исполнителей с песнями в одной таблице
SELECT
	performers.name as 'name performer',
	songs.name as 'name song'
FROM performers_songs
JOIN performers ON performers_songs.performers_id = performers.id 
JOIN songs ON performers_songs.songs_id = songs.id 
WHERE performers_songs.performers_id = 1
UNION 
SELECT
	performers.name as 'name performer',
	songs.name as 'name song'
FROM performers_songs
JOIN performers ON performers_songs.performers_id = performers.id 
JOIN songs ON performers_songs.songs_id = songs.id 
WHERE performers_songs.performers_id = 2;


# Вывод списка композиций по жанру
SELECT  
	genres.name as 'name genres',
	performers.name as 'name performer',
	songs.name as 'name song'
	
FROM performers 
JOIN genres ON performers.genres_id = genres.id 
JOIN performers_songs ON performers.id = performers_songs.performers_id 
JOIN songs ON performers_songs.songs_id = songs.id 
WHERE (genres_id = 2) AND (performers_songs.songs_id IS NOT NULL);


# Вывод композиций по подписке
SELECT 
	users.firstname, users.lastname as 'name',
	songs.name as 'name song'
	
FROM users
JOIN subscribers ON users.id = subscribers.subscribers_id 
JOIN playlists_songs ON subscribers.playlists_owner_id = playlists_songs.playlists_id
JOIN songs ON playlists_songs.songs_id = songs.id 
WHERE (users.id = 1) 
	AND (subscribers.playlists_owner_id IS NOT NULL)
	AND (playlists_songs.songs_id IS NOT NULL);


# Вывод композиций по подписке расширенный вариант
SET @users_id_for_compilation = 1; # Hermione

SELECT 
	users.firstname, users.lastname as 'name',
	performers.name as 'name performer',
	songs.name as 'name song',
	playlists.name as 'playlists name'
	
FROM users
JOIN subscribers ON users.id = subscribers.subscribers_id 
JOIN playlists_songs ON subscribers.playlists_owner_id = playlists_songs.playlists_id
JOIN songs ON playlists_songs.songs_id = songs.id 
JOIN performers_songs ON songs.id = performers_songs.songs_id 
JOIN performers ON performers_songs.performers_id = performers.id 
JOIN playlists ON subscribers.playlists_owner_id = playlists.id 
WHERE (users.id = @users_id_for_compilation) 
	AND (subscribers.playlists_owner_id IS NOT NULL)
	AND (playlists_songs.songs_id IS NOT NULL)
ORDER BY performers.name;


# Вывод любимого исполнителя
SET @users_id_for_compilation = 1; # Hermione

SELECT 
	# performers.id
	performers.name as name
		
FROM performers_songs 
JOIN performers ON performers_songs.performers_id = performers.id 
JOIN songs ON performers_songs.songs_id = songs.id 
JOIN playlists_songs ON songs.id = playlists_songs.songs_id 
JOIN playlists ON playlists_songs.playlists_id = playlists.id 
JOIN profiles ON playlists.users_id = profiles.users_id 
JOIN users ON profiles.users_id = users.id 
WHERE users.id = @users_id_for_compilation
GROUP BY performers_id
ORDER BY count(*) DESC
LIMIT 1;


















