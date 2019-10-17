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