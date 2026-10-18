# **Exercises - Topic 18: Using IF in Queries and Stored Procedures in MySQL**

Below you will find 6 practical exercises to work with **IF** in MySQL, both as a function in queries and as a control structure in procedures.

Try to solve them before looking at the solution.

---

### **Exercise 1: IF in a query to classify prices**

In the `products(id, name, price)` table, display the name and a calculated column `categoria_precio` that shows `'Caro'` if `price > 50`, and `'Económico'` otherwise.

<details><summary>Show solution</summary>

```sql
SELECT name,
       IF(price > 50, 'Caro', 'Económico') AS categoria_precio
FROM products;
```

</details>

---

### **Exercise 2: IF in a query with a date comparison**

In the `events(id, name, event_date)` table, display the name and an `estado_evento` field that shows `'Pasado'` if `event_date` is before the current date, or `'Próximo'` otherwise.

<details><summary>Show solution</summary>

```sql
SELECT name,
       IF(event_date < CURDATE(), 'Pasado', 'Próximo') AS estado_evento
FROM events;
```

</details>

---

### **Exercise 3: Procedure with IF and ELSEIF**

Create an `evaluar_producto` procedure that takes `p_id INT` and displays:

- `'Muy caro'` if `price > 100`
- `'Caro'` if `price > 50`
- `'Económico'` otherwise.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE evaluar_producto(IN p_id INT)
BEGIN
  DECLARE v_precio DECIMAL(10,2);
  SELECT price INTO v_precio FROM products WHERE id = p_id;

  IF v_precio > 100 THEN
    SELECT 'Muy caro' AS resultado;
  ELSEIF v_precio > 50 THEN
    SELECT 'Caro' AS resultado;
  ELSE
    SELECT 'Económico' AS resultado;
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 4: IF in SELECT with additional calculation**

In the `orders(id, total_amount)` table, display the `id`, the `total_amount` and a `total_con_envio` column that adds 5 if `total_amount` is less than 50, and otherwise keeps the same value.

<details><summary>Show solution</summary>

```sql
SELECT id,
       total_amount,
       IF(total_amount < 50, total_amount + 5, total_amount) AS total_con_envio
FROM orders;
```

</details>

---

### **Exercise 5: Procedure with nested IF**

Create a `clasificar_cliente_por_pedidos` procedure that takes `p_id INT` and classifies the customer like this:

- `'Sin pedidos'` if they have no records in `orders`.
- `'Cliente nuevo'` if they have 1 or 2 orders.
- `'Cliente recurrente'` if they have more than 2 orders.

<details><summary>Show solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE clasificar_cliente_por_pedidos(IN p_id INT)
BEGIN
  DECLARE v_total_pedidos INT;
  SELECT COUNT(*) INTO v_total_pedidos FROM orders WHERE customer_id = p_id;

  IF v_total_pedidos = 0 THEN
    SELECT 'Sin pedidos' AS categoria;
  ELSEIF v_total_pedidos <= 2 THEN
    SELECT 'Cliente nuevo' AS categoria;
  ELSE
    SELECT 'Cliente recurrente' AS categoria;
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Exercise 6: IF combined with other functions**

In the `employees(id, hire_date)` table, display the `id`, the `hire_date` and an `antiguedad_categoria` column that shows `'Antiguo'` if the employee has been with the company for more than 5 years, and `'Reciente'` otherwise.

<details><summary>Show solution</summary>

```sql
SELECT id,
       hire_date,
       IF(TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5, 'Antiguo', 'Reciente') AS antiguedad_categoria
FROM employees;
```

</details>
