# **Exercises - Topic 5: Insert, Update and Delete Data in MySQL**

Below you will find 7 practical exercises to practice inserting, updating and deleting data with SQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Insert a new customer**

Add a customer with the following data to the `customers` table:

- Name: Marcos
- Last name: Díaz
- Registration date: 2025-04-15
- Newsletter subscription: TRUE

<details><summary>Show Solution</summary>

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES ('Marcos', 'Díaz', '2025-04-15', TRUE);
```

</details>

---

### **Exercise 2: Insert multiple clients**

Add the following two clients:

1. Julia Romero, 2025-04-16, FALSE
2. Sergio López, 2025-04-17, TRUE

<details><summary>Show Solution</summary>

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES
('Julia', 'Romero', '2025-04-16', FALSE),
('Sergio', 'López', '2025-04-17', TRUE);
```

</details>

---

### **Exercise 3: Insert a linked order**

Create an order in the `orders` table for the `customer_id = 1` with:

- `order_id`: 101
- `total_amount`: 89.99
- `created_at`: 2025-04-15 09:45:00

<details><summary>Show Solution</summary>

```sql
INSERT INTO orders (order_id, customer_id, total_amount, created_at)
VALUES (101, 1, 89.99, '2025-04-15 09:45:00');
```

</details>

---

### **Exercise 4: Update an existing record**

Change the client's newsletter subscription status with `customer_id = 3` to `TRUE`.

<details><summary>Show Solution</summary>

```sql
UPDATE customers
SET newsletter_subscribed = TRUE
WHERE customer_id = 3;
```

</details>

---

### **Exercise 5: Update multiple fields**

Update the customer's first and last name with `customer_id = 2` to:

- `first_name`: Carla
- `last_name`: Navarro

<details><summary>Show Solution</summary>

```sql
UPDATE customers
SET first_name = 'Carla', last_name = 'Navarro'
WHERE customer_id = 2;
```

</details>

---

### **Exercise 6: Delete an order**

Delete the order with `order_id = 101`.

<details><summary>Show Solution</summary>

```sql
DELETE FROM orders
WHERE order_id = 101;
```

</details>

---

### **Exercise 7: Delete all test records**

Delete all records from table `feedback` if it exists.

<details><summary>Show Solution</summary>

```sql
DELETE FROM feedback;
```

</details>
