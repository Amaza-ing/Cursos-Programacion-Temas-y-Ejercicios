# **Topic 16: Using PARTITION BY in MySQL**

In this topic we will learn how to:

- Understand what `PARTITION BY` is and when to use it.
- Apply it with window functions (`window functions`).
- Tell `PARTITION BY` apart from `GROUP BY`.

---

## **1. What is PARTITION BY?**

`PARTITION BY` is a clause used together with **window functions** to divide a result set into groups (partitions) and apply a function to each group **without collapsing the rows**, as `GROUP BY` would.

It is evaluated after the `FROM` and `WHERE` clauses, but before `ORDER BY`.

---

## **2. Basic syntax**

```sql
funcion_ventana(...) OVER (PARTITION BY columna)
```

You can combine it with `ORDER BY` inside the same `OVER`:

```sql
funcion_ventana(...) OVER (PARTITION BY columna ORDER BY otra_columna)
```

---

## **3. Basic example**

Suppose we have the table `orders(id, customer_id, total_amount, created_at)`.

We want to know the **total number of orders** per customer, while showing all the rows:

```sql
SELECT id,
       customer_id,
       total_amount,
       COUNT(*) OVER (PARTITION BY customer_id) AS pedidos_por_cliente
FROM orders;
```

> Unlike `GROUP BY`, this result shows all the original rows along with the added information.

---

## **4. Using PARTITION BY with common window functions**

- `ROW_NUMBER()`: numbers the rows in each partition.
- `RANK()` and `DENSE_RANK()`: assign ranks within each partition.
- `SUM()`, `AVG()`, `COUNT()`: aggregate data within each partition.

**Example:** ranking each customer's orders by amount.

```sql
SELECT customer_id,
       id AS order_id,
       total_amount,
       RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS rank_cliente
FROM orders;
```

---

## **5. Differences between PARTITION BY and GROUP BY**

| Characteristic | PARTITION BY | GROUP BY |
| ----------------------------------- | ------------ | ----------------------------------- |
| Keeps all the original rows | Yes | No (collapses them into one per group) |
| Used with window functions | Yes | No |
| Returns non-grouped columns | Yes | Only aggregated or grouped columns |

---

## **6. Combining PARTITION BY and ORDER BY**

We can get ordered running totals within each partition:

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

- Use `PARTITION BY` when you need per-group calculations without losing the detail of each row.
- Combine it with `ORDER BY` to get cumulative results or rankings.
- Don't overuse window functions on very large tables without appropriate indexes.

---

## **8. Conclusion**

- `PARTITION BY` divides the results into groups to apply window functions.
- Unlike `GROUP BY`, it keeps all the original rows.
- It is useful for getting per-group metrics while preserving the detail of each row.

---

In the next topic we will see **what transactions are and how to use them**.
