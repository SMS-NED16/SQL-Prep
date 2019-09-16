/* Deleting existing tables */
DROP TABLE student;
DROP TABLE course;
DROP TABLE student_course;

/* Creating a dummy database of courses and students */
CREATE TABLE student (
	id INTEGER PRIMARY KEY, 
	first_name TEXT,
	last_name TEXT, 
	year INTEGER
); 

CREATE TABLE course (
	id INTEGER PRIMARY KEY,
	name TEXT,
	department TEXT, 
	code INTEGER
);

CREATE TABLE student_course (
	student_id INTEGER,
	course_id INTEGER
);

/* Inserting dummy data */
INSERT INTO student (id, first_name, last_name, year) VALUES
	(0, 'Saad', 'Siddiqui', 4),
	(1, 'Faiq', 'Siddiqui', 3),
	(2, 'Waleed', 'Hasan', 4),
	(3, 'Haseeb', 'Qadri', 1);

INSERT INTO course (id, name, department, code) VALUES
	(0, 'Electrical Power Transmssion', 'EE', 362),
	(1, 'Feedback Control Systems', 'EE', 374),
	(2, 'Telecommunicatons Systems', 'TC', 307), 
	(3, 'Power System Analysis', 'EE', 352),
	(4, 'Numerical Methods', 'MT', 229),
	(5, 'Business Communication and Ethics', 'HS', 304);

INSERT INTO student_course (student_id, course_id) VALUES
	(0, 0), (0, 1), (0, 2),
	(1, 1), (1, 2), (1, 3),
	(2, 2), (2, 3), (2, 4), (2, 5),
	(3, 4), (3, 5),
	(4, 1), (4, 2), (4, 5);

/* Echoing Data */
SELECT * FROM student;
SELECT * FROM student WHERE year = 4;

SELECT * FROM course;
SELECT * FROM course WHERE department = 'EE';

SELECT * FROM student_course;
SELECT * FROM student_course WHERE student_id = 1 OR course_id = 4;

