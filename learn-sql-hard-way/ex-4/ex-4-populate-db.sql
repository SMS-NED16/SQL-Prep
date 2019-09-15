/*
	Inserting dummy data into both tables of the database
*/
INSERT INTO person(id, first_name, last_name, age)
	VALUES(0, 'Zed', 'Shaw', 37);


INSERT INTO pet(id, name, breed, age, dead)
	VALUES(0, 'Fluffy', 'Unicorn', 1000, 0);

INSERT INTO pet(id, name, breed, age, dead)
	VALUES(1, 'Gigantor', 'Robot', 1, 1);
