# **Topic 5: Insert, Update and Delete Data in MySQL**

In this topic we will learn to:

- Insert records into a table with `INSERT`.
- Modify existing records with `UPDATE`.
- Delete records with `DELETE`.
- Use conditions to modify or delete specific records.

---

## **1. Insert data with `INSERT`**

The `INSERT` statement is used to add new rows to a table.

### **Basic syntax**

```sql
INSERT INTO nombre_tabla (columna1, columna2, ...)
VALUES (valor1, valor2, ...);
```

### **Example**

Insert a new client into the `customers` table:

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES ('Laura', 'Gómez', '2025-04-01', TRUE);
```

It is also possible to insert multiple records at once:

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES
('Luis', 'Martínez', '2025-04-10', FALSE),
('Ana', 'Pérez', '2025-04-12', TRUE);
```

To perform a query and observe all the data in a table, for example from `customers`, you can do:

```sql
SELECT * FROM customers;
```

---

[![How to Insert Data into a Table](https://img.youtube.com/vi/qJQqFKdLYyg/0.jpg)](https://www.youtube.com/watch?v=qJQqFKdLYyg&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **2. Update data with `UPDATE`**

The `UPDATE` statement is used to modify one or more existing records.

### **Basic syntax**

```sql
UPDATE nombre_tabla
SET columna1 = nuevo_valor1, columna2 = nuevo_valor2, ...
WHERE condición;
```

> ⚠️ You must always use `WHERE` to avoid updating all records by mistake.

### **Example**

Update the newsletter subscription status of a specific customer:

```sql
UPDATE customers
SET newsletter_subscribed = FALSE
WHERE customer_id = 3;
```

Update multiple fields at once:

```sql
UPDATE customers
SET first_name = 'Carlos', last_name = 'Ramírez'
WHERE customer_id = 4;
```

---

## **3. Delete data with `DELETE`**

The `DELETE` statement allows you to delete records from a table.

### **Basic syntax**

```sql
DELETE FROM nombre_tabla
WHERE condición;
```

> ⚠️ If you do not include `WHERE`, **all records** will be deleted.

### **Example**

Delete a customer by ID:

```sql
DELETE FROM customers
WHERE customer_id = 2;
```

Delete all records from a table (carefully):

```sql
DELETE FROM customers;
```

---

## **4. Insert data with foreign keys**

When inserting data into tables that contain foreign keys, ensure that the referenced value exists in the parent table.

Example: insert a new order into the `orders` table:

```sql
INSERT INTO orders (order_id, customer_id, total_amount, created_at)
VALUES (1, 1, 150.00, '2025-04-14 12:30:00');
```

> The `customer_id = 1` value must exist in the `customers` table.

---

[![Table modification](https://img.youtube.com/vi/mYsI8AwooG4/0.jpg)](https://www.youtube.com/watch?v=mYsI8AwooG4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **5. Important Considerations**

- Modify and delete operations can affect a lot of data if specific conditions are not used.
- Make sure to make backup copies before executing destructive statements.
- Use `SELECT` with the same condition that you plan to use in `UPDATE` or `DELETE` to review the data before:

```sql
SELECT * FROM customers WHERE customer_id = 5;
```

---

## **6. Conclusion**

- `INSERT` is used to add new records.
- `UPDATE` modifies existing fields in specific records.
- `DELETE` deletes records based on a condition.
- Operations without conditions (`WHERE`) affect all records.

---

In the next topic we will learn to perform **advanced queries with SELECT and conditions using WHERE, ORDER BY, LIMIT and logical operators.**
