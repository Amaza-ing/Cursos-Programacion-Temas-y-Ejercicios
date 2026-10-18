# **Exercises - Topic 8: Queries with JOIN in MySQL**

Below you will find 6 practical exercises to apply different types of `JOIN` and consult related data between several tables.

All exercises use the following tables:

- `customers(id, first_name, last_name)`
-`orders(id, customer_id, created_at)`
- `order_details(order_id, product_id, quantity)`
- `products(id, name, price)`

---

### **Exercise 1: Show customers' full name along with their order IDs**

Displays the `first_name`, `last_name`, and `id` of the order for each customer who placed an order.

<details><summary>Show Solution</summary>

```sql
SELECT c.first_name, c.last_name, o.id AS order_id
FROM customers c
JOIN orders o ON c.id = o.customer_id;
```

</details>

---

### **Exercise 2: Get all orders (even if they do not have details)**

Shows the order ID and the total quantity of products purchased. Also includes orders without details.

<details><summary>Show Solution</summary>

```sql
SELECT o.id AS order_id, SUM(od.quantity) AS total_items
FROM orders o
LEFT JOIN order_details od ON o.id = od.order_id
GROUP BY o.id;
```

</details>

---

### **Exercise 3: View products that appear in an order**

Lists the name of all products that have been included in at least one order.

<details><summary>Show Solution</summary>

```sql
SELECT DISTINCT p.name
FROM products p
JOIN order_details od ON p.id = od.product_id;
```

</details>

---

### **Exercise 4: Show order history for a specific customer**

Displays customer orders with `id = 2`, indicating the date of the order and the name of each product included.

<details><summary>Show Solution</summary>

```sql
SELECT o.created_at, p.name AS product_name
FROM orders o
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id
WHERE o.customer_id = 2;
```

</details>

---

### **Exercise 5: View all products, even those that have never been sold**

Shows all products along with the total quantity sold. If a product has not been sold, it must appear with a null or 0 quantity.

<details><summary>Show Solution</summary>

```sql
SELECT p.name, SUM(od.quantity) AS total_vendida
FROM products p
LEFT JOIN order_details od ON p.id = od.product_id
GROUP BY p.id;
```

</details>

---

### **Exercise 6: Obtain the total spending per customer**

Shows the name of each customer and the total amount spent, multiplying quantity by price of each product.

<details><summary>Show Solution</summary>

```sql
SELECT c.first_name, c.last_name, SUM(od.quantity * p.price) AS total_gastado
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id
GROUP BY c.id;
```

</details>
