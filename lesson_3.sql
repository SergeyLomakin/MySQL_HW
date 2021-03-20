USE vk;

-- Групповой чат
DROP TABLE IF EXISTS chat;
CREATE TABLE chat(
	id SERIAL, -- ид чата
	name VARCHAR(255), -- название чата
	admin_user_id BIGINT UNSIGNED NOT NULL, -- админ чата
	from_user_id BIGINT UNSIGNED NOT NULL, -- отправитель сообщения
	/* to_user_id BIGINT UNSIGNED NOT NULL DEFAULT ALL,
	хотел сделать, чтобы можно было обратиться к конкретному пользователю,
	либо по умолчанию - ко всем. Не получилось */
	body TEXT, -- текст сообщения
	created_at DATETIME DEFAULT NOW(), -- время отправки сообщения
	
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

-- Вспомогательная таблица для чата
DROP TABLE IF EXISTS chat_info;
CREATE TABLE chat_info(
	user_id BIGINT UNSIGNED NOT NULL,
	chat_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (user_id, chat_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (chat_id) REFERENCES chat(id)
);

-- таблица городов
DROP TABLE IF EXISTS towns;
CREATE TABLE towns(
	id SERIAL, 
	name VARCHAR(255) UNIQUE, -- название города
	
	INDEX(name) -- заготовка для поиска людей по городу
);

DROP TABLE IF EXISTS user_of_town;
CREATE TABLE user_of_town(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	town_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (user_id, town_id), -- человек может быть только из одного города
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (town_id) REFERENCES towns(id)
);




