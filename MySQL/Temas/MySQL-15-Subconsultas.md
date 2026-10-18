# **Topic 15: Subqueries and Queries with WITH in MySQL**

In this topic we will learn how to:

- Use subqueries to build more complex queries.
- Understand subqueries in `SELECT`, `FROM` and `WHERE` clauses.
- Use common table expressions (`WITH`) to organize reusable temporary queries.

---

## **1. What is a subquery?**

A **subquery** is a query inside another query. It lets you get intermediate data that is used as input for the main query.

### **Basic example:**

```sql
SELECT *
FROM customers
WHERE id IN (
  SELECT customer_id FROM orders WHERE total_amount > 100
);
```

---

## **2. Subqueries in the WHERE clause**

They are used to filter results based on a condition that depends on another table.

```sql
SELECT name
FROM products
WHERE id IN (
  SELECT product_id FROM order_details WHERE quantity >= 5
);
```

---

## **3. Subqueries in the FROM clause**

They let you create temporary tables that can then be queried.

```sql
SELECT customer_id, total
FROM (
  SELECT customer_id, SUM(total_amount) AS total
  FROM orders
  GROUP BY customer_id
) AS resumen
WHERE total > 200;
```

---

## **4. Subqueries in the SELECT clause**

They let you display additional values calculated for each row.

```sql
SELECT c.first_name,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) AS total_pedidos
FROM customers c;
```

---

## **5. Queries with WITH (Common Table Expressions)**

The `WITH` clause lets you define named temporary subqueries, which makes code easier to read and reuse.

### **Example:**

```sql
WITH ventas_por_cliente AS (
  SELECT customer_id, SUM(total_amount) AS total
  FROM orders
  GROUP BY customer_id
)
SELECT * FROM ventas_por_cliente
WHERE total > 150;
```

---

## **6. Multiple subqueries with WITH**

You can define multiple subqueries separated by commas.

```sql
WITH clientes_activos AS (
  SELECT id, first_name FROM customers WHERE newsletter_subscribed = TRUE
),
pedidos_totales AS (
  SELECT customer_id, COUNT(*) AS pedidos FROM orders GROUP BY customer_id
)
SELECT ca.first_name, pt.pedidos
FROM clientes_activos ca
JOIN pedidos_totales pt ON ca.id = pt.customer_id;
```

---

## **7. Advantages of using WITH**

- It improves readability.
- It lets you avoid repeating subqueries.
- It is ideal for complex queries broken down into steps.

---

[![Subqueries with WITH](https://img.youtube.com/vi/q4xodEiY8B8/0.jpg)](https://www.youtube.com/watch?v=q4xodEiY8B8&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusion**

- Subqueries let you bring intermediate results into a query.
- They can be used in `WHERE`, `FROM` and `SELECT`.
- `WITH` (CTE) provides a clean way to define reusable helper queries.

---

In the next topic we will learn how to **use PARTITION BY**.
