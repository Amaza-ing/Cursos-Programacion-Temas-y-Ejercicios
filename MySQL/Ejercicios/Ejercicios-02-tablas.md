# **Exercises - Topic 2: Creating and Modifying Tables in MySQL**

Below you will find 5 practical exercises on creating and modifying tables, and using data types in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create a `customers` table**

Create a table called `customers` with the following fields:

- `customer_id`: integer, primary key, auto-increment.
- `first_name`: text of up to 50 characters.
- `last_name`: text of up to 50 characters.
- `signup_date`: date.
- `newsletter_subscribed`: Boolean.

<details><summary>Show solution</summary>

```sql
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  signup_date DATE,
  newsletter_subscribed BOOLEAN
);
```

</details>

---

### **Exercise 2: Create an `orders` table with a foreign key**

Create an `orders` table with the following fields:

- `order_id`: primary key.
- `customer_id`: foreign key that references `customers(customer_id)`.
- `total_amount`: decimal number with 2 decimal places.
- `created_at`: date and time.

<details><summary>Show solution</summary>

```sql
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10,2),
  created_at DATETIME,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

</details>

---

### **Exercise 3: Add a column to the `customers` table**

Add a column named `phone_number` of type `VARCHAR(20)` to the `customers` table.

<details><summary>Show solution</summary>

```sql
ALTER TABLE customers ADD COLUMN phone_number VARCHAR(20);
```

</details>

---

### **Exercise 4: Modify a data type**

Modify the `phone_number` field so that it can store up to 30 characters.

<details><summary>Show solution</summary>

```sql
ALTER TABLE customers MODIFY COLUMN phone_number VARCHAR(30);
```

</details>

---

### **Exercise 5: Create a table with an `ENUM` field**

Create a `feedback` table with the following fields:

- `id`: primary key.
- `customer_id`: foreign key to `customers`.
- `rating`: an enumerated value that can be `'excellent'`, `'good'`, `'average'` or `'poor'`.

<details><summary>Show solution</summary>

```sql
CREATE TABLE feedback (
  id INT PRIMARY KEY,
  customer_id INT,
  rating ENUM('excellent', 'good', 'average', 'poor'),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

</details>
