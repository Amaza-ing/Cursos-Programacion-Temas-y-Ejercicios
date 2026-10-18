# **Topic 7: Aggregate Functions and Grouping in MySQL**

In this topic we will learn how to:

- Use aggregate functions (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`).
- Group data with `GROUP BY`.
- Filter groups with `HAVING`.

---

## **1. What are aggregate functions?**

They are functions that operate on a set of values and return a single result.

| Function | Description |
| --------- | ------------------------- |
| `SUM()` | Sum of numeric values |
| `COUNT()` | Count of records |
| `AVG()` | Average |
| `MAX()` | Maximum value |
| `MIN()` | Minimum value |

---

## **2. Examples of aggregate functions**

Suppose we have the `orders` table:

| order_id | customer_id | total_amount |
| -------- | ----------- | ------------ |
| 1 | 1 | 50.00 |
| 2 | 2 | 120.00 |
| 3 | 1 | 80.00 |

### **SUM**

```sql
SELECT SUM(total_amount) AS total_ventas FROM orders;
```

### **COUNT**

```sql
SELECT COUNT(*) AS total_pedidos FROM orders;
```

### **AVG**

```sql
SELECT AVG(total_amount) AS promedio FROM orders;
```

### **MAX / MIN**

```sql
SELECT MAX(total_amount) AS venta_maxima FROM orders;
SELECT MIN(total_amount) AS venta_minima FROM orders;
```

---

## **3. Grouping data with `GROUP BY`**

`GROUP BY` lets you apply aggregate functions to groups based on a specific column.

### **Example: total spent per customer**

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id;
```

### **Example: number of orders per customer**

```sql
SELECT customer_id, COUNT(*) AS cantidad_pedidos
FROM orders
GROUP BY customer_id;
```

---

## **4. Filtering groups with `HAVING`**

The `HAVING` clause is used to apply conditions after the data is grouped (unlike `WHERE`, which is applied before grouping).

### **Example: customers who spent more than €100**

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id
HAVING total_gastado > 100;
```

---

## **5. Grouping by multiple columns**

You can also group by more than one column:

### **Example: number of orders per customer and per date**

```sql
SELECT customer_id, DATE(created_at) AS fecha, COUNT(*) AS pedidos
FROM orders
GROUP BY customer_id, fecha;
```

---

[![Aggregate queries | COUNT | SUM | AVG | MIN | MAX](https://img.youtube.com/vi/hMI1WZ-9LhQ/0.jpg)](https://www.youtube.com/watch?v=hMI1WZ-9LhQ&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. Conclusion**

- Aggregate functions let you summarize data.
- `GROUP BY` groups the records so you can apply functions like `SUM` or `COUNT`.
- `HAVING` lets you filter groups based on conditions.
- These tools are very useful for generating reports, statistics and summaries.

---

In the next topic we will learn how to **join multiple tables with `JOIN` to query related data.**
