-- Creating a separate table for manipulating and generating strings
CREATE TABLE string_tbl
(
	char_fld CHAR(30),			/* Fixed length, blank padded strings up to 255 chars*/
	vchar_fld VARCHAR(30),		/* Variable length strings up to 30 chars in this case*/
	text_fld TEXT 				/* Variable length strings for documents - up to 4 GB */
);

-- Inserting strings (Method 1 - Using parentheses and string literals with INSERT)
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld) 
VALUES ('This is char data', 
	'This is varchar data', 
	'This is text data');

-- Exception thrown when argument str length exceeds designated or maxmimum allowed length for col
-- vchar_fld is a VARCHAR(30) column -> only 30 char strs allowed
-- In this case, we are using a string whose length is 46 characters
UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';
-- ERROR 1406 (22001): Data too long for column 'vchar_fld' at row 1

-- ANSI Mode: Truncate string, issue warning instead of exception if length exceeded
-- Use this to see what mode you're using
SELECT @@session.sql_mode;

-- Switch to ANSI mode - only applies to this session. Confirm change
SET sql_mode = 'ansi';
SELECT @@session.sql_mode;

-- Now using the same UPDATE statement
UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';

-- Will now be able to display warnings
SHOW WARNINGS;
/*
+---------+------+------------------------------------------------+
| Level   | Code | Message                                        |
+---------+------+------------------------------------------------+
| Warning | 1265 | Data truncated for column 'vchar_fld' at row 1 |
+---------+------+------------------------------------------------+
*/

-- Revert back to strict mode by restarting session. Or
SET sql_mode = 'STRICT_TRANS_TABLES' /* As well as any other rules */

/* Better to use strict mode and just set a large character limit for string columns.
The SQL server will only use as much space as is required by the string, and won't waste
space by reserving max_char for each possible entry. So even though this doesn't 
use additional space, it saves us the trouble of dealing with truncation  */

-- Use escape characters to include single quotes as part of strings
-- The following query will not work 
/*UPDATE string_tbl
SET text_fld = 'This string doesn't work';*/

-- But this one will
UPDATE string_tbl
SET text_fld =  'This string didn''t work, but it does now.';

-- Can also use a backslash
UPDATE string_tbl
SET text_fld = 'This string didn\'t work, but it does now.';

-- When the retrieved string is to be written to another file, use `quote()` 
-- This places quotation marks around the strings and preserves escape chars
SELECT quote(text_fld) FROM string_tbl;

-- Internationalization with the `char` function - use the full ASCII char set
-- First column is a typed string, and the second column is string returned by ASCII decoding
SELECT 'abcdefg', CHAR(97, 98, 99, 100, 101, 102, 103);

-- This demonstrates how CHAR can be used to retrieve non-standard chars
-- May display as other chars if SQL Server not configured to use the latin1 encoding
SELECT CHAR(128, 129, 130, 131, 132, 133, 134, 135, 136, 137);
SELECT CHAR(138, 139, 140, 141, 142, 143, 144, 145, 146, 147);
SELECT CHAR(148, 149, 150, 151, 152, 153, 154, 155, 156, 157);

-- Use `concat()` with `char()` to combine standard chars with accented ones
SELECT CONCAT('danke sch', CHAR(148), 'n');

-- Find the ASCII code for a specific character
SELECT ASCII("ö");

-- Resetting the data in the string_tbl 
DELETE FROM string_tbl;
INSERT INTO string_tbl (char_fld, vchar_fld, text_fld) 
VALUES ('This string is 28 characters', 
	'This string is 28 characters', 
	'This string is 28 characters');

-- `length()`: returns the length of the string
SELECT LENGTH(char_fld) AS char_length, 	
	LENGTH(vchar_fld) AS varchar_length, 
	LENGTH(text_fld) AS text_length
FROM string_tbl;
/*CHAR cols are stored as 30 chars, but when retrieved, trailing spaces removed */

--`position()` - Find location of a substring `characters` in varchar column
SELECT POSITION('characters' IN vchar_fld) FROM string_tbl;

-- `locate()` - If you want to start searching from a position other than index 0
SELECT LOCATE('is', vchar_fld, 5) FROM string_tbl;		/* Start looking at char 5 */

-- `strcmp()` - Returns -1, 0, +1 if first str appears before, is equal, or after second in lexicographic order
DELETE FROM string_tbl;
INSERT INTO string_tbl(vchar_fld) VALUES('abcd');
INSERT INTO string_tbl(vchar_fld) VALUES('xyz');
INSERT INTO string_tbl(vchar_fld) VALUES('QRSTUV');
INSERT INTO string_tbl(vchar_fld) VALUES('qrstuv');
INSERT INTO string_tbl(vchar_fld) VALUES('12345');

-- Display order of the vchar entries
SELECT vchar_fld FROM string_tbl ORDER BY vchar_fld;

SELECT STRCMP('12345', '12345') as 12345_12345, 	/* 0 */
	STRCMP('abcd', 'xyz') AS abcd_xyz, 				/* -1 */
	STRCMP('abcd', 'QRSTUV') AS abcd_QRSTUV,		/* -1 */ 
	STRCMP('qrstuv', 'QRSTUV') AS qrstuv_QRUSTV,	/* 0 - not case sensitive*/
	STRCMP('12345', 'xyz') AS 12345_xyz,			/* -1 */
	STRCMP('xyz', 'qrstuv') AS xyz_qrstuv;			/* 1 */

-- Regular expressions and LIKE with strings - use the bank database
-- Returns 1 if the regular expression is satisfied, 0 otherwise
SELECT name, name LIKE '%ns' AS ends_in_ns FROM department;

-- REGEXP operator
SELECT cust_id, cust_type_cd, fed_id,
	fed_id REGEXP '.{3}-.{2}-.{4}' AS is_ss_no_format 
FROM customer;

-- Start using the `lrng_sql` database again
DELETE FROM string_tbl; 
INSERT INTO string_tbl (text_fld) VALUES ('This string was 29 characters.');

-- Can use the `concat()` method to change the value in the text_fld column
UPDATE string_tbl 
SET text_fld = CONCAT(text_fld, ', but now it is longer');

-- Can also use `concat` to build a string from several individual pieces of data
-- Using the `bank` database again
SELECT CONCAT(fname, ' ', lname, ' has been a ', title, ' since ', start_date) AS emp_narrative
FROM employee
WHERE title = 'Teller' OR title = 'Head Teller';

-- Replace string with specified characters at specified index
-- In this case, extract 5 characters starting at index 9 
SELECT SUBSTRING('goodbye cruel world', 9, 5);