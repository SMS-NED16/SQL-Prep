-- Author recommends using CAST instead of vendor-specific built-in functions for
-- converting between strings and specific datatypes. This is because the CAST function
-- is part of the SQL standard and is thus portable across SQL servers.
SELECT CAST('1456328' AS SIGNED INTEGER);
SELECT CAST('-1456328' AS SIGNED INTEGER);

-- CAST works from left to right. When converting b/w strings and nums, will discard all chars
-- after the first non-numeric. Conversion will halt w/o error, but will generate warning.
SELECT CAST('999ABC111' AS UNSIGNED INTEGER);
/*
+---------+------+------------------------------------------------+
| Level   | Code | Message                                        |
+---------+------+------------------------------------------------+
| Warning | 1292 | Truncated incorrect INTEGER value: '999ABC111' |
+---------+------+------------------------------------------------+
*/