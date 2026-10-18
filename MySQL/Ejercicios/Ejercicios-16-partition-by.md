# **Exercises - Topic 16: Using PARTITION BY in MySQL**

Below you will find 5 practical exercises to work with **PARTITION BY** and window functions in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Count records by category**

In the `products(id, category_id, name, price)` table, show all the products along with the **total number of products** in the same category.

<details><summary>Show solution</summary>

```sql
SELECT id,
       category_id,
       name,
       COUNT(*) OVER (PARTITION BY category_id) AS total_categoria
FROM products;
```

</details>

---

### **Exercise 2: Calculate the average by department**

In the `employees(id, department_id, salary)` table, show each employee, their salary and the **average salary** of their department.

<details><summary>Show solution</summary>

```sql
SELECT id,
       department_id,
       salary,
       AVG(salary) OVER (PARTITION BY department_id) AS salario_promedio
FROM employees;
```

</details>

---

### **Exercise 3: Sales ranking by seller**

In the `sales(id, seller_id, amount)` table, assign a **ranking number** to each of every seller's sales, from highest to lowest `amount`.

<details><summary>Show solution</summary>

```sql
SELECT seller_id,
       id AS sale_id,
       amount,
       RANK() OVER (PARTITION BY seller_id ORDER BY amount DESC) AS ranking
FROM sales;
```

</details>

---

### **Exercise 4: Cumulative income per month**

In the `invoices(id, customer_id, total_amount, invoice_date)` table, calculate the **running total** of `total_amount` for each customer, sorted by `invoice_date`.

<details><summary>Show solution</summary>

```sql
SELECT customer_id,
       id AS invoice_id,
       invoice_date,
       total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY invoice_date) AS acumulado_cliente
FROM invoices;
```

</details>

---

### **Exercise 5: Difference from the seller's highest sale**

In the `sales(id, seller_id, amount)` table, show each sale along with its **difference** from the highest sale by the same seller.

<details><summary>Show solution</summary>

```sql
SELECT seller_id,
       id AS sale_id,
       amount,
       MAX(amount) OVER (PARTITION BY seller_id) - amount AS diferencia_maxima
FROM sales;
```

</details>
