# **Exercises - Topic 8: Queries with JOIN in MySQL**

Below you will find 6 practical exercises to apply different types of `JOIN` and query related data across several tables.

All the exercises use the following tables:

- `customers(id, first_name, last_name)`
- `orders(id, customer_id, created_at)`
- `order_details(order_id, product_id, quantity)`
- `products(id, name, price)`

---

### **Exercise 1: Show customers' full names along with their order IDs**

Display the `first_name`, `last_name` and the order `id` for each customer who has placed an order.

<details><summary>Show solution</summary>

```sql
SELECT c.first_name, c.last_name, o.id AS order_id
FROM customers c
JOIN orders o ON c.id = o.customer_id;
```

</details>

---

### **Exercise 2: Get all orders (even if they do not have details)**

Show the order ID and the total quantity of products purchased. Include the orders without details too.

<details><summary>Show solution</summary>

```sql
SELECT o.id AS order_id, SUM(od.quantity) AS total_items
FROM orders o
LEFT JOIN order_details od ON o.id = od.order_id
GROUP BY o.id;
```

</details>

---

### **Exercise 3: View the products that appear in an order**

List the names of all the products that have been included in at least one order.

<details><summary>Show solution</summary>

```sql
SELECT DISTINCT p.name
FROM products p
JOIN order_details od ON p.id = od.product_id;
```

</details>

---

### **Exercise 4: Show the order history of a specific customer**

Display the orders of the customer with `id = 2`, showing the order date and the name of each product included.

<details><summary>Show solution</summary>

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

Show all the products along with the total quantity sold. If a product has not been sold, it must appear with a null or 0 quantity.

<details><summary>Show solution</summary>

```sql
SELECT p.name, SUM(od.quantity) AS total_vendida
FROM products p
LEFT JOIN order_details od ON p.id = od.product_id
GROUP BY p.id;
```

</details>

---

### **Exercise 6: Get the total spending per customer**

Show the name of each customer and the total amount spent, multiplying the quantity by the price of each product.

<details><summary>Show solution</summary>

```sql
SELECT c.first_name, c.last_name, SUM(od.quantity * p.price) AS total_gastado
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id
GROUP BY c.id;
```

</details>
