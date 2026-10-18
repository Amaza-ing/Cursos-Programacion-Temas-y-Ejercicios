# **Topic 9: Create and Manage Views (VIEW) in MySQL**

In this topic we will learn to:

- Understand what a view is (`VIEW`).
- Create views to simplify complex queries.
- Update, delete and use views as virtual tables.

---

## **1. What is a view (VIEW)?**

A **view** is a saved query that behaves like a virtual table. It does not store data itself, but instead displays the result of a query each time it is accessed.

### **Advantages:**

- Hides the complexity of long queries.
- Improves code readability and maintainability.
- You can limit access to certain data.

---

## **2. Create a view**

### **Basic syntax:**

```sql
CREATE VIEW nombre_vista AS
SELECT columnas
FROM tabla(s)
WHERE condición;
```

### **Example:**

View showing orders with customer information:

```sql
CREATE VIEW pedidos_con_clientes AS
SELECT o.id AS order_id, c.first_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

---

## **3. Consult a view**

Once created, you can query the view as if it were a table:

```sql
SELECT * FROM pedidos_con_clientes;
```

You can also apply additional filters:

```sql
SELECT * FROM pedidos_con_clientes
WHERE total_amount > 100;
```

---

## **4. Update a view**

You can modify a view with `CREATE OR REPLACE VIEW`:

```sql
CREATE OR REPLACE VIEW pedidos_con_clientes AS
SELECT o.id, c.first_name, c.last_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

> Note that only some views can be updated directly (when they do not contain aggregation functions, `GROUP BY`, `DISTINCT`, etc.).

---

## **5. Delete a view**

To delete a view:

```sql
DROP VIEW pedidos_con_clientes;
```

---

## **6. Check existing views**

To view all views defined in the database:

```sql
SHOW FULL TABLES WHERE Table_type = 'VIEW';
```

---

## **7. When to use views**

Use views when:

- You need to reuse a long or complex query.
- You want to present combined data from several tables.
- You want to restrict access to specific columns.

---

[![Views](https://img.youtube.com/vi/7T5ZYN78JaM/0.jpg)](https://www.youtube.com/watch?v=7T5ZYN78JaM&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusion**

- Views simplify access to complex data.
- They are useful to better structure queries and reuse them.
- Although they look like tables, they do not store data directly.

---

In the next topic we will learn to **create and use indexes.**
