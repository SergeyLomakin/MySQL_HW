USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id SERIAL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	table_name ENUM ('users', 'catalogs', 'products') NOT NULL,
	pk_id BIGINT NOT NULL,
	name VARCHAR(255)
) ENGINE = Archive;

DELIMITER //

DROP TRIGGER IF EXISTS logs_users//
CREATE TRIGGER logs_users
AFTER INSERT
ON users FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'users',
		name = NEW.name;
END//

DROP TRIGGER IF EXISTS logs_catalogs//
CREATE TRIGGER logs_catalogs
AFTER INSERT
ON catalogs FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'catalogs',
		name = NEW.name;
END//

DROP TRIGGER IF EXISTS logs_products//
CREATE TRIGGER logs_products
AFTER INSERT
ON products FOR EACH ROW
BEGIN 
	INSERT INTO logs SET
		pk_id = NEW.id,
		table_name = 'products',
		name = NEW.name;
END//

DELIMITER ;


-- Check
INSERT INTO users (name) VALUES
	('fvd'),
	('jufd');

INSERT INTO catalogs (name) VALUES
	('doid'),
	('cus');

INSERT INTO products (name, description, price, catalog_id) VALUES
	('vfv', 'dsudusd', 20, 1);

SELECT * FROM logs;



