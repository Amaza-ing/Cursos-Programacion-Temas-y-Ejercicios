# **Topic 17: Transactions in MySQL**

In this topic we will learn how to:

- Understand what a transaction is and why it is useful.
- Use transactions to ensure data integrity.
- Control how transactions are started, committed and rolled back.
- Know the ACID properties.

---

## **1. What is a transaction?**

A **transaction** is a set of SQL operations that run as an indivisible unit. This means that **either all of them run successfully or none of them run at all**.

---

## **2. ACID properties**

Transactions are governed by four properties known as **ACID**:

- **Atomicity**: either all the operations are completed or none are applied.
- **Consistency**: the database goes from one valid state to another.
- **Isolation**: concurrent transactions do not interfere with each other.
- **Durability**: committed changes persist even if there are failures.

---

## **3. Basic transaction syntax**

```sql
START TRANSACTION;
-- operaciones SQL
COMMIT; -- confirma los cambios
```

If something goes wrong, you can undo the changes:

```sql
ROLLBACK; -- revierte la transacción
```

---

## **4. Basic example**

Suppose we want to transfer money from one account to another:

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;
```

If either of the two updates fails, we can do:

```sql
ROLLBACK;
```

---

## **5. Using SAVEPOINT**

A **savepoint** is an intermediate checkpoint within a transaction:

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 50 WHERE id = 1;
SAVEPOINT sp1;
UPDATE accounts SET balance = balance + 50 WHERE id = 2;
ROLLBACK TO sp1; -- vuelve al estado después del primer UPDATE
COMMIT;
```

---

## **6. Transaction isolation**

MySQL lets you adjust the isolation level to control how concurrent transactions interact:

- `READ UNCOMMITTED`
- `READ COMMITTED`
- `REPEATABLE READ` (default)
- `SERIALIZABLE`

Example of how to change it:

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

---

[![Transactions](https://img.youtube.com/vi/3wDnXYfvI8o/0.jpg)](https://www.youtube.com/watch?v=3wDnXYfvI8o&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Good practices**

- Start the transaction as close as possible to the critical operations.
- Commit (`COMMIT`) or roll back (`ROLLBACK`) as soon as possible.
- Don't keep transactions open for too long, so you don't lock resources.

---

## **8. Conclusion**

- Transactions ensure that a set of operations runs safely and consistently.
- The ACID properties make data manipulation reliable.
- Tools like `SAVEPOINT` and isolation levels give you more control over how transactions run.

---

In the next topic we will learn how to **use IF in queries and stored procedures**.
