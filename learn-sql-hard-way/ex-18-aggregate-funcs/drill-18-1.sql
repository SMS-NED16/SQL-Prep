/* Find the count and average age of pets by breed */
SELECT breed, COUNT(breed), AVG(age) FROM pet GROUP BY breed;

/* Find the total count, average age, and live count of pets by breed*/
SELECT breed, COUNT(breed), AVG(age), SUM(dead)
FROM pet
GROUP BY breed;

/* Verify dead count by single query */
SELECT breed, COUNT(*) FROM pet WHERE dead = 1 GROUP BY breed;

/* 
	Finding the max, min, average age, total count, and total dead pet count
	for all pets that are owned by a person.
*/
SELECT pet.breed, COUNT(pet.breed), SUM(dead), AVG(pet.age), MAX(pet.age), MIN(pet.age)
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id
GROUP BY pet.breed; 

/* 
	Find the average age and number of people who are pet owners by breed
*/
SELECT pet.breed, AVG(person.age), COUNT(person.id)
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND
	pet.id = person_pet.pet_id
GROUP BY pet.breed;

/*
	Experimenting with DATETIME by only considering adult pet owners
*/
SELECT pet.breed, AVG(person.age), COUNT(person.id) 
FROM person, pet, person_pet
WHERE
	person.id = person_pet.person_id AND 
	pet.id = person_pet.pet_id AND 
	person.dob < date('now', '-18 years')
GROUP BY breed;

/* There is a marked difference in both the count and average age of the people 
who are pet owners grouped by category when we consider only adults. */