use vk;


/* Пусть задан некоторый пользователь. 
 * Из всех пользователей соц. сети найдите человека, 
 * который больше всех общался с выбранным пользователем (написал ему сообщений).*/
SELECT 
	CONCAT(firstname,' ',lastname) AS name 
FROM 
	users 
WHERE 
	id = (
	SELECT from_user_id FROM messages WHERE to_user_id = 1 
	GROUP BY from_user_id ORDER BY COUNT(*) DESC LIMIT 1
);

-- с использованием переменной
SET @user_id_from_messages = (
	SELECT from_user_id FROM messages WHERE to_user_id = 1 
	GROUP BY from_user_id ORDER BY COUNT(*) DESC LIMIT 1
);
SELECT firstname, lastname FROM users WHERE id = @user_id_from_messages;


-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
/* Возможно я что-то упустил, но в моей БД у пользователей лайков нет,
 * поэтому сделал количество поставленных лайков пользователями младше 10 лет*/

SELECT COUNT(*) AS likes_quantity FROM likes WHERE user_id IN (
	SELECT user_id FROM profiles WHERE birthday > NOW() - INTERVAL 10 YEAR
);


-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT 'M' AS gender, COUNT(*) AS quantity 
FROM likes 
WHERE user_id IN (
	SELECT user_id FROM profiles WHERE gender = 'M'
)
UNION
SELECT 'W' AS gender, COUNT(*) AS quantity  
FROM likes 
WHERE user_id IN (
	SELECT user_id FROM profiles WHERE gender = 'W'
)
ORDER BY gender DESC LIMIT 1;
/* Вопрос 1: НА сколько читабельна запись? 
 * Там где SELECT 'M' AS gender, COUNT(*) AS quantity - можно оставить так или надо
 * SELECT 
 * 		'M' AS gender, 
 * 		COUNT(*) AS quantity 
 * нужен ли перенос строки с табуляцией? Как принято оформлять?
 * 
 * Вопрос 2: Не получилось сделать чтобы в поле gender 
 * вместо М или W выводилось Mens или Womens, 
 * хотел сделать конструкцией 
 * CASE (gender)
	WHEN 'M' THEN 'Mens'
	WHEN 'W' THEN 'Womens';
 * после ORDER BY gender DESC LIMIT 1, но получал ошибку, 
 * так и не понял где эту конструкцию правильно размещать
 * или при таком запросе она вобще не уместна?*/



