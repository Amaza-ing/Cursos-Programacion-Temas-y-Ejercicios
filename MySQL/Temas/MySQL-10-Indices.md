# **Topic 10: Indexes in MySQL**

In this topic we will learn to:

- Understand what an index is and what it is for.
- Create indexes to optimize queries.
- Know the different types of indexes in MySQL.
- Manage and delete indexes.

---

## **1. What is an index?**

An **index** is a special data structure that MySQL uses to quickly locate rows in a table without having to scan the entire table.

### **Advantages:**

- Speed up `SELECT` queries.
- Improves search and sort performance.

### **Disadvantages:**

- Takes up additional disk space.
- May slow down `INSERT`, `UPDATE` and `DELETE` operations due to index update.

---

## **2. Types of indexes in MySQL**

### **Normal index (INDEX)**

Used to speed up searches on specific columns.

```sql
CREATE INDEX idx_nombre ON customers(first_name);
```

### **Unique index (UNIQUE)**

Ensures that all values in a column are unique.

```sql
CREATE UNIQUE INDEX idx_email ON customers(email);
```

### **Primary Key Index**

It is created automatically when we define an `PRIMARY KEY`.

### **Full text index (FULLTEXT)**

Special for text searches in large columns (`TEXT`, `VARCHAR`).

```sql
CREATE FULLTEXT INDEX idx_texto ON articles(content);
```

### **Composite index**

Cover multiple columns to optimize searches involving multiple conditions.

```sql
CREATE INDEX idx_nombre_apellido ON customers(first_name, last_name);
```

---

## **3. Create indexes when creating the table**

We can define indexes directly when creating a table:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  INDEX idx_price (price)
);
```

---

## **4. View existing indexes**

To view the indexes of a table:

```sql
SHOW INDEX FROM customers;
```

---

## **5. Delete indexes**

We can delete an index with:

```sql
DROP INDEX idx_nombre ON customers;
```

> Indexes created automatically by a primary key cannot be deleted without first deleting the primary key.

---

## **6. Good practices with indexes**

- Index frequently used columns in `WHERE`, `JOIN` or `ORDER BY`.
- Avoid creating too many unnecessary indexes.
- Periodically review performance with `EXPLAIN`.

---

[![Indices](https://img.youtube.com/vi/Eu2o5tefWdU/0.jpg)](https://www.youtube.com/watch?v=Eu2o5tefWdU&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Conclusion**

- Indexes improve data reading speed.
- There are several types: normal, unique, compound and full text.
- They should be used strategically to balance performance and resource consumption.

---

In the next topic we will learn to **create and use stored procedures to reuse code**
