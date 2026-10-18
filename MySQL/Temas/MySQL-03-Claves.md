# **Topic 3: Primary and Foreign Keys in MySQL**

In this topic we will learn how to:

- Define primary keys (`PRIMARY KEY`).
- Create foreign keys (`FOREIGN KEY`) to relate tables.
- Apply referential integrity constraints.

---

## **1. What is a primary key?**

A **primary key** is a column (or combination of columns) that uniquely identifies each row in a table.

### **Characteristics:**

- It cannot contain duplicate values.
- It cannot be null.

### **Example:**

```sql
CREATE TABLE customers (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);
```

It can also be defined at the end:

```sql
CREATE TABLE customers (
  id INT,
  name VARCHAR(50),
  PRIMARY KEY (id)
);
```

---

## **2. What is a foreign key?**

A **foreign key** is a column that points to a primary key in another table. It is used to establish a relationship between tables.

### **Example:**

```sql
CREATE TABLE orders (
  id INT PRIMARY KEY,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);
```

This indicates that `customer_id` in `orders` must match an existing `id` in `customers`.

---

## **3. Creating multiple keys**

A table can have one primary key and multiple foreign keys.

```sql
CREATE TABLE order_details (
  order_id INT,
  product_id INT,
  quantity INT,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
```

> In this case, the primary key is composite: each combination of `order_id` and `product_id` must be unique.

---

[![Primary and foreign keys](https://img.youtube.com/vi/2FF8n4hXcSs/0.jpg)](https://www.youtube.com/watch?v=2FF8n4hXcSs&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **4. Additional constraints**

You can define what happens when a referenced value is deleted or updated.

### **ON DELETE and ON UPDATE**

```sql
FOREIGN KEY (customer_id) REFERENCES customers(id)
ON DELETE CASCADE
ON UPDATE CASCADE
```

### **Common options:**

- `CASCADE`: applies the change to the related rows.
- `SET NULL`: sets the value to `NULL` if the referenced record is deleted.
- `RESTRICT`: prevents deleting/updating if there are related rows.

---

## **5. Viewing the keys and relationships of an existing table**

Look at the structure of a table to see the keys defined on it:

```sql
SHOW CREATE TABLE orders;
```

---

## **6. Advantages of using keys correctly**

- They guarantee data integrity.
- They prevent orphaned or inconsistent records.
- They let you work with `JOIN` safely.

---

## **7. Conclusion**

- Primary keys uniquely identify records.
- Foreign keys let you relate tables.
- The `ON DELETE` and `ON UPDATE` constraints control how relationships behave.

---

In the next topic we will learn how to **normalize tables before working with them**.
