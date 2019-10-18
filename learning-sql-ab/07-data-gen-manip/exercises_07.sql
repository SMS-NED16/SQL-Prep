-- 7-1: Write a query that returns the 17th through 25th characters of string 
-- 'Please find the substring in this string'.
SELECT SUBSTRING('Please find the susbtring in this string', 17, 9);

-- 7-2: Write a query that returns the absolute value and sign (-1, 0, 1) of the number
-- -25.76823. Also return the number rounded to the nearest hundredth.
SELECT -25.76823 AS original_num, 
	ROUND(-25.76823, 2) AS rounded_to_hundredth, 
	ABS(-25.76823) AS absolute_value, 
	SIGN(-25.76823) AS num_sign;

-- 7-3: Write a query to return just the month portion of the current date.
SELECT EXTRACT(MONTH FROM CURRENT_DATE());