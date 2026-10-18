# **Topic 6: Advanced Queries with SELECT and Conditions**

In this topic we will learn how to:

- Use `SELECT` to extract specific information from a table.
- Apply filters with `WHERE` and logical operators.
- Sort results with `ORDER BY`.
- Limit the number of rows with `LIMIT`.

---

## **1. SELECT: Basic queries**

The `SELECT` statement lets you query data from one or more columns.

### **Examples:**

```sql
SELECT * FROM customers; -- Todas las columnas
SELECT first_name, last_name FROM customers; -- Sólo algunas columnas
```

---

## **2. WHERE: Filtering results**

The `WHERE` clause lets you display only the rows that meet a condition.

### **Examples:**

```sql
SELECT * FROM customers
WHERE newsletter_subscribed = TRUE;

SELECT * FROM orders
WHERE total_amount > 100;
```

### **Common operators:**

- `=`: equal to
- `!=` or `<>`: not equal to
- `>` / `<`: greater than / less than
- `>=` / `<=`: greater than or equal to / less than or equal to
- `BETWEEN`: between two values
- `IN`: in a list
- `LIKE`: partial match with wildcards

```sql
SELECT * FROM customers WHERE first_name = 'Ana';
SELECT * FROM orders WHERE total_amount BETWEEN 50 AND 150;
SELECT * FROM customers WHERE city IN ('Madrid', 'Sevilla');
SELECT * FROM customers WHERE email LIKE '%@gmail.com';
```

---

## **3. Logical operators**

### **AND**: both conditions must be met

```sql
SELECT * FROM orders
WHERE total_amount > 100 AND customer_id = 2;
```

### **OR**: at least one condition must be met

```sql
SELECT * FROM customers
WHERE city = 'Madrid' OR city = 'Barcelona';
```

### **NOT**: negates the condition

```sql
SELECT * FROM customers
WHERE NOT newsletter_subscribed;
```

---

## **4. ORDER BY: Sorting results**

It sorts the rows by one or more columns.

```sql
SELECT * FROM customers
ORDER BY signup_date ASC; -- Orden ascendente

SELECT * FROM orders
ORDER BY total_amount DESC; -- Orden descendente
```

You can sort by multiple columns:

```sql
SELECT * FROM customers
ORDER BY city ASC, last_name ASC;
```

---

## **5. LIMIT: Limiting results**

It displays only a specific number of rows.

```sql
SELECT * FROM customers
LIMIT 5; -- Solo las primeras 5 filas
```

You can also specify an **offset**:

```sql
SELECT * FROM customers
LIMIT 5 OFFSET 10; -- Desde la fila 11 hasta la 15
```

---

## **6. Combining WHERE, ORDER BY and LIMIT**

```sql
SELECT * FROM orders
WHERE total_amount > 50
ORDER BY created_at DESC
LIMIT 3;
```

This query shows the 3 most recent orders with a total greater than 50.

---

## **7. Conclusion**

- `SELECT` lets you query specific data.
- `WHERE` filters results based on conditions.
- `ORDER BY` sorts the results.
- `LIMIT` restricts the number of rows displayed.
- By combining these tools you can write very powerful and specific queries.

---

[![Basic queries | SELECT | ORDER BY | WHERE](https://img.youtube.com/vi/AzHlT1fHuN8/0.jpg)](https://www.youtube.com/watch?v=AzHlT1fHuN8&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

In the next topic we will learn how to work with **aggregate functions (SUM, COUNT, AVG, MAX, MIN) and grouping with `GROUP BY`.**
