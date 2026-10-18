# **Topic 8: Queries with JOIN in MySQL**

In this topic we will learn how to:

- Understand what a `JOIN` is and what it is used for.
- Use different types of `JOIN` to combine information from multiple tables.
- Query related data across tables.

---

## **1. What is a JOIN?**

`JOIN` lets you combine rows from two or more tables based on a logical relationship between them, usually through foreign keys.

### **Basic example:**

Suppose we have the following tables:

**`customers` table**
| id | first_name |
|----|-------------|
| 1 | Laura |

**`orders` table**
| id | customer_id | total_amount |
|----|-------------|---------------|
| 1 | 1 | 89.99 |

We want to know which customer placed which order. We use a `JOIN`:

```sql
SELECT customers.first_name, orders.total_amount
FROM customers
JOIN orders ON customers.id = orders.customer_id;
```

---

## **2. Types of JOIN**

### **INNER JOIN**

Returns only the rows that have a match in both tables.

```sql
SELECT *
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id;
```

### **LEFT JOIN**

Returns all rows from the left table, and the matching rows from the right table (if any).

```sql
SELECT *
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;
```

### **RIGHT JOIN**

Returns all rows from the right table, and the matching rows from the left table.

```sql
SELECT *
FROM orders
RIGHT JOIN customers ON customers.id = orders.customer_id;
```

---

## **3. JOIN with aliases**

Using aliases makes queries more readable:

```sql
SELECT c.first_name, o.total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id;
```

---

## **4. JOIN with more than two tables**

We can also join more than two tables in the same query:

```sql
SELECT c.first_name, o.id AS order_id, p.name AS product_name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details d ON o.id = d.order_id
JOIN products p ON d.product_id = p.id;
```

---

## **5. Common queries with JOIN**

- Orders from each customer
- Products included in each order
- Total spent per customer
- Purchase history with product names

---

[![JOIN](https://img.youtube.com/vi/y9-JFPGvEsI/0.jpg)](https://www.youtube.com/watch?v=y9-JFPGvEsI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. Conclusion**

- `JOIN` lets you join related tables through keys.
- `INNER`, `LEFT` and `RIGHT` offer different ways to get the data.
- Aliases (`AS`) make queries easier to read.
- Complex queries often involve multiple `JOIN`s.

---

In the next topic we will learn how to **create and manage views (`VIEW`) to simplify and reuse complex queries.**
