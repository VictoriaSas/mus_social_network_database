# DDL-команды. Создают структуру бд

DROP DATABASE IF EXISTS mymusic;
CREATE DATABASE mymusic;
USE mymusic;


DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	# большой инт, неотрицательный, не может отсутствовать значение, заполняется автомат. от самого большого знач., первичный ключ
	# BIGINT UNSIGNED NOT NULL AUTO_INCREMENT INIQUE = SERIAL
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	niсkname VARCHAR(100) NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL UNIQUE,
	phone BIGINT UNSIGNED NOT NULL UNIQUE, 
	password_hash VARCHAR(256) NOT NULL,
	
	INDEX users_nickname(niсkname)
	
)COMMENT 'Пользователи';


DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE
		
)COMMENT 'Страны';


# 1 x M
DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
	id SERIAL,
	name VARCHAR(100) NOT NULL,
	country_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY cities_country (id, country_id),
	FOREIGN KEY (country_id) REFERENCES countries(id)
	
)COMMENT 'Города';


# 1 x 1 - profiles-users
# 1 x M - profiles-cities
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	users_id BIGINT UNSIGNED NOT NULL UNIQUE, 
	city_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	gender CHAR(1),
	birthday DATE,
	
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (city_id) REFERENCES cities(id)

)COMMENT 'Профили пользователей';


# 1 x 1
DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists(
	id SERIAL,
	name VARCHAR(100) NOT NULL,
	users_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (users_id) REFERENCES profiles(users_id)
		
)COMMENT 'Плейлисты';


/*ALTER TABLE profiles ADD CONSTRAINT user_id_refnces_id
# Редактирование таблицы profiles, добавить ограничение (название)
FOREIGN KEY (user_id) REFERENCES user(id)
# Внешний ключ из таблицы (user_id) ссылается на таблицу user на ключ id*/


# 1 x 1
DROP TABLE IF EXISTS genres;
CREATE TABLE genres(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	creat_year YEAR,
	
	INDEX genres_names (name)
	
)COMMENT 'Муз. жанры';


DROP TABLE IF EXISTS musicians;
CREATE TABLE musicians(
	id SERIAL,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	birtday DATE,
	beginning_career YEAR,
	gender CHAR(1),
	profession VARCHAR(255) NOT NULL,
	
	INDEX musicians_firstname_lastname (firstname, lastname)
	
)COMMENT 'Музыканты (в проектах - "исполнителях")';


# 1 x 1 #country
# 1 x M #genres
DROP TABLE IF EXISTS performers;
CREATE TABLE performers(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	genres_id BIGINT UNSIGNED NOT NULL,
	country_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(100) NOT NULL UNIQUE,
	description VARCHAR(255),
	creat_year YEAR,
	
	INDEX performers_name (name),
	FOREIGN KEY (genres_id) REFERENCES genres(id),
	FOREIGN KEY (country_id) REFERENCES countries(id)

)COMMENT 'Исполнители';


# 1 x M
DROP TABLE IF EXISTS mus_albums;
CREATE TABLE mus_albums(
	id SERIAL,
	performers_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(100) NOT NULL,
	creat_year YEAR,
	
	INDEX mus_album_name (name),
	FOREIGN KEY (performers_id) REFERENCES performers(id)

)COMMENT 'Муз. альбомы';


# 1 x M 
DROP TABLE IF EXISTS songs;
CREATE TABLE songs(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	mus_albums_id BIGINT UNSIGNED NOT NULL,
	filename_lirystics VARCHAR (255), 		# путь до текста песни
	filename_songs VARCHAR (255) NOT NULL,		# путь до файла песни
	
	INDEX song_name (name),
	FOREIGN KEY (mus_albums_id) REFERENCES mus_albums(id)

)COMMENT 'Песни';


# 1 x M
DROP TABLE IF EXISTS concerts;
CREATE TABLE concerts(
	id SERIAL,
	city_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(100) NOT NULL,
	place VARCHAR(255) NOT NULL,
	price TINYINT UNSIGNED NOT NULL,
	concerts_date DATETIME NOT NULL,

	FOREIGN KEY (city_id) REFERENCES cities(id)
	
)COMMENT 'Концерты';


# M x M
DROP TABLE IF EXISTS performers_and_musicians;
CREATE TABLE performers_and_musicians(
	performers_id BIGINT UNSIGNED NOT NULL,
	musicians_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (performers_id, musicians_id),
	FOREIGN KEY (performers_id) REFERENCES performers(id),
	FOREIGN KEY (musicians_id) REFERENCES musicians(id)

)COMMENT 'Связь исполнителей и их музыкантов';


# M x M
DROP TABLE IF EXISTS performers_songs;
CREATE TABLE performers_songs(
	performers_id BIGINT UNSIGNED NOT NULL,
	songs_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (performers_id, songs_id),
	FOREIGN KEY (performers_id) REFERENCES performers(id),
	FOREIGN KEY (songs_id) REFERENCES songs(id)
		
)COMMENT 'Связь песен и исполнителей';


# M x M
DROP TABLE IF EXISTS playlists_songs;
CREATE TABLE playlists_songs(
	playlists_id BIGINT UNSIGNED NOT NULL,
	songs_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (playlists_id, songs_id),
	FOREIGN KEY (playlists_id) REFERENCES playlists(id),
	FOREIGN KEY (songs_id) REFERENCES songs(id)
	
)COMMENT 'Связь плейлистов и песен';


# M x M
DROP TABLE IF EXISTS concerts_performers;
CREATE TABLE concerts_performers(
	performers_id BIGINT UNSIGNED NOT NULL,
	concerts_id BIGINT UNSIGNED NOT NULL,

	PRIMARY KEY (performers_id, concerts_id),
	FOREIGN KEY (performers_id) REFERENCES performers(id),
	FOREIGN KEY (concerts_id) REFERENCES concerts(id)
	
)COMMENT 'Связь исполнителей и концертов';

# M x M
DROP TABLE IF EXISTS genres_countries;
CREATE TABLE genres_countries(
	genres_id BIGINT UNSIGNED NOT NULL,
	countries_id BIGINT UNSIGNED NOT NULL,

	PRIMARY KEY (genres_id, countries_id),
	FOREIGN KEY (genres_id) REFERENCES genres(id),
	FOREIGN KEY (countries_id) REFERENCES countries(id)
	
)COMMENT 'Связь жанров и стран возникновения';


DROP TABLE IF EXISTS subscribers;
CREATE TABLE subscribers(
	subscribers_id BIGINT UNSIGNED NOT NULL,
	playlists_owner_id BIGINT UNSIGNED NOT NULL,

	PRIMARY KEY (subscribers_id, playlists_owner_id),
	FOREIGN KEY (subscribers_id) REFERENCES profiles(users_id),
	FOREIGN KEY (playlists_owner_id) REFERENCES profiles(users_id),
	CHECK (subscribers_id <> playlists_owner_id)
	
)COMMENT 'Связь подписчиков'












