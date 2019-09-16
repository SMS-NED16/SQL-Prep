/*
	Attempting to delete all records from students enrolled in HS-304
*/
DELETE FROM student WHERE id IN (
	SELECT student.id 
	FROM student, course, student_course 
	WHERE
	student.id = student_course.student_id AND
	course.id = student_course.course_id AND 
	student.first_name = 'Saad'
);

SELECT * FROM student;

SELECT * FROM student_course;

DELETE FROM student_course
	WHERE student_id NOT IN (
		SELECT id FROM student
	);

SELECT * FROM student_course;