# **Exercises - Topic 18: Use of IF in Queries and Stored Procedures in MySQL**

Below, you will find 6 practical exercises to work with **IF** in MySQL, both as a function in queries and as a control structure in procedures.

Try to solve them before consulting the solution.

---

### **Exercise 1: IF in query for price classification**

In the `products(id, name, price)` table, displays the name and a calculated column `categoria_precio` that indicates `'Caro'` if `price > 50`, otherwise `'Económico'`.

<details><summary>Show Solution</summary>

```sql
SELECT name,
       IF(price > 50, 'Caro', 'Económico') AS categoria_precio
FROM products;
```

</details>

---

### **Exercise 2: IF in query with date comparison**

In the `events(id, name, event_date)` table, display the name and an `estado_evento` field indicating `'Pasado'` if `event_date` is before the current date, or `'Próximo'` otherwise.

<details><summary>Show Solution</summary>

```sql
SELECT name,
       IF(event_date < CURDATE(), 'Pasado', 'Próximo') AS estado_evento
FROM events;
```

</details>

---

### **Exercise 3: Procedure with IF and ELSEIF**

Create a procedure `evaluar_producto` that receives `p_id INT` and displays:

- `'Muy caro'` yes `price > 100`
- `'Caro'` yes `price > 50`
- `'Económico'` otherwise.

<details><summary>Show Solution</summary>

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

In the `orders(id, total_amount)` table, display the `id`, the `total_amount`, and an `total_con_envio` column that sums to 5 if `total_amount` is less than 50, otherwise leave the same value.

<details><summary>Show Solution</summary>

```sql
SELECT id,
       total_amount,
       IF(total_amount < 50, total_amount + 5, total_amount) AS total_con_envio
FROM orders;
```

</details>

---

### **Exercise 5: Procedure with nested IF**

Create a procedure `clasificar_cliente_por_pedidos` that receives `p_id INT` and classifies like this:

- `'Sin pedidos'` if you have no records in `orders`.
- `'Cliente nuevo'` if you have 1 or 2 orders.
- `'Cliente recurrente'` if you have more than 2 orders.

<details><summary>Show Solution</summary>

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

### **Exercise 6: IF in combination with other functions**

In the `employees(id, hire_date)` table, display the `id`, the `hire_date`, and an `antiguedad_categoria` column indicating `'Antiguo'` if you have been with the company for more than 5 years, otherwise `'Reciente'`.

<details><summary>Show Solution</summary>

```sql
SELECT id,
       hire_date,
       IF(TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5, 'Antiguo', 'Reciente') AS antiguedad_categoria
FROM employees;
```

</details>
