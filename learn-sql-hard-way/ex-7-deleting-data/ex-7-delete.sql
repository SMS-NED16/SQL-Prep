/* Make sure there are some ded pets to delete */
SELECT name, age FROM pet WHERE dead = 1;

/* RIP robot */
DELETE FROM pet WHERE dead = 1;

/* Make sure the robot is gone */
SELECT * FROM pet;

/* Resurrecting robot */
INSERT INTO pet (id, name, breed, age, dead) 
	VALUES(1, 'Gigantor', 'Robot', 1, 0);

/* The robot LIVES! */
SELECT * FROM pet;
