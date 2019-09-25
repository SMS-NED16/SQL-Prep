/* Simple query to get a related table - will return all columns */
SELECT * FROM person, person_pet, pet WHERE 
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id;

/* Can tell if query has worked by inspection - just look at the IDs in each row */
SELECT person.id, pet.id, person_pet.person_id, person_pet.pet_id
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id;


/* Add a basic COUNT summary function and append the GROUP BY */
SELECT person.first, pet.breed, pet.dead, COUNT(dead)
	FROM person, person_pet, pet
	WHERE
		person.id = person_pet.person_id AND
		pet.id = person_pet.pet_id 
	GROUP BY pet.breed, pet.dead;	
	
/* Drop the person.first since that is not summarised. This will therefore
return a table of pet names and pet breeds that are owned by a specific person
(which we don't really care about) and how many other pets of the same name
and breed have died.
*/
SELECT pet.breed, pet.dead, COUNT(dead)
	FROM person, pet, person_pet 
	WHERE 
		person.id = person_pet.person_id AND
		pet.id = person_pet.pet_id
	GROUP BY
		pet.breed, pet.dead;

/* Comparing the counts to without the person_pet relation */
SELECT breed, dead, COUNT(dead)
	FROM pet
	GROUP BY breed, dead;