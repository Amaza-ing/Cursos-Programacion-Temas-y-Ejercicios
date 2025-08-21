DROP SCHEMA IF EXISTS academy;
CREATE SCHEMA academy;
USE academy;


-- DDL (Data Definition Language)

CREATE TABLE teacher (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255),
	surname VARCHAR(255),
	PRIMARY KEY (id)
);

CREATE TABLE course (
	name VARCHAR(255) NOT NULL,
	hours INT,
	classroom VARCHAR(255),
	vacations VARCHAR(255),
	teacher_id INT,
	PRIMARY KEY (name),
	FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);


-- DML (Data Modification Language)

INSERT INTO teacher (name, surname) VALUES
('Alberto', 'García'),
('Beatriz', 'López'),
('Carmen', 'Martín'),
('Daniel', 'Hernández');


INSERT INTO course VALUES
('Math', 100, 'A1', '2 weeks', 1),
('Programming', 150, 'B1', '3 weeks', 2),
('Computer Science', 150, 'B1', '3 weeks', 2),
('English', 50, 'A2', '1 week', 1),
('Physics', 200, 'C1', '4 weeks', 1),
('Chemistry', 100, 'Lab1', '2 weeks', 3),
('History', 200, 'C1', '4 weeks', NULL);


-- Modificación de Tablas
/*
SELECT * FROM course;

ALTER TABLE course
ADD mandatory BOOL;

UPDATE course SET mandatory = TRUE WHERE hours > 100;

SELECT * FROM course WHERE mandatory IS NULL;
SELECT * FROM course WHERE mandatory IS NOT NULL;

SELECT name, mandatory FROM course;
SELECT name, COALESCE(mandatory, FALSE) AS is_mandatory FROM course;

ALTER TABLE course
DROP COLUMN mandatory;

TRUNCATE TABLE course;
DROP TABLE course;
DELETE FROM course WHERE teacher_id = 1;
*/


-- SQL Queries
/*
SELECT 3 * 5;

SELECT * FROM teacher;
SELECT * FROM course;

SELECT * FROM course ORDER BY hours;
SELECT * FROM course ORDER BY hours DESC;
SELECT * FROM course ORDER BY hours DESC LIMIT 2;

SELECT name, hours FROM course;
SELECT name, hours FROM course WHERE hours >= 100 AND hours <= 150;
SELECT name, hours FROM course WHERE hours BETWEEN 100 AND 150;

SELECT * FROM course WHERE classroom = 'B1';
SELECT * FROM course WHERE classroom LIKE '_1';
SELECT * FROM course WHERE classroom LIKE '%1';
SELECT * FROM course WHERE name LIKE '%p%';


-- Consultas de Agregación

SELECT classroom FROM course;
SELECT COUNT(classroom) AS classrooms FROM course;
SELECT COUNT(DISTINCT classroom) AS classrooms FROM course;

SELECT SUM(hours) AS total_hours FROM course;
SELECT SUM(hours) AS total_hours FROM course WHERE teacher_id = 1;

SELECT AVG(hours) AS avg_hours FROM course;

SELECT MAX(hours) AS max_hours, MIN(hours) AS min_hours FROM course;

SELECT * FROM course WHERE hours = (SELECT MAX(hours) FROM course);

SELECT teacher_id, SUM(hours) AS total_hours FROM course GROUP BY teacher_id;
SELECT teacher_id, SUM(hours) AS total_hours FROM course GROUP BY teacher_id HAVING total_hours > 200;


-- Joins

SELECT *
FROM course c
JOIN teacher t ON c.teacher_id = t.id;

SELECT c.name AS course_name, c.hours, c.classroom, t.name AS teacher_name, t.surname
FROM course c
JOIN teacher t ON c.teacher_id = t.id;

SELECT c.name AS course_name, c.hours, c.classroom, t.name AS teacher_name, t.surname
FROM course c
LEFT JOIN teacher t ON c.teacher_id = t.id;

SELECT c.name AS course_name, c.hours, c.classroom, t.name AS teacher_name, t.surname
FROM course c
RIGHT JOIN teacher t ON c.teacher_id = t.id;

SELECT c.name AS course_name, c.hours, c.classroom, t.name AS teacher_name, t.surname
FROM course c
JOIN teacher t ON c.teacher_id = t.id
WHERE c.hours > 100;

SELECT t.name, SUM(c.hours) AS total_hours
FROM course c
JOIN teacher t ON c.teacher_id = t.id
GROUP BY t.name;

SELECT t.name, t.surname, SUM(c.hours) AS total_hours
FROM course c
JOIN teacher t ON c.teacher_id = t.id
GROUP BY t.name, t.surname;
*/


-- Modificación de Tablas (DDL)
/*
SELECT * FROM course;

ALTER TABLE course
ADD mandatory BOOL;

UPDATE course SET mandatory = TRUE WHERE hours > 100;

SELECT * FROM course WHERE mandatory IS NULL;
SELECT * FROM course WHERE mandatory IS NOT NULL;

SELECT name, mandatory FROM course;
SELECT name, COALESCE(mandatory, FALSE) AS is_mandatory FROM course;

ALTER TABLE course 
DROP COLUMN mandatory;

-- TRUNCATE TABLE course;
-- DROP TABLE course;
-- DELETE FROM course WHERE teacher_id = 1;
*/


-- Vistas
/*
CREATE VIEW course_class_hours AS
SELECT name, classroom, hours
FROM course;

SELECT * FROM course_class_hours;

DROP VIEW course_class_hours;


CREATE VIEW teacher_per_course AS
SELECT c.name AS course_name, c.hours, c.classroom, t.name AS teacher_name, t.surname AS teacher_surname
FROM course c
JOIN teacher t ON c.teacher_id = t.id;

SELECT * FROM teacher_per_course;
*/


-- Índices
/*
CREATE INDEX idx_classroom ON course(classroom);

SELECT * FROM course WHERE classroom = 'B1';
*/


-- Procedimientos Almacenados
/*
DELIMITER $$

CREATE PROCEDURE show_long_courses()
BEGIN
	SELECT name, hours
	FROM course
	WHERE hours >= 150;
END$$


DELIMITER ;

CALL show_long_courses();


DELIMITER $$

CREATE PROCEDURE insert_new_teacher(IN name VARCHAR(255), surname VARCHAR(255))
BEGIN
	INSERT INTO teacher (name, surname) VALUES (name, surname);
END$$

DELIMITER ;

CALL insert_new_teacher('David', 'Gutierrez');

SELECT * FROM teacher;


DELIMITER $$

CREATE PROCEDURE insert_new_course(IN
	name VARCHAR(255),
	hours INT,
	classroom VARCHAR(255),
	vacations VARCHAR(255),
	teacher_id INT
)
BEGIN
	INSERT INTO course (name, hours, classroom, vacations, teacher_id)
	VALUES (name, hours, classroom, vacations, teacher_id);
END$$

DELIMITER ;

CALL insert_new_course('Politics', 100, 'A3', '2 weeks', 3);

SELECT * FROM course;
*/







