# **Exercises - Topic 6: Advanced Queries with SELECT and Conditions**

Below you will find 10 practical exercises to practice using `SELECT`, `WHERE`, `ORDER BY`, `LIMIT` and logical operators in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Check customer names and emails**

Get only the `first_name` and `email` fields from all records in the `customers` table.

<details><summary>Show Solution</summary>

```sql
SELECT first_name, email FROM customers;
```

</details>

---

### **Exercise 2: Filter clients by city**

Shows all the data of customers whose city is 'Valencia'.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM customers
WHERE city = 'Valencia';
```

</details>

---

### **Exercise 3: Search by partial match**

Look for customers whose last name begins with 'Lo'.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM customers
WHERE last_name LIKE 'Lo%';
```

</details>

---

### **Exercise 4: Filter by multiple values**

See orders where the `customer_id` is 1, 3 or 5.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM orders
WHERE customer_id IN (1, 3, 5);
```

</details>

---

### **Exercise 5: Filter by value range**

Shows orders whose `total_amount` is between 50 and 200 euros.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM orders
WHERE total_amount BETWEEN 50 AND 200;
```

</details>

---

### **Exercise 6: Using logical operators**

Get customers who are subscribed to the newsletter **and** registered after April 1, 2025.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM customers
WHERE newsletter_subscribed = TRUE
AND signup_date > '2025-04-01';
```

</details>

---

### **Exercise 7: Sort results**

Lists all orders sorted by `total_amount` from highest to lowest.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM orders
ORDER BY total_amount DESC;
```

</details>

---

### **Exercise 8: Sort with multiple criteria**

Shows customers sorted first by city (ascending) and then by last name (descending).

<details><summary>Show Solution</summary>

```sql
SELECT * FROM customers
ORDER BY city ASC, last_name DESC;
```

</details>

---

### **Exercise 9: Limit the number of results**

Get the first 4 records from the `customers` table.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM customers
LIMIT 4;
```

</details>

---

### **Exercise 10: Combine filters, order and limit**

Check the 2 oldest orders whose amount exceeds 100 euros.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM orders
WHERE total_amount > 100
ORDER BY created_at ASC
LIMIT 2;
```

</details>
