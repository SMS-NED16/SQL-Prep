-- AVERAGE: A lot like COUNT, but does an average over the column

/* Select the average age of every person */
SELECT avg(age) FROM person;

/* Select the average age of every pet*/
SELECT avg(age) FROM pet;

/* Select the average age of every breed by dead or alive*/
SELECT breed, dead, avg(age) FRM pet GROUP BY breed, dead

-- SUM and TOTAL
-- SUM will add up the **contents** of a column and return a sum/total
SELECT sum(age) FROM person;
SELECT sum(age) FROM pet;
SELECT breed, sum(dead), sum(Age) FROM pet WHERE dead = 1 GROUP BY breed, dead;

-- MIN and MAX - find the smallest and largest values from a query
SELECT min(age), max(age) FROM person;
SELECT min(age), max(age) FROM pet;
SELECT breed, dead, min(age) FROM pet
	WHERE age > 0
	GROUP BY breed, dead
	ORDER BY age;