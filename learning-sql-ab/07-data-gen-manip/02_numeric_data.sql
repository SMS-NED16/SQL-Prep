-- Mathematical operations are straighforward
SELECT (37 * 59) / (78 - (8 * 6));

-- Basic, built-in mathematical function
SELECT 10 AS x, ACOS(10) AS acos, ASIN(10) AS asin, ATAN(10) AS atan, 
	COS(10) AS cos, COT(10) AS cot, EXP(10) AS exp, LN(10) AS ln, 
	SIN(10) AS sin, SQRT(10) AS sqrt, TAN(10) AS tan;

-- Modulo operator - returns remainder
SELECT MOD(10, 4);
SELECT MOD(22.75, 5);

-- Power - raise base to exponent
SELECT POW(2, 8);
-- Using `pow` to measure the number of bytes in the a certain amount of memory
SELECT POW(2, 10) AS kilobyte, POW(2, 20) AS megabyte,
	POW(2, 30) AS gigabyte, POW(2, 40) AS terabyte;

-- `ceil()` and `floor()` - Round either up or down
SELECT CEIL(72.445), FLOOR(72.445);
SELECT CEIL(72.00000000001), FLOOR(72.99999999999);

-- `round()` - round up or down from midpoint b/w two integers
SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.500001);
-- if >= 72.5, round to 73

-- Optional second argument: specify number of digits to round to
SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);

-- `truncate()` - Discards digits rather than rounding them
SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2), TRUNCATE(72.0909, 3);

-- Can specify decimal places to left of decimal point when negative args
SELECT ROUND(17, -1), TRUNCATE(17, -1);		

/* Round(17, -1) means round the number to 1 digit before decimal place 17.0 */
/* Truncate will likewise drop the first digit to the left of the decimal point */