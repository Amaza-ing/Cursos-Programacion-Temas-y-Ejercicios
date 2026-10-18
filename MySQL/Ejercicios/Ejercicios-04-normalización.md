# **Exercises - Topic 4: Table Normalization in MySQL**

Below you will find 4 practical exercises on database normalization. Try to solve them before looking at the solution.

---

### **Exercise 1: Detect 1NF violations**

Analyze the following table and explain why it is not in First Normal Form (1NF). Then propose a normalized version.

| id | nombre | correos |
| --- | ------ | ----------------------- |
| 1 | Elena | elena@mail.com; e@x.com |

<details><summary>Show solution</summary>

The `correos` column contains multiple values in a single cell, which violates 1NF.

**Solution (normalized):**

| id | nombre | correo |
| --- | ------ | -------------- |
| 1 | Elena | elena@mail.com |
| 1 | Elena | e@x.com |

</details>

---

### **Exercise 2: Separate data according to 2NF**

Look at the following table:

| profesor_id | curso_id | profesor_nombre |
| ----------- | -------- | --------------- |
| 1 | 101 | Juan Ortega |
| 1 | 102 | Juan Ortega |

Does it violate Second Normal Form? If so, normalize the structure.

<details><summary>Show solution</summary>

Yes. `profesor_nombre` depends only on `profesor_id`, not on the whole `(profesor_id, curso_id)` pair.

**Solution:**

**`teachers` table:**
| profesor_id | profesor_nombre |
|-------------|------------------|
| 1 | Juan Ortega |

**`teaching` table:**
| profesor_id | curso_id |
|-------------|-----------|
| 1 | 101 |
| 1 | 102 |

</details>

---

### **Exercise 3: Remove a transitive dependency (3NF)**

Analyze this table:

| cliente_id | nombre_cliente | ciudad | país |
| ---------- | -------------- | --------- | ------ |
| 1 | Ana Rivas | Madrid | Spain |
| 2 | Laura Vázquez | Barcelona | Spain |

What 3NF problem can you spot? Propose a normalized design.

<details><summary>Show solution</summary>

`país` depends on `ciudad`, not directly on `cliente_id`. This is a transitive dependency.

**Solution:**

**`cities` table:**
| ciudad_id | ciudad | país |
|-----------|------------|---------|
| 1 | Madrid | Spain |
| 2 | Barcelona | Spain |

**`customers` table:**
| cliente_id | nombre_cliente | ciudad_id |
|------------|----------------|-----------|
| 1 | Ana Rivas | 1 |
| 2 | Laura Vázquez | 2 |

</details>

---

### **Exercise 4: Normalize an orders table**

Given the following table:

| order_id | customer | product | quantity | unit_price |
| --------- | ----------- | ---------- | -------- | --------------- |
| 1 | Pedro Núñez | Pen | 3 | 0.75 |
| 2 | Pedro Núñez | A4 folder | 2 | 1.50 |

Design a normalized model with at least three tables.

<details><summary>Show solution</summary>

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
