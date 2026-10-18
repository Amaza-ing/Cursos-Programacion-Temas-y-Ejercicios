# **Exercises - Topic 7: Aggregation Functions and Groupings**

Below you will find 10 practical exercises to practice aggregation functions (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`), grouping with `GROUP BY` and filters with `HAVING` in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Calculate the total registered orders**

Check the total number of orders in the `orders` table.

<details><summary>Show Solution</summary>

```sql
SELECT COUNT(*) AS total_pedidos FROM orders;
```

</details>

---

### **Exercise 2: Calculate the total amount of sales**

Calculates the sum of all amounts (`total_amount`) in the `orders` table.

<details><summary>Show Solution</summary>

```sql
SELECT SUM(total_amount) AS total_ventas FROM orders;
```

</details>

---

### **Exercise 3: Calculate the average order amount**

Shows the average amount (`AVG`) of the orders.

<details><summary>Show Solution</summary>

```sql
SELECT AVG(total_amount) AS promedio_pedidos FROM orders;
```

</details>

---

### **Exercise 4: Find the order with the largest amount**

See which was the most expensive order recorded.

<details><summary>Show Solution</summary>

```sql
SELECT MAX(total_amount) AS pedido_mas_caro FROM orders;
```

</details>

---

### **Exercise 5: Obtain the cheapest order**

Queries the minimum value of the `total_amount` field.

<details><summary>Show Solution</summary>

```sql
SELECT MIN(total_amount) AS pedido_mas_barato FROM orders;
```

</details>

---

### **Exercise 6: Group orders by customer**

Shows how many orders each customer has placed.

<details><summary>Show Solution</summary>

```sql
SELECT customer_id, COUNT(*) AS cantidad_pedidos
FROM orders
GROUP BY customer_id;
```

</details>

---

### **Exercise 7: Total spent per customer**

See how much each customer has spent by adding the `total_amount` field.

<details><summary>Show Solution</summary>

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id;
```

</details>

---

### **Exercise 8: Customers with more than 2 orders**

Filter only customers who have more than two registered orders.

<details><summary>Show Solution</summary>

```sql
SELECT customer_id, COUNT(*) AS total_pedidos
FROM orders
GROUP BY customer_id
HAVING total_pedidos > 2;
```

</details>

---

### **Exercise 9: Average spending per customer with more than €100 spent**

Obtain the average spending per customer and filter those who have spent more than €100.

<details><summary>Show Solution</summary>

```sql
SELECT customer_id, AVG(total_amount) AS media_gasto
FROM orders
GROUP BY customer_id
HAVING media_gasto > 100;
```

</details>

---

### **Exercise 10: Group by client and day**

Shows how many orders each customer has placed per day.

<details><summary>Show Solution</summary>

```sql
SELECT customer_id, DATE(created_at) AS fecha, COUNT(*) AS pedidos_dia
FROM orders
GROUP BY customer_id, fecha;
```

</details>
