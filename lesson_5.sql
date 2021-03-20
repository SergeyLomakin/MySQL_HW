/* Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.*/
UPDATE users SET created_at = NOW(), update_at = NOW();

-- Вариант, если есть заполненные поля, но не все
UPDATE users SET created_at = NOW(), update_at = NOW()
WHERE created_at <=> NULL OR update_at <=> NULL;


/* Таблица users была неудачно спроектирована. 
 * Записи created_at и updated_at были заданы типом VARCHAR 
 * и в них долгое время помещались значения в формате "20.10.2017 8:10". 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.*/
ALTER TABLE users ADD COLUMN created_at_new DATETIME, ADD COLUMN update_at_new DATETIME;
UPDATE users 
SET created_at_new = STR_TO_DATE(created_at, '%d.%m.%Y %l:%i'),
	update_at_new = STR_TO_DATE(update_at, '%d.%m.%Y %l:%i');
ALTER TABLE users
	DROP created_at, DROP update_at,
	RENAME COLUMN created_at_new TO created_at,
	RENAME COLUMN update_at_new TO update_at;


/* В таблице складских запасов storehouses_products в поле value 
 * могут встречаться самые разные цифры: 
 * 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, 
 * чтобы они выводились в порядке увеличения значения value. 
 * Однако, нулевые запасы должны выводиться в конце, после всех записей.*/
SELECT id, name, value FROM storehouses_products ORDER BY IF(value = 0, 1, 0), value;
-- запутался с IF (Условие, Выполняется если истина, Выполняется если ложно)
-- немного не понимаю как работает, но работает


/* Подсчитайте средний возраст пользователей в таблице users */
SELECT AVG(age) FROM users;
-- от ДР, наверное как-то не читабельно
SELECT ROUND(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday)) / 365.25), 2) age FROM users;


/* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

-- Перепробовал много вариантов, но не смог решить, отправляю так, время поджимает
-- Решение в интернете нашел, но не охота тупо переписывать.




