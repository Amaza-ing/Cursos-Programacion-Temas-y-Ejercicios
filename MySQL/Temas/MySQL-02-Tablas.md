# **Topic 2: Creating and Modifying Tables in MySQL**

In this topic we will learn how to:

- Create tables with different data types.
- Modify existing tables.
- Understand primary and foreign keys.
- Use the most common data types in MySQL.

---

## **1. Creating tables in MySQL**

To create a table, you use the `CREATE TABLE` statement. For example, let's create a `users` table with several fields:

```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100),
  birth_date DATE,
  is_active BOOLEAN
);
```

### **Explanation of the fields:**

- `id`: an integer that increments automatically. It is the primary key (`PRIMARY KEY`).
- `name`: short text of up to 50 characters.
- `email`: longer text of up to 100 characters.
- `birth_date`: a date (`YYYY-MM-DD`).
- `is_active`: a true/false value.

---

## **2. Data types in MySQL**

### **Numeric**

| Type | Description |
| --------- | ---------------------------- |
| `INT` | Integer (4 bytes) |
| `TINYINT` | Small integer (1 byte) |
| `BIGINT` | Large integer (8 bytes) |
| `DECIMAL` | Numbers with exact decimals |
| `FLOAT` | Numbers with approximate decimals |

### **Text strings**

| Type | Description |
| ------------ | --------------------------------------- |
| `CHAR(n)` | Fixed-length string of length `n` |
| `VARCHAR(n)` | Variable-length string of up to `n` characters |
| `TEXT` | Long text (up to 65,535 characters) |

### **Dates and times**

| Type | Description |
| ---------- | ------------------------------------ |
| `DATE` | Date (`YYYY-MM-DD`) |
| `TIME` | Time (`HH:MM:SS`) |
| `DATETIME` | Date and time (`YYYY-MM-DD HH:MM:SS`) |

### **Others**

| Type | Description |
| --------- | ------------------------- |
| `BOOLEAN` | `TRUE` or `FALSE` |
| `ENUM` | List of possible values |

Example of using `ENUM`:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  category ENUM('books', 'games', 'electronics')
);
```

---

[![How to create a database and tables](https://img.youtube.com/vi/kZ42WlV-Ufs/0.jpg)](https://www.youtube.com/watch?v=kZ42WlV-Ufs&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **3. Primary and foreign keys**

### **Primary key**

Uniquely identifies each row in a table.

```sql
CREATE TABLE categories (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);
```

### **Foreign key**

Links data between two tables.

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

---

[![Primary and foreign keys](https://img.youtube.com/vi/2FF8n4hXcSs/0.jpg)](https://www.youtube.com/watch?v=2FF8n4hXcSs&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **4. Modifying tables with `ALTER TABLE`**

You can modify an existing table with the `ALTER TABLE` command.

### **Add a column**

```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
```

### **Delete a column**

```sql
ALTER TABLE users DROP COLUMN phone;
```

### **Modify a column**

```sql
ALTER TABLE users MODIFY COLUMN name VARCHAR(100);
```

---

## **5. Deleting a table**

To delete a table completely:

```sql
DROP TABLE users;
```

> ⚠️ Caution: this action is irreversible and deletes all the data in the table.

---

## **6. Conclusion**

- We have learned how to create tables using appropriate data types.
- We know how to modify their structure with `ALTER TABLE`.
- We understand the importance of primary and foreign keys.

---
In the next topic we will learn how to **create relationships between tables and apply integrity constraints with primary and foreign keys.**
