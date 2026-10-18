# **Exercises - Topic 10: Indexes in MySQL**

Below you will find 5 practical exercises to create, manage and delete indexes in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create a simple index on a frequently searched column**

Create an index named `idx_city` on the `city` column of the `customers` table.

<details><summary>Show solution</summary>

```sql
CREATE INDEX idx_city ON customers(city);
```

</details>

---

### **Exercise 2: Create a unique index to ensure duplicate-free data**

In the `suppliers` table, create a unique index on the `tax_id` column so that its values can't be repeated.

<details><summary>Show solution</summary>

```sql
CREATE UNIQUE INDEX idx_tax_id ON suppliers(tax_id);
```

</details>

---

### **Exercise 3: Create a composite index**

In the `orders` table, create an index named `idx_customer_date` that includes the `customer_id` and `created_at` columns.

<details><summary>Show solution</summary>

```sql
CREATE INDEX idx_customer_date ON orders(customer_id, created_at);
```

</details>

---

### **Exercise 4: View the existing indexes on a table**

List all the indexes created on the `products` table.

<details><summary>Show solution</summary>

```sql
SHOW INDEX FROM products;
```

</details>

---

### **Exercise 5: Delete an existing index**

Remove the `idx_city` index from the `customers` table.

<details><summary>Show solution</summary>

```sql
DROP INDEX idx_city ON customers;
```

</details>
