/* Query to replace the `Unicorn` with a Parrot */
SELECT * FROM pet;   /* before update */

/* Conventional INSERT will fail */
INSERT INTO pet (id, name, breed, age, dead) 
	VALUES(0, 'Fluffy', 'Parrot', 5, 0);

/* Using REPLACE INTO */
REPLACE INTO pet(id, name, breed, age, dead) 
	VALUES(0, 'Fluffy', 'Parrot', 5, 0);

/* Confirming results of query */
SELECT * FROM pet;