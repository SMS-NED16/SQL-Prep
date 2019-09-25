/* SQL Script to demonstrate the use SQLite's DATETIME functionality */

-- First select all people who are older than 10 years. Do this by finding
-- all date of births that are less than the date 10 years ago from this instant.

SELECT * FROM person WHERE dob < date('now', '-10 years') ORDER BY dob;

-- Use a different, more standard syntax to find everyone born before 1970
SELECT * FROM person WHERE dob < date('1970-01-01') ORDER BY dob;

-- Then find all the pets that were purchased this year by looking for dates 
-- beteween now and the `beginning of the year`
SELECT * FROM person_pet 
	WHERE purchased_on > date('now', 'start of year')
	ORDER BY purchased_on;

-- All pets purchased between 1990 and 2000 
SELECT * FROM person_pet
	WHERE
		purchased_on > date('1990-01-01') AND 
		purchased_on < date('2000-01-01')
	ORDER BY purchased_on;

-- Link the pets from the last query 
SELECT pet.name, pet.breed, pet.age, pet.dead, person_pet.purchased_on 
FROM person_pet, pet
WHERE
	purchased_on > date('1990-01-01') AND
	purchased_on < date('2000-01-01') AND
	person_pet.pet_id = pet.id
ORDER BY purchased_on, pet.age;