# **Ejercicios - Tema 11: Procedimientos Almacenados**

A continuación, encontrarás 8 ejercicios prácticos para crear, ejecutar y gestionar **procedimientos almacenados** en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Procedimiento sin parámetros**

Crea un procedimiento `list_active_customers` que devuelva todos los clientes cuya columna `is_active` sea `TRUE`.

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 2: Procedimiento con parámetro IN**

Crea un procedimiento `get_orders_by_customer` que reciba `p_customer_id INT` y devuelva los pedidos (`orders`) de ese cliente ordenados por `created_at` descendente.

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 3: Procedimiento con parámetro OUT**

Crea un procedimiento `count_orders_in_range` que reciba dos fechas `p_from DATE`, `p_to DATE` y devuelva por `OUT p_total INT` cuántos pedidos hay en ese rango (inclusive).

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 4: Procedimiento con parámetro INOUT**

Crea un procedimiento `apply_discount_if_high_spender` que reciba `IN p_customer_id INT` y `INOUT p_discount DECIMAL(5,2)`. Si el cliente ha gastado más de 500 en total (suma de `total_amount`), incrementa `p_discount` en `2.50`; si no, deja el valor como está.

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 5: Procedimiento con validación e `EXIT HANDLER`**

Crea un procedimiento `create_product_safe` que inserte en `products(name, price)` validando que `price > 0`. Si `price <= 0`, lanza un error usando `SIGNAL`. Añade un `EXIT HANDLER` que capture cualquier error y haga `ROLLBACK`.

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 6: Procedimiento que devuelve agregados**

Crea un procedimiento `customer_order_stats` que reciba `p_customer_id` y devuelva: número de pedidos (`total_orders`), importe medio (`avg_amount`) y última fecha (`last_order`).

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 7: Procedimiento con parámetros opcionales (simulados)**

Crea un procedimiento `search_customers` con `IN p_name VARCHAR(100)` y `IN p_city VARCHAR(100)`. Si un parámetro llega `NULL`, no filtra por ese campo.

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 8: Reemplazar y eliminar procedimientos**

1. Crea `get_last_orders` que reciba `p_limit INT` y devuelva los últimos `p_limit` pedidos.
2. Modifícalo para que también devuelva `customer_id` y renómbralo.
3. Elimínalo.

<details><summary>Mostrar Solución</summary>

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
