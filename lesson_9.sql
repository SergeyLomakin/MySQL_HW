/* В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
 * Используйте транзакции.*/
START TRANSACTION;
	INSERT INTO sample.users (SELECT * FROM shop.users WHERE id = 1);
	DELETE FROM shop.users WHERE id = 1;
COMMIT;


/* Создайте представление, которое выводит название name товарной позиции 
 * из таблицы products и соответствующее название каталога name из таблицы catalogs.*/
DROP VIEW IF EXISTS accessories;
CREATE VIEW accessories (product, `type`) AS (
	SELECT 
		p.name AS product, 
		c.name AS `type` 
	FROM products p
	JOIN catalogs c 
	ON p.catalog_id = c.id);


/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
 * в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 * с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/
DROP FUNCTION IF EXISTS hello;
DELIMITER //

CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	IF HOUR(NOW()) >= 6 AND HOUR(NOW()) < 12 THEN 
		RETURN 'Доброе утро';
	ELSEIF HOUR(NOW()) >= 12 AND HOUR(NOW()) < 18 THEN 
		RETURN 'Добрый день';
	ELSEIF HOUR(NOW()) >= 18 AND HOUR(NOW()) < 24 THEN 
		RETURN 'Добрый вечер';
	ELSE
		RETURN 'Доброй ночи';
	END IF;
END//

DELIMITER ;
SELECT hello();


/* В таблице products есть два текстовых поля: 
 * name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. 
 * Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.*/
-- ВАЖНО - НЕ РАБОТАЕТ, ПЕРЕБРАЛ МНОГО ВАРИАНТОВ. НЕ ПОНИМАЮ, ПОЧЕМУ? 
DELIMITER //

DROP TRIGGER IF EXISTS check_product_insert//
CREATE TRIGGER check_product_insert 
BEFORE INSERT 
ON products FOR EACH ROW
BEGIN
	IF NEW.name <=> NULL OR NEW.description <=> NULL THEN 
		SIGNAL SQLSTATE '45000' SET MASSAGE_TEXT = "name or description can`t be null";
	END IF;
END//

DROP TRIGGER IF EXISTS check_product_update//
CREATE TRIGGER check_product_update 
BEFORE UPDATE 
ON products FOR EACH ROW
BEGIN
	IF NEW.name <=> NULL OR NEW.description <=> NULL THEN  
		SIGNAL SQLSTATE '45000' SET MASSAGE_TEXT = "name or description can`t be null";
	END IF;
END//

DELIMITER ;














