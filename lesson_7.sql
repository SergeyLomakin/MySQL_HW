-- Составьте список пользователей users, 
-- которые осуществили хотя бы один заказ orders в интернет магазине.
SELECT name FROM users WHERE id IN (
	SELECT user_id FROM orders
);


-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT 
	products.name AS product, 
	catalogs.name
FROM products JOIN catalogs
ON products.catalog_id = catalogs.id;


/* Пусть имеется таблица рейсов flights (id, from, to) и 
 * таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.*/
SELECT id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM flights;




