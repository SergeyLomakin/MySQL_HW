-- ЗАДАНИЕ 2
-- Создание базы данных с именем: exampe
CREATE DATABASE example;

-- Использование БД users по умолчанию для введённых команд
USE example

-- Создание таблицы: users, со столбами: id, name
CREATE TABLE users (
   id INT(8) UNSIGNED,
   name CHAR(15) DEFAULT 'null'
);


-- ЗАДАНИЕ 3
-- Создание дампа БД example (терминал Linux)
mysqldump example > example_dump_1.0.sql;

-- Создание БД sample в которую будет развернут дамп
CREATE DATABASE sample;

-- Развёртывание дампа в БД sample (терминал Linux)
mysql sample < example_dump_1.0.sql;

