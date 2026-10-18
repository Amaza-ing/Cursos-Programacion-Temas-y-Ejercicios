# **Exercises - Topic 11: Stored Procedures**

Below, you will find 8 practical exercises to create, run and manage **stored procedures** in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Procedure without parameters**

Create a procedure `list_active_customers` that returns all clients whose column `is_active` is `TRUE`.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE list_active_customers()
BEGIN
  SELECT *
  FROM customers
  WHERE is_active = TRUE;
END $$
DELIMITER ;

CALL list_active_customers();
```

</details>

---

### **Exercise 2: Procedure with IN parameter**

Create a procedure `get_orders_by_customer` that receives `p_customer_id INT` and returns orders (`orders`) from that customer sorted by descending `created_at`.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE get_orders_by_customer(IN p_customer_id INT)
BEGIN
  SELECT id AS order_id, total_amount, created_at
  FROM orders
  WHERE customer_id = p_customer_id
  ORDER BY created_at DESC;
END $$
DELIMITER ;

CALL get_orders_by_customer(2);
```

</details>

---

### **Exercise 3: Procedure with OUT parameter**

Create a procedure `count_orders_in_range` that receives two dates `p_from DATE`, `p_to DATE` and returns for `OUT p_total INT` how many orders there are in that range (inclusive).

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE count_orders_in_range(
  IN p_from DATE,
  IN p_to DATE,
  OUT p_total INT
)
BEGIN
  SELECT COUNT(*) INTO p_total
  FROM orders
  WHERE DATE(created_at) BETWEEN p_from AND p_to;
END $$
DELIMITER ;

CALL count_orders_in_range('2025-04-01','2025-04-30', @total);
SELECT @total AS total_orders_april;
```

</details>

---

### **Exercise 4: Procedure with INOUT parameter**

Create a procedure `apply_discount_if_high_spender` that receives `IN p_customer_id INT` and `INOUT p_discount DECIMAL(5,2)`. If the customer has spent more than 500 in total (sum of `total_amount`), increase `p_discount` by `2.50`; if not, leave the value as is.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE apply_discount_if_high_spender(
  IN p_customer_id INT,
  INOUT p_discount DECIMAL(5,2)
)
BEGIN
  DECLARE v_total DECIMAL(12,2);
  SELECT IFNULL(SUM(total_amount),0) INTO v_total
  FROM orders
  WHERE customer_id = p_customer_id;

  IF v_total > 500 THEN
    SET p_discount = p_discount + 2.50;
  END IF;
END $$
DELIMITER ;

SET @disc = 1.00;
CALL apply_discount_if_high_spender(1, @disc);
SELECT @disc AS new_discount;
```

</details>

---

### **Exercise 5: Procedure with validation and `EXIT HANDLER`**

Create a procedure `create_product_safe` that inserts into `products(name, price)` validating that `price > 0`. If `price <= 0`, throw an error using `SIGNAL`. Add an `EXIT HANDLER` that catches any errors and makes `ROLLBACK`.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE create_product_safe(
  IN p_name VARCHAR(100),
  IN p_price DECIMAL(10,2)
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;

  START TRANSACTION;

  IF p_price <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'price must be greater than 0';
  END IF;

  INSERT INTO products(name, price) VALUES (p_name, p_price);

  COMMIT;
END $$
DELIMITER ;

CALL create_product_safe('Notebook', 3.50);
```

</details>

---

### **Exercise 6: Procedure that returns aggregates**

Create a procedure `customer_order_stats` that receives `p_customer_id` and returns: number of orders (`total_orders`), average amount (`avg_amount`) and last date (`last_order`).

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE customer_order_stats(IN p_customer_id INT)
BEGIN
  SELECT COUNT(*) AS total_orders,
         AVG(total_amount) AS avg_amount,
         MAX(created_at) AS last_order
  FROM orders
  WHERE customer_id = p_customer_id;
END $$
DELIMITER ;

CALL customer_order_stats(1);
```

</details>

---

### **Exercise 7: Procedure with optional parameters (simulated)**

Create a procedure `search_customers` with `IN p_name VARCHAR(100)` and `IN p_city VARCHAR(100)`. If a parameter arrives `NULL`, it does not filter on that field.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE search_customers(
  IN p_name VARCHAR(100),
  IN p_city VARCHAR(100)
)
BEGIN
  SELECT *
  FROM customers
  WHERE (p_name IS NULL OR first_name LIKE CONCAT('%', p_name, '%'))
    AND (p_city IS NULL OR city = p_city);
END $$
DELIMITER ;

CALL search_customers('an', NULL);
```

</details>

---

### **Exercise 8: Replace and delete procedures**

1. Create `get_last_orders` that receives `p_limit INT` and returns the latest `p_limit` orders.
2. Modify it to also return `customer_id` and rename it.
3. Delete it.

<details><summary>Show Solution</summary>

```sql
-- 1) Crear
DELIMITER $$
CREATE PROCEDURE get_last_orders(IN p_limit INT)
BEGIN
  SELECT id AS order_id, created_at
  FROM orders
  ORDER BY created_at DESC
  LIMIT p_limit;
END $$
DELIMITER ;

CALL get_last_orders(5);

-- 2) Reemplazar
DELIMITER $$
DROP PROCEDURE IF EXISTS get_last_orders;
CREATE PROCEDURE get_last_orders(IN p_limit INT)
BEGIN
  SELECT id AS order_id, customer_id, created_at
  FROM orders
  ORDER BY created_at DESC
  LIMIT p_limit;
END $$
DELIMITER ;

CALL get_last_orders(3);

-- 3) Eliminar
DROP PROCEDURE get_last_orders;
```

</details>
