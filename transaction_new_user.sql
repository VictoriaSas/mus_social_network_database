START TRANSACTION;
	INSERT INTO users(firstname, lastname, niсkname, email, phone, password_hash)
	VALUES ('New', 'User', 'wizard', 'wizard@hogwarts.net', 0007, '134679');
	
	SET @new_users_id = LAST_INSERT_ID();
	
	INSERT INTO profiles(users_id, city_id)
	VALUES (@new_users_id, 4);	
	
COMMIT;

SELECT * FROM users ORDER BY id DESC;
SELECT * FROM profiles ORDER BY users_id DESC;
# Если не будет ошибок

