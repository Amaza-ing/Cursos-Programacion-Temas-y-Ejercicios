# **Topic 16: Using PARTITION BY in MySQL**

In this topic we will learn to:

- Understand what `PARTITION BY` is and when to use it.
- Apply it with window functions (`window functions`).
- Differentiate `PARTITION BY` from `GROUP BY`.

---

## **1. What is PARTITION BY?**

`PARTITION BY` is a clause used in conjunction with **window functions** to divide a result set into groups (partitions) and apply a function on each group **without collapsing the rows** as `GROUP BY` would do.

It is executed after the `FROM` and `WHERE` clause, but before `ORDER BY`.

---

## **2. Basic syntax**

```sql
funcion_ventana(...) OVER (PARTITION BY columna)
```

You can combine it with `ORDER BY` within the same `OVER`:

```sql
funcion_ventana(...) OVER (PARTITION BY columna ORDER BY otra_columna)
```

---

## **3. Basic example**

Let's assume the table `orders(id, customer_id, total_amount, created_at)`.

We want to know the **total orders** per customer, showing all rows:

```sql
SELECT id,
       customer_id,
       total_amount,
       COUNT(*) OVER (PARTITION BY customer_id) AS pedidos_por_cliente
FROM orders;
```

> Unlike `GROUP BY`, this result shows all the original rows along with the added information.

---

## **4. Use PARTITION BY with common window functions**

- `ROW_NUMBER()`: Number rows in each partition.
- `RANK()` and `DENSE_RANK()`: Assign ranges per partition.
- `SUM()`, `AVG()`, `COUNT()`: Add data within each partition.

**Example:** Ranking of orders by amount within each client.

```sql
SELECT customer_id,
       id AS order_id,
       total_amount,
       RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS rank_cliente
FROM orders;
```

---

## **5. Differences between PARTITION BY and GROUP BY**

| Feature | PARTITION BY | GROUP BY |
| ----------------------------------- | ------------ | ----------------------------------- |
| Keeps all original rows | Yes | No (collapses into one per group) |
| Used with window functions | Yes | No |
| Returns ungrouped columns | Yes | Only aggregated or grouped columns |

---

## **6. Combine PARTITION BY and ORDER BY**

We can obtain accumulated accumulated within each partition:

```sql
SELECT customer_id,
       id AS order_id,
       total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY created_at) AS acumulado
FROM orders;
```

---

[![PARTITION BY](https://img.youtube.com/vi/uGM8a25TKNU/0.jpg)](https://www.youtube.com/watch?v=uGM8a25TKNU&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Good practices**

- Use `PARTITION BY` when you need group calculations without losing row detail.
- Combine it with `ORDER BY` to obtain cumulative results or rankings.
- Do not abuse window functions on very large tables without appropriate indexes.

---

## **8. Conclusion**

- `PARTITION BY` divides results into groups to apply window functions.
- Unlike `GROUP BY`, it keeps all the original rows.
- It is useful to obtain metrics by group while preserving the detail of each row.

---

In the next topic we will see **What they are and how to use transactions**.
