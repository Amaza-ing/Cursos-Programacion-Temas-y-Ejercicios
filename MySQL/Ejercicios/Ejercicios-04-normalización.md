# **Exercises - Topic 4: Normalization of Tables in MySQL**

Below you will find 4 practical exercises on database normalization. Try to solve them before consulting the solution.

---

### **Exercise 1: Detect 1NF violations**

Analyze the following table and explain why it is not in First Normal Form (1NF). Then, propose a standardized version.

| id | name | emails |
| --- | ------ | ----------------------- |
| 1 | Elena | elena@mail.com; e@x.com |

<details><summary>Show Solution</summary>

The `correos` column contains multiple values in a single cell, which violates 1NF.

**Solution (normalized):**

| id | name | mail |
| --- | ------ | -------------- |
| 1 | Elena | elena@mail.com |
| 1 | Elena | e@x.com |

</details>

---

### **Exercise 2: Separate data according to 2NF**

Observe the following table:

| teacher_id | course_id | teacher_name |
| ----------- | -------- | --------------- |
| 1 | 101 | Juan Ortega |
| 1 | 102 | Juan Ortega |

Does it violate Second Normal Form? If so, normalize the structure.

<details><summary>Show Solution</summary>

Yes. `profesor_nombre` depends only on `profesor_id`, not on the `(profesor_id, curso_id)` set.

**Solution:**

**`teachers` table:**
| teacher_id | teacher_name |
|-------------|------------------|
| 1 | Juan Ortega |

**`teaching` table:**
| teacher_id | course_id |
|-------------|-----------|
| 1 | 101 |
| 1 | 102 |

</details>

---

### **Exercise 3: Eliminate transitive dependency (3NF)**

Analyze this table:

| client_id | customer_name | city ​​| country |
| ---------- | -------------- | --------- | ------ |
| 1 | Ana Rivas | Madrid | Spain |
| 2 | Laura Vazquez | Barcelona | Spain |

What 3NF problem can you identify? Propose normalization.

<details><summary>Show Solution</summary>

`país` depends on `ciudad`, not directly on `cliente_id`. This is a transitive dependency.

**Solution:**

**`cities` table:**
| city_id | city ​​| country |
|-----------|------------|---------|
| 1 | Madrid | Spain |
| 2 | Barcelona | Spain |

**`customers` table:**
| client_id | customer_name | city_id |
|------------|----------------|-----------|
| 1 | Ana Rivas | 1 |
| 2 | Laura Vazquez | 2 |

</details>

---

### **Exercise 4: Normalize an order table**

Given the following table:

| order_id | client | product | quantity | unit_price |
| --------- | ----------- | ---------- | -------- | --------------- |
| 1 | Pedro Núñez | Pen | 3 | 0.75 |
| 2 | Pedro Núñez | A4 folder | 2 | 1.50 |

Design a normalized model in at least three tables.

<details><summary>Show Solution</summary>

**`customers` table:**
| id | name |
|----|--------------|
| 1 | Pedro Núñez |

**`products` table:**
| id | name | unit_price |
|----|--------------|------------------|
| 1 | Pen | 0.75 |
| 2 | A4 folder | 1.50 |

**`orders` table:**
| id | customer_id |
|----|-------------|
| 1 | 1 |
| 2 | 1 |

**`order_details` table:**
| order_id | product_id | quantity |
|----------|------------|----------|
| 1 | 1 | 3 |
| 2 | 2 | 2 |

</details>
