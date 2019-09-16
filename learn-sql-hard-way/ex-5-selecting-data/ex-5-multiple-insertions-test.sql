CREATE TABLE person (
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER
);

INSERT INTO person (id, first_name, last_name, age) VALUES
	(0, 'Saad', 'Siddiqui', 23),
	(1, 'Faiq', 'Siddiqui', 21),
	(2, 'Waleed', 'Hasan', 21),
	(3, 'Haseeb', 'Qadri', 21);

SELECT * FROM person;

SELECT first_name, last_name FROM person;

SELECT first_name, last_name, age FROM person WHERE age < 23;
