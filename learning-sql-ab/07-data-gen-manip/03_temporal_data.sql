-- See global and local time zone for the current sessions
SELECT @@global.time_zone, @@session.time_zone;

-- System: SQL Server is using the time zone setting from the server on which the db resides
-- In this case, the server is my laptop, so it using the same time zone settings as the laptop
-- Can manually change the time zone of a session. Use `mysql` db and make sure time_zone_name table has values
SET time_zone = 'Europe/Zurich';	
SELECT @@global.time_zone, @@session.time_zone;

-- If server expects a datetime value for an object, just provide a properly formatted string
-- Server will automatically handle conversion
UPDATE transaction
SET txn_date = '2008-09-17 15:30:00'		/*Datetime string: YYYY-MM:SS HH:MI:SS*/
WHERE txn_id = 9999;

-- If server does not expect datetime value or want to use nondefault formats, must use `cast`
SELECT CAST('2008-09-17 15:30:00' AS DATETIME);

-- Can alos be used for dates and times, not just datetimes
SELECT CAST('2008-09-17' AS DATE) AS date_field, 
	CAST('108:17:57' AS TIME) AS time_field;

-- MySQL is lenient about separators between components of a datetime/timestamp string
SELECT CAST('2008-09-17 15:30:00' AS DATETIME);	/*Can use standard hyphen syntax*/
SELECT CAST('2008/09/17 15:30:00' AS DATETIME); /*Or forward slashes*/
SELECT CAST('2008,09,17 15,30,00' AS DATETIME); /*Or commas*/
-- SELECT CAST('20080917153000') AS DATETIME; This doesn't work

-- Format strings: a more flexibile way of creating temporal data from strings
-- Just specify the order in which each datetime component appears in the original string
UPDATE individual
SET birth_date = STR_TO_DATE('September 17, 2008', '%M %d, %Y')
WHERE cust_id = 9999;

/* The delimiters/commas in the format string must match those in the str to be converted */
SELECT 'September 17, 2008' AS original_date,
	STR_TO_DATE('September 17, 2008', '%M %d, %Y') AS str_to_date;

-- Accessing current date, time, and timestamp with built-in functions
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

-- DATE_ADD: Takes current date, adds a user-defined interval, returns resulting data
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);
SELECT DATE_ADD(CURRENT_TIME(), INTERVAL 5 HOUR);

-- Compound intervals are specified as combinations of first and last components
UPDATE transaction
SET txn_date = DATE_ADD(txn_date, INTERVAL '3:27:11' HOUR_SECOND)
WHERE txn_id = 9999;

-- Adding 3h 27m and 11s to current time
SELECT CURRENT_TIMESTAMP() AS time_now, 
	DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL '3:27:11' HOUR_SECOND) AS 3h_27m_11s_later;

-- Adding 9 years and 11 months to current date
SELECT CURRENT_DATE() AS todays_date,
	DATE_ADD(CURRENT_DATE(), INTERVAL '9-11' YEAR_MONTH) AS nine_years_eleven_months;

-- Last_Day returns the *date* of the last day for the month in the current timestamp
SELECT LAST_DAY('2008-09-17') AS last_date_of_month;

-- Convert dates from one time zone to another - won't work if timezones not loaded 
SELECT CURRENT_TIMESTAMP AS current_timezone_date, 
	CONVERT_TZ(CURRENT_TIMESTAMP(), 'US/Eastern', 'UTC') AS current_utc;

-- Returns a string representing the day of the week on a specific date
SELECT DAYNAME('2008-09-18');

-- This is one of many variants of the EXTRACT function
SELECT EXTRACT(YEAR FROM '2008-09-18 22:19:05');
SELECT EXTRACT(DAY FROM '2009-09-18 22:19:05');

-- Number of days between two dates. Will always ignore timestamps. Just uses days, months, years.
SELECT DATEDIFF('2009-09-03', '2009-06-24');	/* By default returns date */
SELECT DATEDIFF('2009-09-03 23:59:59', '2009-06-24 00:00:01');

-- If earliest date first, datediff returns a negative number
SELECT DATEDIFF('2009-06-24', '2009-09-03');