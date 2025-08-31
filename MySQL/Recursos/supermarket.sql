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

/*
-- WITH

SELECT * FROM orders;

SELECT vendor, SUM(quantity) AS total
FROM orders
GROUP BY vendor;

SELECT opv.vendor, opv.total
FROM (
	SELECT vendor, SUM(quantity) AS total
	FROM orders
	GROUP BY vendor
) opv
WHERE opv.total > 200;

WITH orders_per_vendor AS (
	SELECT vendor, SUM(quantity) AS total
	FROM orders
	GROUP BY vendor
)
SELECT vendor, total
FROM orders_per_vendor
WHERE total > 200;


WITH orders_per_vendor AS (
	SELECT vendor, SUM(quantity) AS total
	FROM orders
	GROUP BY vendor
)
SELECT o.vendor, d.name, o.quantity
FROM orders o
JOIN drink d ON d.id = o.drink_id
JOIN orders_per_vendor opv ON opv.vendor = o.vendor
WHERE opv.total > 200;


WITH orders_per_vendor AS (
	SELECT vendor, SUM(quantity) AS total
	FROM orders
	GROUP BY vendor
)
SELECT o.vendor, d.name, SUM(o.quantity) AS total_quantity
FROM orders o
JOIN drink d ON d.id = o.drink_id
JOIN orders_per_vendor opv ON opv.vendor = o.vendor
WHERE opv.total > 200
GROUP BY o.vendor, d.name;
*/


-- PARTITION BY
/*
SELECT
	vendor,
	drink_id,
	quantity,
	SUM(quantity) OVER (PARTITION BY vendor) AS total_per_vendor
FROM orders;
*/


-- TRANSACTIONS
/*
SELECT * FROM drink;

START TRANSACTION;

UPDATE drink
SET is_available = FALSE
WHERE id = 1;

UPDATE drink
SET is_available = FALSE
WHERE id = 2;

UPDATE drink
SET is_available = FALSE
WHERE unique_id = 100;

COMMIT;

SELECT * FROM drink;

ROLLBACK;
*/


-- IF
/*
DELIMITER $$

CREATE PROCEDURE review_stock(IN quantity INT)
BEGIN
	IF quantity > 100 THEN
		SELECT 'Stock alto';
	ELSEIF quantity BETWEEN 50 AND 100 THEN
		SELECT 'Stock Medio';
	ELSE
		SELECT 'Stock Bajo';
	END IF;
END$$

DELIMITER ;


CALL review_stock(120);
CALL review_stock(75);
CALL review_stock(30);


SELECT
	name,
	IF(is_available = TRUE, 'Available', 'Not Available') AS state
FROM drink;



DELIMITER $$

CREATE PROCEDURE verify_availability(IN my_drink_id INT)
BEGIN
	DECLARE available BOOL;

	SELECT is_available INTO available
	FROM drink
	WHERE id = my_drink_id;
	
	IF available THEN
		SELECT 'Disponible';
	ELSE
		SELECT 'No Disponible';
	END IF;
END$$

DELIMITER ;

CALL verify_availability(3);
*/




