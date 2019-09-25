/* Selecting all people older than 10 years and attempting to group by date */
SELECT * FROM person 
WHERE dob < date('now', '-10 years')
GROUP BY age
ORDER BY date;

/* All pets purchased this year */
SELECT * FROM person_pet
	WHERE purchased_on > date('now', 'start of year')
	GROUP BY dob
	ORDER BY purchased_on;