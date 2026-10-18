# Topic 1: Introduction to MySQL

In this first topic we are going to learn what MySQL is, what it is for and how it is used in application development. If you're starting from scratch, don't worry: we'll go step by step.

---

## **1. What is MySQL?**

MySQL is a **relational database management system (RDBMS)**. It allows you to store, organize and access large amounts of information in a quick and structured way.

It is based on the **SQL (Structured Query Language)** language, a standard language used to work with databases.

---

## **2. What is MySQL used for?**

MySQL is used in many contexts:

· Websites that need to save users, products, orders, etc.  
· Mobile applications with records and dynamic data.  
· Business management systems.  
· Data analysis and data science projects.

Being based on SQL, it is compatible with many technologies and programming languages ​​(such as PHP, Java, Python or Node.js).

---

## **3. Advantages of MySQL**

· It is free and open source.  
· It has high performance and scalability.  
· It is widely used, so there is a lot of documentation and support.  
· Compatible with multiple platforms (Windows, Linux, macOS).

---

## **4.Difference between MySQL and SQL**

| Concept | Description |
| --------- | --------------------------------------------------------------------------- |
| **SQL** | Structured query language. It is a standard.                             |
| **MySQL** | Program (software) that implements that language to manage databases. |

---

## **5.What is a database?**

A database is an organized collection of data. For example, an online store could have:

· An `products` table with the list of products.  
· An `users` table with customer information.  
· An `orders` table with the orders placed.

Each table contains rows (records) and columns (fields).

---

[![What is SQL](https://img.youtube.com/vi/8LQUlshIdqw/0.jpg)](https://www.youtube.com/watch?v=8LQUlshIdqw&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. What is a table?**

A table is like a spreadsheet with rows and columns.

`products` table example:

| id | name | price | stock |
| --- | -------- | ----- | ----- |
| 1 | T-shirt | 19.99 | 50 |
| 2 | Sneakers | 49.99 | 20 |
| 3 | Jacket | 89.99 | 15 |

- Each **row** is a product.
- Each **column** is a product characteristic.

---

## **7. Installing MySQL**

### Option 1: Install MySQL Server

1. Visit the official website: https://dev.mysql.com/downloads/
2. Download the MySQL installer for your operating system.
3. During installation, it is easiest to do the full installation, or choose:
   -MySQL Server.
   -Command Line Client.
   - MySQL Workbench (optional but very useful for managing databases visually).
   - Examples (optional but useful to get started).
4. Create a password for the user `root`.

> Remember this password: you will need it later.
If we want to use another visual interface to manage databases, we can install the one we prefer. In the video examples DBeaver will be used instead of MySQL Workbench.

To install DBeaver you can access here: https://dbeaver.io/download/

---

[![How to install MySQL](https://img.youtube.com/vi/yHWJ3nc6Vk4/0.jpg)](https://www.youtube.com/watch?v=yHWJ3nc6Vk4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

### Option 2: Use an online service

If you can't install anything, you can use services like:

https://www.db-fiddle.com/  
https://sqlize.online/  
https://onecompiler.com/mysql

---

## **8. Verify installation**

### **Using the command line**

In the terminal or console, type:

```sh
mysql -u root -p
```

Enter the password and you should access the MySQL prompt:

```sql
mysql>
```

### **Using MySQL Workbench**

1. Open MySQL Workbench.
2. Create a new connection with the user `root`.
3. Enter the password you set.
4. Click "Test Connection" to verify that everything works.

### **Connection Errors**

It is possible that sometimes some errors occur that prevent the connection to the database, these are some of the most common and are easily solvable:

- "Public Key Retrieval is not allowed"
- "Connection refused: getsockopt"

---

[![](https://img.youtube.com/vi/5IYm-B2ptkI/0.jpg) Connection Error](https://www.youtube.com/watch?v=5IYm-B2ptkI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **9. First contact with SQL**

Once you have access to a MySQL environment, you can start executing commands.

```sql
SELECT 'Hello, world!';
```

---

## **10. Structure of a MySQL database**

A MySQL database is made up of:

- **Tables**: Structures where data is stored.
- **Rows**: Each record within a table.
- **Columns**: Each field within a table.
- **Primary keys**: Unique identifiers for each row.
- **Foreign keys**: They relate data between different tables.

Example:

```sql
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_name VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## **11. Conclusion**

- MySQL is a powerful and widely used database system.
- SQL is the language that allows us to interact with databases.

---

In the next topic, we will learn how to create and modify tables in MySQL in depth, and how to work with the different types of data available.
