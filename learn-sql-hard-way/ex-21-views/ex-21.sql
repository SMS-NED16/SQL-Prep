BEGIN TRANSACTION;

/* Test our query from Exercies 16 */
SELECT pet.breed, pet.dead, COUNT(dead)
	FROM person, person_pet, pet
	WHERE
		person.id = person_pet.person_id AND
		pet.id = person_pet.pet_id 
	GROUP BY pet.breed, pet.dead;

/* Store the result of this query in a new table */
CREATE VIEW dead_pets AS
SELECT pet.breed, pet.dead, COUNT(dead) AS total
	FROM person, person_pet, pet
	WHERE 
		person.id = person_pet.person_id 
		AND pet.id = person_pet.pet_id
	GROUP BY pet.breed, pet.dead;

/* We can now refer to the result of the previous query as if it were a table in the DB*/
/* Needed to add `total` column so we could query against it here */
SELECT * FROM dead_pets WHERE total > 10;

/* Getting rid of cats in pets - does this change dead_pets? */
DELETE FROM pet WHERE breed = 'Cat';
SELECT * FROM dead_pets;

/* Drop the dead view */
DROP VIEW dead_pets; 

ROLLBACK TRANSACTION;