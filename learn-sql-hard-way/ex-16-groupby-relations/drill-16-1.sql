/* Query that finds the number of unique first names/last names in the person table */
SELECT first, COUNT(first) FROM person GROUP BY first;
SELECT last, COUNT(last) FROM person GROUP BY last;

/* Query that finds the total number of pets with the same name */
SELECT name, COUNT(name) FROM pet GROUP BY name;

/* Query that finds the total number of pets belonging to a specific breed */
SELECT breed, COUNT(breed) FROM pet GROUP BY breed;

/* Adding a WHERE clause that checks if the pet is actually owned by someone
	This changes the counts of the GROUP BY for the same breed 
*/
SELECT breed, COUNT(breed) 
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id
GROUP BY breed;

/* This shows that there are number of each breed of bet that aren't owned by anyone */

/* Query that finds the number of dead pets per age group */
SELECT person.age, pet.dead, COUNT(pet.dead)
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id
GROUP BY person.age, pet.dead;

/* Query that finds the breeds owned by each age group */
SELECT person.age, pet.breed, COUNT(pet.breed)
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id
GROUP BY person.age, pet.breed;

/* Query that finds the total number of pets owned by a specific person */
SELECT person.id, COUNT(person.id)
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id
GROUP BY person.id;