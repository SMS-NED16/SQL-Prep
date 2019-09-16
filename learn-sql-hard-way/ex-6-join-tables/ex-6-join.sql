/*
	Normal join with equality
*/

/* 
	Selecting only the `id`, `name`, `age`, and `dead`
	columns from the tables. Using * means getting all columns
	but this isn't a good database querying practice.

*/
SELECT pet.id, pet.name, pet.age, pet.dead 
	/* We will need to look up data in all three tables */
	FROM pet, person_pet, person
	WHERE 
	/* The pet's ID in the `pet` table is the same as the 
	`pet_id` value in the `person_pet` table */
	pet.id = person_pet.pet_id AND

	/* The person's id in the person table is the same as 
	the `person_id` column in the person_pet table*/
	person_pet.person_id = person.id AND

	/* The person's name is Zed*/
	person.first_name = 'Zed';

/* 
	This query is searching for all rows in the person
	table where the person id is the same as person_pet, 
	and finding all rows where the pet id is the same as in person_pet,
	and then combining the person and pet rows for these rows. 

	It also does an additional check to see if the first name is Zed.
*/

/*
	Using a sub-select
*/
SELECT pet.id, pet.name, pet.age, pet.dead
	FROM pet
	WHERE pet.id IN
	(
		SELECT pet_id FROM person_pet, person
		WHERE person_pet.person_id = person.id
		AND person.first_name = 'Zed'
	);

/*
	The subquery finds all rows in the person_pet and person
	tables where the person_pet.id and person.id values are the same.
	The result of this query will be used by the master query to find the 
	pets owned by the person named 'Zed'.
*/