/*
	A query that renames any deceased pets owned by Zed
*/
/* Name will be truncated unless I set the column width manually */
.width 10 20 10 10 10

/*	Before the update */
SELECT * FROM pet;

/*	
	Update query but with additional clause 
*/
UPDATE pet SET name = "Zed's Dead Pet" WHERE id IN (
	SELECT pet.id
	FROM pet, person, person_pet 
	WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id AND
	person.first_name = "Zed" AND
	pet.dead = 1
);

/*	Confirm query update results */
SELECT * FROM pet;