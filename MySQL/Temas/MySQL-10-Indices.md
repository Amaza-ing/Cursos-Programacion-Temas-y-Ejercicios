# **Topic 10: Indexes in MySQL**

In this topic we will learn how to:

- Understand what an index is and what it is used for.
- Create indexes to optimize queries.
- Recognize the different types of indexes in MySQL.
- Manage and delete indexes.

---

## **1. What is an index?**

An **index** is a special data structure that MySQL uses to quickly locate rows in a table without having to scan the entire table.

### **Advantages:**

- It speeds up `SELECT` queries.
- It improves search and sort performance.

### **Disadvantages:**

- It takes up additional disk space.
- It may slow down `INSERT`, `UPDATE` and `DELETE` operations because the index has to be updated.

---

## **2. Types of indexes in MySQL**

### **Normal index (INDEX)**

It is used to speed up searches on specific columns.

```sql
CREATE INDEX idx_nombre ON customers(first_name);
```

### **Unique index (UNIQUE)**

It ensures that all the values in a column are unique.

```sql
CREATE UNIQUE INDEX idx_email ON customers(email);
```

### **Primary key index (PRIMARY KEY)**

It is created automatically when we define a `PRIMARY KEY`.

### **Full-text index (FULLTEXT)**

Designed for text searches in large columns (`TEXT`, `VARCHAR`).

```sql
CREATE FULLTEXT INDEX idx_texto ON articles(content);
```

### **Composite index**

It covers multiple columns to optimize searches that involve several conditions.

```sql
CREATE INDEX idx_nombre_apellido ON customers(first_name, last_name);
```

---

## **3. Creating indexes when you create the table**

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

## **4. Viewing existing indexes**

To see the indexes of a table:

```sql
SHOW INDEX FROM customers;
```

---

## **5. Deleting indexes**

We can delete an index with:

```sql
DROP INDEX idx_nombre ON customers;
```

> Indexes created automatically by a primary key cannot be deleted without first deleting the primary key.

---

## **6. Good practices with indexes**

- Index columns that are frequently used in `WHERE`, `JOIN` or `ORDER BY`.
- Avoid creating too many unnecessary indexes.
- Review performance periodically with `EXPLAIN`.

---

[![Indexes](https://img.youtube.com/vi/Eu2o5tefWdU/0.jpg)](https://www.youtube.com/watch?v=Eu2o5tefWdU&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Conclusion**

- Indexes make reading data faster.
- There are several types: normal, unique, composite and full-text.
- They should be used strategically to balance performance and resource usage.

---

In the next topic we will learn how to **create and use stored procedures to reuse code**
