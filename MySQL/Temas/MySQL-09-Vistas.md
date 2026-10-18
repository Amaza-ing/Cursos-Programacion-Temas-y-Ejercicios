# **Topic 9: Create and Manage Views (VIEW) in MySQL**

In this topic we will learn how to:

- Understand what a view (`VIEW`) is.
- Create views to simplify complex queries.
- Update, delete and use views as virtual tables.

---

## **1. What is a view (VIEW)?**

A **view** is a saved query that behaves like a virtual table. It does not store any data itself; instead, it shows the result of a query every time it is accessed.

### **Advantages:**

- It hides the complexity of long queries.
- It improves code readability and maintainability.
- It can limit access to certain data.

---

## **2. Creating a view**

### **Basic syntax:**

```sql
CREATE VIEW nombre_vista AS
SELECT columnas
FROM tabla(s)
WHERE condición;
```

### **Example:**

A view that shows orders with customer information:

```sql
CREATE VIEW pedidos_con_clientes AS
SELECT o.id AS order_id, c.first_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

---

## **3. Querying a view**

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

## **4. Updating a view**

You can modify a view with `CREATE OR REPLACE VIEW`:

```sql
CREATE OR REPLACE VIEW pedidos_con_clientes AS
SELECT o.id, c.first_name, c.last_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

> Keep in mind that only some views can be updated directly (when they do not contain aggregate functions, `GROUP BY`, `DISTINCT`, etc.).

---

## **5. Deleting a view**

To delete a view:

```sql
DROP VIEW pedidos_con_clientes;
```

---

## **6. Checking existing views**

To see all the views defined in the database:

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
- They are useful for structuring queries better and reusing them.
- Although they look like tables, they do not store data directly.

---

In the next topic we will learn how to **create and use indexes.**
