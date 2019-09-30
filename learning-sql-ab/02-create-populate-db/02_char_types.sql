/* Character types are used to store strings */
char(20); 		/* Fixed length of 20 characters */
varchar(20);		/* Variable length - still 20 characters, but not right padded*/

/* See all available character sets - which ones are multibyte */
SHOW CHARACTER SET;

/* Set default character set for entire database */
CREATE DATABASE foreign_sales CHARACTER_SET utf8;

/* Text types - to store data larger than 64K (varchar limit)*/
Tinytext	255 bytes
text		65,535 bytes
Mediumtext	16.7M bytes
Longext		4.29 Gbytes

/* Only the first 1,024 bytes are used when sorting text columns */
