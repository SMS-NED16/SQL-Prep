/*
	First, the subquery returns a table of pet IDs owned by Zed.
	This is a simple query-based join like the one in exercise 6. 
	The result of this query is a table that is passed to the 
	DELETE FROM pet WHERE id IN query, which will delete every `pet`
	record with an `id` that appears in the subquery result.
*/
DELETE FROM pet WHERE id IN (
	SELECT pet.id
	FROM pet, person_pet, person
	WHERE
	person.id = person_pet.person_id AND 
	pet.id = person_pet.pet_id AND 
	person.first_name = 'Zed'
);

/* Echoing to ensure that the DELETE operation has taken place */
SELECT * FROM pet;

/* However, ids of the deleted pets still exist in the person_pet table */
SELECT * FROM person_pet; 

/* 
	Get all the existing `id`s from pet and DELETE any rows in the person_pet
	that have pet_ids that DO NOT appear in the list of pet ids i.e. deleting pet ids.
*/
DELETE FROM person_pet
	WHERE pet_id NOT IN (
		SELECT id FROM pet
	);

/*
	Echo to ensure that the person_pet tabl;e has been updated.
*/
SELECT * FROM person_pet;