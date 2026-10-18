# **Exercises - Topic 5: Insert, Update and Delete Data in MySQL**

Below you will find 7 practical exercises to practice inserting, updating and deleting data with SQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Insert a new customer**

Add a customer with the following data to the `customers` table:

- First name: Marcos
- Last name: Díaz
- Sign-up date: 2025-04-15
- Newsletter subscription: TRUE

<details><summary>Show solution</summary>

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES ('Marcos', 'Díaz', '2025-04-15', TRUE);
```

</details>

---

### **Exercise 2: Insert multiple customers**

Add the following two customers:

1. Julia Romero, 2025-04-16, FALSE
2. Sergio López, 2025-04-17, TRUE

<details><summary>Show solution</summary>

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES
('Julia', 'Romero', '2025-04-16', FALSE),
('Sergio', 'López', '2025-04-17', TRUE);
```

</details>

---

### **Exercise 3: Insert a linked order**

Create an order in the `orders` table for `customer_id = 1` with:

- `order_id`: 101
- `total_amount`: 89.99
- `created_at`: 2025-04-15 09:45:00

<details><summary>Show solution</summary>

```sql
INSERT INTO orders (order_id, customer_id, total_amount, created_at)
VALUES (101, 1, 89.99, '2025-04-15 09:45:00');
```

</details>

---

### **Exercise 4: Update an existing record**

Change the newsletter subscription status of the customer with `customer_id = 3` to `TRUE`.

<details><summary>Show solution</summary>

```sql
UPDATE customers
SET newsletter_subscribed = TRUE
WHERE customer_id = 3;
```

</details>

---

### **Exercise 5: Update multiple fields**

Update the first and last name of the customer with `customer_id = 2` to:

- `first_name`: Carla
- `last_name`: Navarro

<details><summary>Show solution</summary>

```sql
UPDATE customers
SET first_name = 'Carla', last_name = 'Navarro'
WHERE customer_id = 2;
```

</details>

---

### **Exercise 6: Delete an order**

Delete the order with `order_id = 101`.

<details><summary>Show solution</summary>

```sql
DELETE FROM orders
WHERE order_id = 101;
```

</details>

---

### **Exercise 7: Delete all test records**

Delete all the records in the `feedback` table, if it exists.

<details><summary>Show solution</summary>

```sql
DELETE FROM feedback;
```

</details>
