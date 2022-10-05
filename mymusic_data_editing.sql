# DML-команды. Редактируют бд

USE mymusic;

ALTER TABLE users AUTO_INCREMENT=1;

INSERT INTO users(firstname, lastname, niсkname, email, phone, password_hash)
VALUES
('Hermione', 'Granger', 'gryffindor1', 'gryffindor1@hogwarts.net', '8178918682888778', '12Hb9ec7098bhkQ'),
('Harry', 'Potter', 'gryffindor2', 'gryffindor2@hogwarts.net', '8174919198', 'harry310780'),
('Ronald', 'Weasly', 'gryffindor3', 'gryffindor3@hogwarts.net', '918887748577', '123456789'),
('Ginevra', 'Weasly', 'gryffindor4', 'gryffindor4@hogwarts.net', '80828778959174','quidditch'),
('Fred', 'Weasly', 'gryffindor5', 'gryffindor5@hogwarts.net', '79917877', 'WeasleysWizardWheezes'),
('George', 'Weasly', 'gryffindor6', 'gryffindor6@hogwarts.net', '807888918078', 'sezeehWdraziWsyelsaeW'),
('Luna', 'Lovegood', 'ravenclaw1', 'ravenclaw1@hogwarts.net', '85948774', 'wrackspurts'),
('Draco', 'Malfoy', 'slytherin1', 'slytherin1@hogwarts.net', '7791747688', 'apple'),
('Lavander', 'Brown', 'gryffindor7', 'gryffindor7@hogwarts.net', '8574957487777891', '010380Ron'),
('Neville', 'Longbottom', 'gryffindor8', 'gryffindor8@hogwarts.net', '87789582858578', 'herbology');


INSERT INTO countries(name)
VALUES
('USA'),
('Great Britain'),
('Canada'),
('Russia');


INSERT INTO cities(country_id, name)
VALUES
('4', 'Moscow'),
('4', 'Saint Petersburg'),
('2', 'London'),
('2', 'Liverpool'),
('1', 'Washington'),
('1', 'New York City'),
('3', 'Ottawa'),
('3', 'Toronto');


INSERT INTO profiles(users_id, city_id, gender)
VALUES
('1', '3', '1'),
('2', '3', '0'),
('3', '3', '0'),
('4', '3', '1'),
('5', '3', '0'),
('6', '3', '0'),
('7', '3', '1'),
('8', '3', '0'),
('9', '3', '1'),
('10', '3', '0');


INSERT INTO playlists(users_id, name)
VALUES
('1','Hermiones_playlist'),
('2','Harrys_playlist'),
('3','Ronalds_playlist'),
('4','Ginevras_playlist'),
('5','Freds_playlist'),
('6','Georges_playlist'),
('7','Lunas_playlist'),
('8','Dracos_playlist'),
('9','Lavanders_playlist'),
('10','Nevilles_playlist');


INSERT INTO genres(name, creat_year)
VALUES
('Grunge','1990'),
('Alternative rock','1980'),
('Punk rock','1974'),
('Hard rock','1960'),
('Heavy metal','1980'),
('Indie rock','1980');


INSERT INTO musicians(firstname, lastname, birtday, beginning_career, gender, profession)
VALUES
('Jerry','Cantrell','1966-03-18','1985','0','singer, composer, guitar player'),
('Michael','Inez','1966-05-14','1991','0','bass guitar player'),
('Sean','Kinney','1966-05-27','1978','0','drummer'),
('William','DuVall','1967-09-06','1983','0','singer, composer, guitar player'),
('Layne','Staley','1967-08-22','1984','0','singer, composer, guitar player'),
('Michael','Starr','1966-04-04','1983','0','bass guitar player'),
('Kurt','Cobain','1967-02-20','1987','0','singer, composer, guitar player'),
('Krist','Novoselic','1965-05-16','1987','0','bass guitar player, guitar player'),
('David','Grohl','1969-01-14','1981','0','guitar player, drummer'),
('Saul','Hudson','1965-07-23','1981','0','guitar player, music producer'),
('Fear Terry','Lee','1971-09-07','1987','0','composer, guitar player'),
('Matt','Laug','1968-03-17','1987','0','drummer'),
('Frank','Iommi','1948-02-19','1964','0','musician'),
('John','Osbourne','1948-12-03','1964','0','musician'),
('Terence','Butler','1949-06-17','1966','0','musician'),
('William','Ward','1948-05-05','1966','0','musician, composer'),
('Brandon','Flowers','1981-06-21','1966','0','musician, composer'),
('David','Keuning','1976-03-28','2001','0','composer, guitar player'),
('Ronald','Vannucci','1976-02-15','2002','0','musician, composer');


INSERT INTO performers(genres_id, country_id, name, creat_year)
VALUES
('1','1','Nirvana','1987'),
('2','1','Alice in Chains','1987'),
('4','1','Slash`s Snakepit','1993'),
('5','2','Black Sabath','1968'),
('2','1','The Killers','2001');


INSERT INTO mus_albums(performers_id, name, creat_year)
VALUES
('1','Nirvana','2002'),
('1','With the Lights Out','2004'),
('1','Sliver: The Best of the Box','2005'),
('2','Dirt','1992'),
('2','Alice in Cains','1995'),
('3','Aint`t Life Grand','2000'),
('4','Never Say Die!','1978'),
('4','Technical Ecstasy','1976'),
('5','Hot Fuss','2004'),
('5','Battle Born','2012');


INSERT INTO songs(mus_albums_id, name, filename_songs)
VALUES
('1','Smells Like Teen Spirit', ' '),
('1','You Know You`re Right', ' '),
('2','Pen Cap Chew', ' '),
('2','If You Must', ' '),
('3','About a Girl', '  '),
('3','Heartbreaker', ' '),
('4','Angry Chair', ' '),
('4','Would?', ' '),
('5','Brush Away', ' '),
('5','Grind', ' '),
('6','Just Like Anything', ' '),
('6','Shine', ' '),
('7','Never Say Die', ' '),
('7','A Hard Road', ' '),
('8','Dirty Women', ' '),
('8','It`s Alright', ' '),
('9', 'Mr. Brightside', ' '),
('9', 'Somebody Told Me', ' '),
('10', 'Runaways', ' '),
('10', 'Flesh and Bone', ' ');


INSERT INTO concerts(city_id, name, place, price, concerts_date) # price in $
VALUES
('3', 'Nirvana in London', 'The 02 Arena', '100', '1993-03-15 19:00:00'), 
('6', 'Nirvana in New York', 'Carnegie Hall', '100', '1993-04-15 19:00:00'), 
('5', 'Alice in Chains in Washington', 'Arena Stage', '100', '1995-03-15 19:00:00'), 
('3', 'Black Sabath in London', 'The 02 Arena', '100', '1997-03-15 19:00:00'),
('6', 'Black Sabath in New York', 'Carnegie Hall', '100', '1997-04-15 19:00:00'),
('8', 'Black Sabath in Toronto', 'Budweiser Stage', '100', '1997-05-15 19:00:00'); 


INSERT INTO performers_and_musicians(performers_id, musicians_id)
VALUES
('1', '7'), # Nirvana
('1', '8'),
('1', '9'),

('2', '1'), # AiC
('2', '2'),
('2', '3'),
('2', '4'),
('2', '5'),
('2', '6'),

('3', '10'), # SS
('3', '11'),
('3', '12'),
('3', '2'),

('4', '13'), # BS
('4', '14'),
('4', '15'),
('4', '16'),

('5', '17'), # TK
('5', '18'),
('5', '19');


INSERT INTO performers_songs(performers_id, songs_id)
VALUES
('1', '1'), # Nirvana
('1', '2'),
('1', '3'),
('1', '4'),
('1', '5'),
('1', '6'),

('2', '7'), # AiC
('2', '8'),
('2', '9'), 
('2', '10'),

('3', '11'), # SS
('3', '12'),

('4', '13'), # BS
('4', '14'),
('4', '15'),
('4', '16'),

('5', '17'), # TK
('5', '18'),
('5', '19'),
('5', '20');


INSERT INTO playlists_songs(playlists_id, songs_id)
VALUES
('1', '1'), # Nirvana
('3', '1'), 
('8', '1'), 
('1', '2'),
('3', '2'),
('2', '2'),
('4', '2'),
('1', '3'),
('8', '3'),
('5', '3'),
('6', '3'),
('1', '4'),
('7', '4'),
('1', '5'),
('3', '5'),
('9', '5'),
('10', '6'),
('1', '6'),
('4', '6'),

('6', '7'), # AiC
('7', '7'),
('3', '7'),
('2', '8'),
('10', '8'),
('6', '9'), 
('7', '9'), 
('8', '9'),
('1', '10'),
('4', '10'),
('5', '10'),

('3', '11'), # SS
('3', '12'),
('8', '12'),

('4', '13'), # BS
('1', '13'),
('7', '13'),
('4', '14'),
('8', '14'),
('9', '14'),
('4', '15'),
('1', '15'),
('4', '16'),
('6', '16'),

('1', '17'), # TK
('3', '17'),
('5', '17'),
('8', '17'),
('1', '18'),
('6', '18'),
('10', '18'),
('5', '19'),
('8', '19'),
('2', '20'),
('5', '20');


INSERT INTO concerts_performers(performers_id, concerts_id)
VALUES
('1', '1'),
('1', '2'),
('2', '2'), 
('4', '4'),
('4', '5'),
('4', '6');


INSERT INTO genres_countries(genres_id, countries_id)
VALUES
('1', '1'),

('2', '1'),
('2', '2'), 

('3', '1'),
('3', '2'),

('4', '1'),
('4', '2'),

('5', '2'),

('6', '1'),
('6', '2'),
('6', '3');

INSERT INTO subscribers (subscribers_id, playlists_owner_id)
VALUES
('1', '2'),
('1', '4'),

('2', '1'),
('2', '3'), 
('2', '4'),


('3', '1'),
('3', '2'),
('3', '5'),
('3', '6'),

('4', '1'),
('4', '2'),

('5', '6'),
('6', '5'),

('7', '10'),
('10', '7');


ALTER TABLE countries 
ADD COLUMN languages VARCHAR(100)
AFTER name;

UPDATE countries
SET
	languages = 'English'
WHERE id = 1 OR id = 2 OR id = 3
;

UPDATE countries
SET
	languages = 'Russian'
WHERE id = 4	
;



















