/*
	Creating a database with three tables
	- person: a table of people
	- cars: a table of different cars
	- person_cars: a relation mapping car_id to person_id  
*/

CREATE TABLE person (
	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	age INTEGER
);

CREATE TABLE car (
	id INTEGER PRIMARY KEY,
	make TEXT,
	model TEXT,
	year TEXT,
	horsepower REAL,
	mileage REAL
);

CREATE TABLE person_car (
	person_id INTEGER,
	car_id iNTEGER
);
