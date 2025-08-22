DROP SCHEMA IF EXISTS supermarket;
CREATE SCHEMA supermarket;
USE supermarket;

CREATE TABLE drink (
	id INT AUTO_INCREMENT,
	name VARCHAR(255),
	expiration_date DATETIME,
	is_available BOOL,
	PRIMARY KEY (id)
);

INSERT INTO drink (name, expiration_date, is_available ) VALUES
('coffee', '2025-09-20', TRUE),
('water', '2040-12-31', TRUE),
('beer', '2025-10-30', FALSE);

CREATE TABLE orders (
	id INT AUTO_INCREMENT,
	vendor VARCHAR(255),
	drink_id INT,
	quantity INT,
	PRIMARY KEY (id),
	FOREIGN KEY (drink_id) REFERENCES drink(id)
);

INSERT INTO orders (vendor, drink_id, quantity) VALUES
('Ana', 1, 100),
('Ana', 2, 100),
('Carlos', 3, 150),
('Ana', 1, 50),
('Carlos', 3, 75),
('David', 2, 120);



-- SQL Queries
/*
SELECT * FROM drink;
SELECT * FROM drink WHERE is_available IS TRUE;
SELECT * FROM drink WHERE is_available;

SELECT name, EXTRACT(MONTH FROM expiration_date) AS month FROM drink WHERE is_available;
SELECT CURDATE();
SELECT CURRENT_DATE;
SELECT DATE_ADD(CURDATE(), INTERVAL 3 MONTH) AS date_3_months_from_now;
SELECT name, DATE_ADD(CURDATE(), INTERVAL 3 MONTH) AS date_3_months_from_now FROM drink;

SELECT *
FROM drink
WHERE expiration_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 MONTH);

SELECT *
FROM drink
WHERE
	expiration_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 MONTH)
	AND
	is_available;
*/







