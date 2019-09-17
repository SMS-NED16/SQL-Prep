/*
	Will attempt to UPDATE the names of all pets owned by Zed
	To do this, we will use a subquery.
*/

/*	First echo the pets before the update */
SELECT * FROM pet;

/*	
	Return a table of all the pet ids owned by Zed. Do this by
	- Selecting a row in `person` where the `id` matches `person_id` in the person_pet
	- Selecting a row in `pet` where the `id` matches `pet_id` in the same person_pet row
			- This selects the pet owned by the person.
	- Then return this row to the query result only if the `name` of the person in selected row
	  is also `Zed`.
*/
UPDATE pet SET name = "Zed's Pet" WHERE id in (
	SELECT pet.id
	FROM pet, person, person_pet
	WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id AND
	person.first_name = "Zed"
);

/* Checking result of the UPDATE query*/
SELECT * FROM pet;