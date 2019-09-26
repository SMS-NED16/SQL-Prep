/* Experimenting with SQL views - saving results of a query for later use */

/* Non-view query */
SELECT breed, COUNT(*), max(age), min(age), avg(age), max(age) - min(age) AS age_range
FROM pet
WHERE dead = 0
GROUP BY breed;

/* Saving the result of this query as a view */
CREATE VIEW breed_data AS 
	SELECT 
		breed, 
		COUNT(*) AS total_pets, 
		max(age) AS max_age, 
		min(age) AS min_age, 
		avg(age) AS mean_age, 
		max(age) - min(age) AS age_range
	FROM pet GROUP BY breed;

/* Has the view been created? */
SELECT * FROM breed_data;

/* Cannot add a column to a view! */
ALTER TABLE breed_data ADD COLUMN total_alive INTEGER;

/* Cannot insert a new row into a view! */
INSERT INTO breed_data(breed, total_pets, max_age, min_age, mean_age, age_range) VALUES
	('Dragon', 3, 250, 0, 50, 250);

/* Cannot UPDATE values within a view directly */
UPDATE breed_data SET breed = 'Fat Catto' WHERE breed = 'Calico Cat';

/* Before the script terminates, drop the view */
DROP VIEW breed_data;