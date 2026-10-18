# **Exercises - Topic 7: Aggregate Functions and Grouping**

Below you will find 10 practical exercises to practice aggregate functions (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`), grouping with `GROUP BY` and filtering with `HAVING` in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Count the stored orders**

Query the total number of orders in the `orders` table.

<details><summary>Show solution</summary>

```sql
SELECT COUNT(*) AS total_pedidos FROM orders;
```

</details>

---

### **Exercise 2: Calculate total sales**

Calculate the sum of all the amounts (`total_amount`) in the `orders` table.

<details><summary>Show solution</summary>

```sql
SELECT SUM(total_amount) AS total_ventas FROM orders;
```

</details>

---

### **Exercise 3: Calculate the average order amount**

Show the average amount (`AVG`) of the orders.

<details><summary>Show solution</summary>

```sql
SELECT AVG(total_amount) AS promedio_pedidos FROM orders;
```

</details>

---

### **Exercise 4: Find the order with the largest amount**

Find out which was the most expensive order ever placed.

<details><summary>Show solution</summary>

```sql
SELECT MAX(total_amount) AS pedido_mas_caro FROM orders;
```

</details>

---

### **Exercise 5: Get the cheapest order**

Query the minimum value of the `total_amount` field.

<details><summary>Show solution</summary>

```sql
SELECT MIN(total_amount) AS pedido_mas_barato FROM orders;
```

</details>

---

### **Exercise 6: Group orders by customer**

Show how many orders each customer has placed.

<details><summary>Show solution</summary>

```sql
SELECT customer_id, COUNT(*) AS cantidad_pedidos
FROM orders
GROUP BY customer_id;
```

</details>

---

### **Exercise 7: Total spent per customer**

Find out how much each customer has spent by adding up the `total_amount` field.

<details><summary>Show solution</summary>

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id;
```

</details>

---

### **Exercise 8: Customers with more than 2 orders**

Filter only the customers who have more than two orders on record.

<details><summary>Show solution</summary>

```sql
SELECT customer_id, COUNT(*) AS total_pedidos
FROM orders
GROUP BY customer_id
HAVING total_pedidos > 2;
```

</details>

---

### **Exercise 9: Customers with an average spending above €100**

Get the average spending per customer and keep only those whose average spending is above €100.

<details><summary>Show solution</summary>

```sql
SELECT customer_id, AVG(total_amount) AS media_gasto
FROM orders
GROUP BY customer_id
HAVING media_gasto > 100;
```

</details>

---

### **Exercise 10: Group by customer and day**

Show how many orders each customer has placed per day.

<details><summary>Show solution</summary>

```sql
SELECT customer_id, DATE(created_at) AS fecha, COUNT(*) AS pedidos_dia
FROM orders
GROUP BY customer_id, fecha;
```

</details>
