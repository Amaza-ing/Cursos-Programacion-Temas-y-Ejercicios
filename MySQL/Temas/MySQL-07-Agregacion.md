# **Topic 7: Aggregation and Grouping Functions in MySQL**

In this topic we will learn to:

- Use aggregation functions (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`).
- Group data with `GROUP BY`.
- Filter groupings with `HAVING`.

---

## **1. What are aggregation functions?**

They are functions that operate on a set of values and return a single result.

| Function | Description |
| --------- | ------------------------- |
| `SUM()` | Sum of numerical values ​​|
| `COUNT()` | Record Account |
| `AVG()` | Average |
| `MAX()` | Maximum value |
| `MIN()` | Minimum value |

---

## **2. Examples of aggregation functions**

Suppose we have the table `orders`:

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

## **3. Group data with `GROUP BY`**

The `GROUP BY` allows you to apply aggregation functions by groups of a specific column.

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

## **4. Filter groups with `HAVING`**

The `HAVING` clause is used to apply conditions after data is grouped (unlike `WHERE`, which is used before grouping).

### **Example: customers who spent more than €100**

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id
HAVING total_gastado > 100;
```

---

## **5. Group by multiple columns**

It is also possible to group by more than one column:

### **Example: number of orders per customer and per date**

```sql
SELECT customer_id, DATE(created_at) AS fecha, COUNT(*) AS pedidos
FROM orders
GROUP BY customer_id, fecha;
```

---

[![Aggregation Queries | COUNT | SUM | AVG | MIN | MAX](https://img.youtube.com/vi/hMI1WZ-9LhQ/0.jpg)](https://www.youtube.com/watch?v=hMI1WZ-9LhQ&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. Conclusion**

- Aggregation functions allow data to be summarized.
- `GROUP BY` groups the registers to apply functions like `SUM` or `COUNT`.
- `HAVING` allows filtering groups according to conditions.
- These tools are very useful for generating reports, statistics and summaries.

---

In the next topic we will learn how to join multiple tables with `JOIN` to query related data.**
