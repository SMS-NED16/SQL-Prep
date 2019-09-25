/* How many dead pets are there? */
SELECT dead, COUNT(*) FROM pet GROUP BY dead;

/* How many pets belong to each breed in the database? */
SELECT breed, COUNT(*) FROM pet GROUP BY breed;

/* How many dead per breed? */
SELECT breed, dead FROM pet GROUP BY breed;

/* Not quite right. We also want to add a COUNT to get total number of dead pets */
SELECT breed, dead, COUNT(dead) FROM pet GROUP BY breed;

/* We can modify this query to show the number of pets per breed that are dead and alive */
SELECT breed, dead, COUNT(dead) FROM pet GROUP BY breed, dead;