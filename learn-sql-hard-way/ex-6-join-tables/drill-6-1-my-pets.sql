/*
	Using conventional querying syntax
	Basically selecting all rows in the `pet` table where the 
	pet's id is the same as the person_pet's pet_id value, and
	where the person not only has the first name 'Saad' but also
	has the same id as the person_id value of the selected row.

	In effect, this means we're looking up all pets owned by Saad
*/
SELECT pet.id, pet.name, pet.breed, pet.age 
	FROM pet, person, person_pet
	WHERE
	/*pet table id should match person_pet table id*/
	pet.id = person_pet.pet_id AND

	/*person table id should match the person_pet table id */
	person.id = person_pet.person_id AND

	/*person's first name should be Saad */
	person.first_name = 'Saad';


/*
	Subquerying syntax
*/
SELECT pet.id, pet.name, pet.breed, pet.age
	FROM pet 
	WHERE pet.id IN 
	(
		SELECT pet_id FROM person_pet, person
		WHERE person_pet.person_id = person.id
		AND person.first_name = 'Saad'
	);