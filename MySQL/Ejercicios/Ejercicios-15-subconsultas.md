# **Ejercicios - Tema 15: Subconsultas y Consultas con WITH**

A continuación, encontrarás 7 ejercicios prácticos para trabajar con subconsultas y consultas con `WITH` en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Subconsulta en WHERE con IN**

Muestra los nombres de los productos que han sido comprados en pedidos cuyo importe supera los 150€.

<details><summary>Mostrar Solución</summary>

```sql
SELECT name
FROM products
WHERE id IN (
  SELECT product_id
  FROM order_details
  WHERE order_id IN (
    SELECT id FROM orders WHERE total_amount > 150
  )
);
```

</details>

---

### **Ejercicio 2: Subconsulta en SELECT**

Muestra el nombre de cada cliente y el número total de productos distintos que ha comprado.

<details><summary>Mostrar Solución</summary>

```sql
SELECT c.first_name,
       (SELECT COUNT(DISTINCT od.product_id)
        FROM orders o
        JOIN order_details od ON o.id = od.order_id
        WHERE o.customer_id = c.id) AS productos_distintos
FROM customers c;
```

</details>

---

### **Ejercicio 3: Subconsulta en FROM con alias**

Crea una consulta que muestre los clientes que han gastado más de 300€, usando una subconsulta en la cláusula `FROM`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT t.customer_id, t.total_gastado
FROM (
  SELECT customer_id, SUM(total_amount) AS total_gastado
  FROM orders
  GROUP BY customer_id
) AS t
WHERE t.total_gastado > 300;
```

</details>

---

### **Ejercicio 4: Consulta con WITH para pedidos recientes**

Utiliza `WITH` para definir una tabla temporal `pedidos_recientes` con los pedidos hechos en abril de 2025, y consulta su `order_id` y `customer_id`.

<details><summary>Mostrar Solución</summary>

```sql
WITH pedidos_recientes AS (
  SELECT id, customer_id
  FROM orders
  WHERE created_at BETWEEN '2025-04-01' AND '2025-04-30'
)
SELECT * FROM pedidos_recientes;
```

</details>

---

### **Ejercicio 5: WITH + JOIN**

Define dos subconsultas con `WITH`: una para clientes que han hecho pedidos, otra para productos vendidos más de una vez. Une ambas para mostrar los IDs de cliente y producto.

<details><summary>Mostrar Solución</summary>

```sql
WITH clientes_con_pedidos AS (
  SELECT DISTINCT customer_id FROM orders
),
productos_vendidos AS (
  SELECT product_id FROM order_details GROUP BY product_id HAVING COUNT(*) > 1
)
SELECT cp.customer_id, pv.product_id
FROM clientes_con_pedidos cp
JOIN productos_vendidos pv;
```

</details>

---

### **Ejercicio 6: Subconsulta con comparación escalar**

Muestra el nombre del cliente que ha realizado el pedido más caro de todos.

<details><summary>Mostrar Solución</summary>

```sql
SELECT first_name
FROM customers
WHERE id = (
  SELECT customer_id
  FROM orders
  ORDER BY total_amount DESC
  LIMIT 1
);
```

</details>

---

### **Ejercicio 7: Subconsulta correlacionada**

Muestra el nombre de cada cliente y el importe total de su pedido más reciente.

<details><summary>Mostrar Solución</summary>

```sql
SELECT c.first_name,
       (SELECT total_amount
        FROM orders o
        WHERE o.customer_id = c.id
        ORDER BY created_at DESC
        LIMIT 1) AS ultimo_importe
FROM customers c;
```

</details>
