# **Topic 15: Subqueries and Queries with WITH in MySQL**

In this topic we will learn to:

- Use subqueries to build more complex queries.
- Understand subqueries in `SELECT`, `FROM` and `WHERE` clauses.
- Employ common table expressions (`WITH`) to organize reusable temporary queries.

---

## **1. What is a subquery?**

A **subquery** is a query within another query. It allows obtaining intermediate data that is used as input in the main query.

### **Basic example:**

```sql
SELECT *
FROM customers
WHERE id IN (
  SELECT customer_id FROM orders WHERE total_amount > 100
);
```

---

## **2. Subqueries in the WHERE** clause

Used to filter results based on a condition that depends on another table.

```sql
SELECT name
FROM products
WHERE id IN (
  SELECT product_id FROM order_details WHERE quantity >= 5
);
```

---

## **3. Subqueries in the FROM** clause

They allow you to create temporary tables that can later be consulted.

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

They allow you to display additional values calculated for each row.

```sql
SELECT c.first_name,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) AS total_pedidos
FROM customers c;
```

---

## **5. Queries with WITH (Common Table Expressions)**

The `WITH` clause allows you to define named temporary subqueries, making it easier to read and reuse code.

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

- Improves readability.
- Allows you to avoid repeating subqueries.
- Ideal for complex queries divided into steps.

---

[![Subqueries with WITH](https://img.youtube.com/vi/q4xodEiY8B8/0.jpg)](https://www.youtube.com/watch?v=q4xodEiY8B8&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusion**

- Subqueries allow intermediate results to be incorporated.
- They can be used in `WHERE`, `FROM`, `SELECT`.
- `WITH` (CTE) provides a clean way to define reusable helper queries.

---

In the next topic we will learn how to **use PARTITION BY**.
