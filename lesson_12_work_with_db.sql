use stocks_market;

--  Список акций в алфавитном порядке с указание сектора
SELECT 
	st.name AS stock, 
	se.name AS sector 
FROM stocks st
	JOIN sectors se 
	JOIN info i ON se.id = i.sector_id AND st.id = i.stock_id
ORDER BY stock;

-- Количество акций по секторам
SELECT 
	se.name AS sector,
	COUNT(*) AS quantity
FROM stocks st
	JOIN sectors se 
	JOIN info i ON se.id = i.sector_id AND st.id = i.stock_id
GROUP BY sector;

-- Список акций без выплат дивидендов
SELECT s.name AS stock 
FROM stocks s 
WHERE s.id NOT IN (
	SELECT stock_id FROM dividends
);

-- Крупнейшие сделки в рублях
SELECT 
	s.name AS stock, 
	(d.price * d.volume) AS big_deals,
	d.`datetime`,
	d.operation 
FROM deal d
JOIN stocks s ON s.id = d.stock_id
ORDER BY big_deals DESC 
LIMIT 10;

-- Представление, показывает минимальную и максимальную цены по акциям
CREATE OR REPLACE VIEW min_max_price AS
SELECT 
	s.name AS stock, 
	MIN(d.price) AS `min_price`,
	MAX(d.price) AS `max_price`
FROM deal d
JOIN stocks s ON s.id = d.stock_id
GROUP BY stock;

SELECT * FROM min_max_price;

-- Сделки за последний год
CREATE OR REPLACE VIEW deals_last_year AS
SELECT s.name, d.`datetime`, d.price, d.volume, d.operation 
FROM deal d 
JOIN stocks s ON s.id = d.stock_id 
WHERE d.`datetime` > (CURRENT_TIMESTAMP() - INTERVAL 1 YEAR)
ORDER BY d.`datetime`;

SELECT * FROM logs;

-- Таблица logs с записью всех вставок в БД
DROP TRIGGER IF EXISTS logs_deal;
DROP TRIGGER IF EXISTS logs_dividends;
DROP TRIGGER IF EXISTS logs_info;
DROP TRIGGER IF EXISTS logs_pay_history;
DROP TRIGGER IF EXISTS logs_sectors;
DROP TRIGGER IF EXISTS logs_stocks;

DELIMITER //

CREATE TRIGGER logs_deal
AFTER INSERT
ON deal FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'deal';
END//

CREATE TRIGGER logs_dividends
AFTER INSERT
ON dividends FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'dividends';
END//

CREATE TRIGGER logs_info
AFTER INSERT
ON info FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'info';
END//

CREATE TRIGGER logs_pay_history
AFTER INSERT
ON pay_history FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'pay_history';
END//

CREATE TRIGGER logs_sectors
AFTER INSERT
ON sectors FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'sectors';
END//

CREATE TRIGGER logs_stocks
AFTER INSERT
ON stocks FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'stocks';
END//

DELIMITER ;






	