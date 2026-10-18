# **Exercises - Topic 14: Booleans and Dates in MySQL**

Below, you will find 5 practical exercises to work with columns and **boolean** and **date** variables in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Update a boolean based on a date condition**

In the `subscriptions(user_id, expires_at DATE, is_active BOOLEAN)` table, mark records whose `expires_at` date is **earlier than today** as inactive (`is_active = FALSE`).

<details><summary>Show Solution</summary>

```sql
UPDATE subscriptions
SET is_active = FALSE
WHERE expires_at < CURDATE();
```

</details>

---

### **Exercise 2: Calculate days left for an event**

In the `events(id, name, event_date DATE)` table, it shows `name` and the **days left** for each event (negative values may appear if it has already passed).

<details><summary>Show Solution</summary>

```sql
SELECT name,
       DATEDIFF(event_date, CURDATE()) AS days_to_event
FROM events;
```

</details>

---

### **Exercise 3: Filter by date range and sort**

Get `orders(id, created_at DATETIME, total_amount)` registrations made **between May 1 and 15, 2025** (inclusive) and sort them from newest to oldest.

<details><summary>Show Solution</summary>

```sql
SELECT id, created_at, total_amount
FROM orders
WHERE created_at BETWEEN '2025-05-01 00:00:00' AND '2025-05-15 23:59:59'
ORDER BY created_at DESC;
```

</details>

---

### **Exercise 4: Format date and show boolean status**

`customers(id, first_name, signup_date DATE, is_active BOOLEAN)` shows the `first_name`, the `signup_date` with format `DD/MM/YYYY` and a calculated field `status` with value `'ACTIVE'` when `is_active = 1` and `'INACTIVE'` otherwise.

<details><summary>Show Solution</summary>

```sql
SELECT first_name,
       DATE_FORMAT(signup_date, '%d/%m/%Y') AS signup_date_formatted,
       CASE WHEN is_active = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END AS status
FROM customers;
```

</details>

---

### **Exercise 5: Procedure with boolean and date variables**

Create a procedure `deactivate_old_posts(days_back INT)` that deactivates (`is_published = 0`) in `posts(id, published_at DATETIME, is_published TINYINT(1))` entries **published more than** `days_back` days ago.

<details><summary>Show Solution</summary>

```sql
DELIMITER $$
CREATE PROCEDURE deactivate_old_posts(IN days_back INT)
BEGIN
  DECLARE v_cutoff DATETIME;
  SET v_cutoff = DATE_SUB(NOW(), INTERVAL days_back DAY);

  UPDATE posts
  SET is_published = 0
  WHERE published_at < v_cutoff;
END $$
DELIMITER ;

CALL deactivate_old_posts(30);
```

</details>
