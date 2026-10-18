# **Exercises - Topic 10: Indexes in MySQL**

Below you will find 5 practical exercises to create, manage and delete indexes in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a simple index on a frequently searched column**

Creates an index named `idx_city` on column `city` of table `customers`.

<details><summary>Show Solution</summary>

```sql
CREATE INDEX idx_city ON customers(city);
```

</details>

---

### **Exercise 2: Create a unique index to ensure duplicate-free data**

On the `suppliers` table, create a unique index on the `tax_id` column so that it is not repeated.

<details><summary>Show Solution</summary>

```sql
CREATE UNIQUE INDEX idx_tax_id ON suppliers(tax_id);
```

</details>

---

### **Exercise 3: Create a composite index**

On the table `orders`, create an index named `idx_customer_date` that includes the columns `customer_id` and `created_at`.

<details><summary>Show Solution</summary>

```sql
CREATE INDEX idx_customer_date ON orders(customer_id, created_at);
```

</details>

---

### **Exercise 4: View existing indexes on a table**

Queries all indexes created on the `products` table.

<details><summary>Show Solution</summary>

```sql
SHOW INDEX FROM products;
```

</details>

---

### **Exercise 5: Delete an existing index**

Removes index `idx_city` from table `customers`.

<details><summary>Show Solution</summary>

```sql
DROP INDEX idx_city ON customers;
```

</details>
