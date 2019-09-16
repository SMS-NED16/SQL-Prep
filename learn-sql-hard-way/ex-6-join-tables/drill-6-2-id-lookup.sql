/* Using hardcoded index */

SELECT pet.id, pet.name, pet.age, pet.dead 
	FROM pet, person_pet, person
	WHERE
	pet.id = person_pet.pet_id AND
	person_pet.person_id = person.id AND
	person.id = 1;

/* Yo dawg, I heard you like subqueries so I put a subquery
in your subquery so you can SELECT while you SELECT */
SELECT pet.id, pet.name, pet.age, pet.dead 
	FROM pet
	WHERE pet.id IN 
	(
		SELECT pet_id FROM person_pet, person
		WHERE person_pet.person_id = person.id 
		AND person.id = 1
	);