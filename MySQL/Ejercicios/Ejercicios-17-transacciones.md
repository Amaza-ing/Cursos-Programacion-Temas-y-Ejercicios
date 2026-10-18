# **Exercises - Topic 17: Transactions in MySQL**

Below you will find 5 practical exercises to work with **transactions** in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Transfer between accounts with error handling**

In the `accounts(id, balance)` table, run a transaction that transfers 250 from account `id = 3` to account `id = 4`. If any update fails, roll back all the changes.

<details><summary>Show solution</summary>

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 250 WHERE id = 3;
UPDATE accounts SET balance = balance + 250 WHERE id = 4;
COMMIT;
-- Si algo falla:
-- ROLLBACK;
```

</details>

---

### **Exercise 2: Use SAVEPOINT to partially roll back**

In the `orders(id, status)` table, first update order `id = 10` to `status = 'SHIPPED'` and save a checkpoint named `sp1`. Then update order `id = 11` to `status = 'SHIPPED'`, but roll back only this last update using `SAVEPOINT`.

<details><summary>Show solution</summary>

```sql
START TRANSACTION;
UPDATE orders SET status = 'SHIPPED' WHERE id = 10;
SAVEPOINT sp1;
UPDATE orders SET status = 'SHIPPED' WHERE id = 11;
ROLLBACK TO sp1;
COMMIT;
```

</details>

---

### **Exercise 3: Inventory adjustment with validation**

In `inventory(product_id, quantity)`, subtract 5 units from the product with `product_id = 7` only if the available quantity is greater than or equal to 5. If it isn't, roll back the transaction.

<details><summary>Show solution</summary>

```sql
START TRANSACTION;
UPDATE inventory
SET quantity = quantity - 5
WHERE product_id = 7 AND quantity >= 5;

-- Validar si se actualizó alguna fila
IF ROW_COUNT() = 0 THEN
  ROLLBACK;
ELSE
  COMMIT;
END IF;
```

</details>

---

### **Exercise 4: Change the isolation level**

Set the isolation level to `READ COMMITTED` and then insert a new customer into `customers`. Make sure you commit the transaction.

<details><summary>Show solution</summary>

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
INSERT INTO customers(first_name, last_name, email)
VALUES ('Laura', 'Martínez', 'laura.martinez@example.com');
COMMIT;
```

</details>

---

### **Exercise 5: Multiple operations with a final commit**

In `products(id, price)` and `suppliers(id, city)`, update the price of product `id = 5` to 19.99 and change the city of supplier `id = 2` to `'Barcelona'` in the same transaction. Commit only if both operations run successfully.

<details><summary>Show solution</summary>

```sql
START TRANSACTION;
UPDATE products SET price = 19.99 WHERE id = 5;
UPDATE suppliers SET city = 'Barcelona' WHERE id = 2;
COMMIT;
-- Si alguna falla:
-- ROLLBACK;
```

</details>
