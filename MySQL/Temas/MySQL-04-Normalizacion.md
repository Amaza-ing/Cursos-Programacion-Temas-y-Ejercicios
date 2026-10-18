# **Topic 4: Table Normalization in MySQL**

In this topic we will learn:

- What is database normalization.
- What are the most important normal forms.
- How to apply normalization to our tables to avoid redundancies and improve data integrity.

---

## **1. What is normalization?**

**Normalization** is a process that is applied to database design to:

- Reduce **data redundancy**.
- Avoid **anomalies** in insert, update and delete operations.
- Improve **data integrity**.

Normalizing a database means **splitting the data into several related tables** correctly.

---

## **2. Normal Forms**

Normal forms are rules or levels that help us decide if a database is well structured. Below we will see the three most used:

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

- Must comply with 1NF.
- All non-key attributes must depend on **the entire** primary key (not just part of it).

**Incorrect example:**

| course_id | student_id | student_name |
| -------- | ------------- | ----------------- |
| 1 | 10 | Ana Fernandez |

`estudiante_nombre` depends only on `estudiante_id`, not on the `(curso_id, estudiante_id)` set.

**Solution:**
Separate into two tables:

**`enrollments` table:**
| course_id | student_id |
|----------|----------------|
| 1 | 10 |

**`students` table:**
| student_id | student_name |
|----------------|-------------------|
| 10 | Ana Fernandez |

---

### **3rd Normal Form (3NF)**

- Must comply with 2NF.
- There should be no **transitive dependencies**, that is, non-key attributes should not depend on each other.

**Incorrect example:**

| id | customer_name | city ​​| postal_code |
| --- | -------------- | ------- | ------------- |
| 1 | Raúl Pérez | Seville | 41001 |

`código_postal` depends on `ciudad`, not directly on `id`.

**Solution:** Separate into two tables:

**`customers` table:**
| id | customer_name | city_id |
|----|----------------|-----------|
| 1 | Raúl Pérez | 3 |

**`cities` table:**
| city_id | city ​​| postal_code |
|-----------|---------|----------------|
| 3 | Seville | 41001 |

---

## **3. Step-by-step Normalization Example**

Suppose we have this initial table:

| order_id | client_name | product | quantity | total_price |
| --------- | -------------- | -------- | -------- | ------------ |
| 1 | Ana Gomez | Pencil | 2 | 1.00 |
| 2 | Ana Gomez | Notebook | 1 | 2.00 |

This table mixes customer, order and product information.
### **Step 1: separate products**

**`products` table:**
| id | name | unit_price |
|----|-----------|-----------------|
| 1 | Pencil | 0.50 |
| 2 | Notebook | 2.00 |

### **Step 2: Separate clients**

**`customers` table:**
| id | name |
|----|-------------|
| 1 | Ana Gomez |

### **Step 3: Record orders and details**

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

[![Table Normalization](https://img.youtube.com/vi/w0olqd2CxJI/0.jpg)](https://www.youtube.com/watch?v=w0olqd2CxJI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **4. Advantages of standardization**

- Avoid unnecessary repetition of data.
- Reduces the size of the database.
- Facilitates modification and updating.
- Improves data consistency.

---

## **5. When not to overnormalize**

Although normalization is useful, **a database that is too fragmented can affect performance**.

On systems with many read queries, **controlled denormalization** is sometimes chosen to reduce the number of `JOIN` required.

There are even a fourth and fifth normal forms, but they are not usually necessary except in very specific cases.

---

## **6. Conclusion**

- Normalization organizes information into several well-structured tables.
- The first three normal forms (1NF, 2NF and 3NF) cover most practical cases.
- Good database design starts with good normalization.

---

In the next topic we will learn how to **insert, update and delete data** using SQL statements like `INSERT`, `UPDATE` and `DELETE`.
