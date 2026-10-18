# **Exercises - Topic 9: Create and Manage Views (VIEW)**

Below you will find 5 practical exercises to work with views in MySQL. These exercises will help you simplify complex queries and reuse them efficiently.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create a view with filtered data**

Create a view called `clientes_suscritos` that shows only the customers who are subscribed to the newsletter (`newsletter_subscribed = TRUE`), including their names and sign-up dates.

<details><summary>Show solution</summary>

```sql
CREATE VIEW clientes_suscritos AS
SELECT first_name, last_name, signup_date
FROM customers
WHERE newsletter_subscribed = TRUE;
```

</details>

---

### **Exercise 2: Create a view with combined data**

Create a view called `resumen_pedidos` that shows, for each order, the order ID, the customer's name and the order date.

<details><summary>Show solution</summary>

```sql
CREATE VIEW resumen_pedidos AS
SELECT o.id AS order_id, c.first_name, c.last_name, o.created_at
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

</details>

---

### **Exercise 3: Query a view with additional conditions**

Use the `resumen_pedidos` view to get the orders placed on or after April 1, 2025.

<details><summary>Show solution</summary>

```sql
SELECT * FROM resumen_pedidos
WHERE created_at >= '2025-04-01';
```

</details>

---

### **Exercise 4: Modify an existing view**

Update the `clientes_suscritos` view so that it also shows the customer's city (`city` field).

<details><summary>Show solution</summary>

```sql
CREATE OR REPLACE VIEW clientes_suscritos AS
SELECT first_name, last_name, city, signup_date
FROM customers
WHERE newsletter_subscribed = TRUE;
```

</details>

---

### **Exercise 5: Delete a view**

Remove the `resumen_pedidos` view from the database.

<details><summary>Show solution</summary>

```sql
DROP VIEW resumen_pedidos;
```

</details>
