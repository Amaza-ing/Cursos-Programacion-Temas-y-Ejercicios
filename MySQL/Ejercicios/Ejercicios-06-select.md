# **Exercises - Topic 6: Advanced Queries with SELECT and Conditions**

Below you will find 10 practical exercises to practice using `SELECT`, `WHERE`, `ORDER BY`, `LIMIT` and logical operators in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Query customer names and emails**

Get only the `first_name` and `email` fields of all the records in the `customers` table.

<details><summary>Show solution</summary>

```sql
SELECT first_name, email FROM customers;
```

</details>

---

### **Exercise 2: Filter customers by city**

Show all the data of the customers whose city is 'Valencia'.

<details><summary>Show solution</summary>

```sql
SELECT * FROM customers
WHERE city = 'Valencia';
```

</details>

---

### **Exercise 3: Search by partial match**

Find the customers whose last name starts with 'Lo'.

<details><summary>Show solution</summary>

```sql
SELECT * FROM customers
WHERE last_name LIKE 'Lo%';
```

</details>

---

### **Exercise 4: Filter by multiple values**

Query the orders whose `customer_id` is 1, 3 or 5.

<details><summary>Show solution</summary>

```sql
SELECT * FROM orders
WHERE customer_id IN (1, 3, 5);
```

</details>

---

### **Exercise 5: Filter by value range**

Show the orders whose `total_amount` is between 50 and 200 euros.

<details><summary>Show solution</summary>

```sql
SELECT * FROM orders
WHERE total_amount BETWEEN 50 AND 200;
```

</details>

---

### **Exercise 6: Use logical operators**

Get the customers who are subscribed to the newsletter **and** signed up after April 1, 2025.

<details><summary>Show solution</summary>

```sql
SELECT * FROM customers
WHERE newsletter_subscribed = TRUE
AND signup_date > '2025-04-01';
```

</details>

---

### **Exercise 7: Sort results**

List all the orders sorted by `total_amount` from highest to lowest.

<details><summary>Show solution</summary>

```sql
SELECT * FROM orders
ORDER BY total_amount DESC;
```

</details>

---

### **Exercise 8: Sort with multiple criteria**

Show the customers sorted first by city (ascending) and then by last name (descending).

<details><summary>Show solution</summary>

```sql
SELECT * FROM customers
ORDER BY city ASC, last_name DESC;
```

</details>

---

### **Exercise 9: Limit the number of results**

Get the first 4 records from the `customers` table.

<details><summary>Show solution</summary>

```sql
SELECT * FROM customers
LIMIT 4;
```

</details>

---

### **Exercise 10: Combine filters, sorting and limits**

Query the 2 oldest orders whose amount is over 100 euros.

<details><summary>Show solution</summary>

```sql
SELECT * FROM orders
WHERE total_amount > 100
ORDER BY created_at ASC
LIMIT 2;
```

</details>
