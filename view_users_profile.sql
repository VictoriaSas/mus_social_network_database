USE mymusic;

DROP VIEW IF EXISTS users_profile;

CREATE VIEW users_profile AS
	SELECT 
		id,
		firstname,
		lastname,
		(SELECT name FROM countries WHERE id = (
			SELECT country_id FROM cities WHERE id = (
				SELECT city_id FROM profiles WHERE users_id = users.id
		))) as 'country',
		
		(SELECT name FROM cities WHERE id = (
			SELECT city_id FROM profiles WHERE users_id = users.id
		)) as 'city'
		
	FROM users;
	

SELECT *
FROM users_profile
WHERE id > 2 AND id < 6














