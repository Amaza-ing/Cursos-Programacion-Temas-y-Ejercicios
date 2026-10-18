# **Exercises - Topic 15: Subqueries and Queries with WITH**

Below you will find 7 practical exercises to work with subqueries and queries with `WITH` in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Subquery in WHERE with IN**

Shows the names of the products that have been purchased in orders whose amount exceeds €150.

<details><summary>Show Solution</summary>

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

### **Exercise 2: Subquery in SELECT**

Shows the name of each customer and the total number of different products they have purchased.

<details><summary>Show Solution</summary>

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

### **Exercise 3: Subquery in FROM with aliases**

Create a query that shows customers who have spent more than €300, using a subquery in the `FROM` clause.

<details><summary>Show Solution</summary>

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

### **Exercise 4: Query WITH for recent orders**

It uses `WITH` to define a temporary table `pedidos_recientes` with orders placed in April 2025, and queries its `order_id` and `customer_id`.

<details><summary>Show Solution</summary>

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

### **Exercise 5: WITH + JOIN**

Define two subqueries with `WITH`: one for customers who have placed orders, another for products sold more than once. Join the two to show the customer and product IDs.

<details><summary>Show Solution</summary>

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

### **Exercise 6: Subquery with scalar comparison**

Shows the name of the customer who placed the most expensive order of all.

<details><summary>Show Solution</summary>

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

### **Exercise 7: Correlated subquery**

Shows each customer's name and the total amount of their most recent order.

<details><summary>Show Solution</summary>

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
