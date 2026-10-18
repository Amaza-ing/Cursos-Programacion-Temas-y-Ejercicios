# **Topic 4: Table Normalization in MySQL**

In this topic we will learn:

- What database normalization is.
- Which normal forms are the most important.
- How to apply normalization to our tables to avoid redundancy and improve data integrity.

---

## **1. What is normalization?**

**Normalization** is a process applied to database design to:

- Reduce **data redundancy**.
- Avoid **anomalies** in insert, update and delete operations.
- Improve **data integrity**.

Normalizing a database means **splitting the data into several related tables** correctly.

---

## **2. Normal forms**

Normal forms are rules or levels that help us decide whether a database is well structured. Below we will look at the three most commonly used ones:

### **1st Normal Form (1NF)**

- Each cell must contain a single value (not lists or arrays).
- Each row must be unique.
- Columns must have the same data type in all rows.

**Incorrect example (not in 1NF):**

| id | name | phones |
| --- | ------ | ----------------- |
| 1 | Laura | 123456, 789101112 |

**Solution (in 1NF):**

| id | name | phone |
| --- | ------ | --------- |
| 1 | Laura | 123456 |
| 1 | Laura | 789101112 |

---

### **2nd Normal Form (2NF)**

- It must satisfy 1NF.
- All non-key attributes must depend on **the entire** primary key (not just part of it).

**Incorrect example:**

| curso_id | estudiante_id | estudiante_nombre |
| -------- | ------------- | ----------------- |
| 1 | 10 | Ana Fernández |

`estudiante_nombre` depends only on `estudiante_id`, not on the whole `(curso_id, estudiante_id)` pair.

**Solution:**
Split it into two tables:

**`enrollments` table:**
| curso_id | estudiante_id |
|----------|----------------|
| 1 | 10 |

**`students` table:**
| estudiante_id | estudiante_nombre |
|----------------|-------------------|
| 10 | Ana Fernández |

---

### **3rd Normal Form (3NF)**

- It must satisfy 2NF.
- There must be no **transitive dependencies**; that is, non-key attributes must not depend on each other.

**Incorrect example:**

| id | nombre_cliente | ciudad | código_postal |
| --- | -------------- | ------- | ------------- |
| 1 | Raúl Pérez | Seville | 41001 |

`código_postal` depends on `ciudad`, not directly on `id`.

**Solution:** Split it into two tables:

**`customers` table:**
| id | nombre_cliente | ciudad_id |
|----|----------------|-----------|
| 1 | Raúl Pérez | 3 |

**`cities` table:**
| ciudad_id | ciudad | código_postal |
|-----------|---------|----------------|
| 3 | Seville | 41001 |

---

## **3. Step-by-step normalization example**

Suppose we have this initial table:

| order_id | customer_name | product | quantity | total_price |
| --------- | -------------- | -------- | -------- | ------------ |
| 1 | Ana Gómez | Pencil | 2 | 1.00 |
| 2 | Ana Gómez | Notebook | 1 | 2.00 |

This table mixes customer, order and product information.

### **Step 1: separate products**

**`products` table:**
| id | name | unit_price |
|----|-----------|-----------------|
| 1 | Pencil | 0.50 |
| 2 | Notebook | 2.00 |

### **Step 2: separate customers**

**`customers` table:**
| id | name |
|----|-------------|
| 1 | Ana Gómez |

### **Step 3: record orders and their details**

**`orders` table:**
| id | customer_id |
|----|-------------|
| 1 | 1 |
| 2 | 1 |

**`order_details` table:**
| order_id | product_id | quantity |
|----------|------------|----------|
| 1 | 1 | 2 |
| 2 | 2 | 1 |

---

[![Table normalization](https://img.youtube.com/vi/w0olqd2CxJI/0.jpg)](https://www.youtube.com/watch?v=w0olqd2CxJI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **4. Advantages of normalization**

- It avoids unnecessary repetition of data.
- It reduces the size of the database.
- It makes changes and updates easier.
- It improves data consistency.

---

## **5. When not to over-normalize**

Although normalization is useful, **a database that is too fragmented can hurt performance**.

In systems with many read queries, **controlled denormalization** is sometimes chosen to reduce the number of `JOIN` operations needed.

There are even fourth and fifth normal forms, but they are rarely needed except in very specific cases.

---

## **6. Conclusion**

- Normalization organizes information into several well-structured tables.
- The first three normal forms (1NF, 2NF and 3NF) cover most practical cases.
- Good database design starts with good normalization.

---

In the next topic we will learn how to **insert, update and delete data** using SQL statements like `INSERT`, `UPDATE` and `DELETE`.
