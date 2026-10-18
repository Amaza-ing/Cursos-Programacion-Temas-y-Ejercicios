# **Exercises - Topic 1: Introduction to MySQL**

Below you will find 5 practical exercises to reinforce the concepts from Topic 1.

Try to solve them before looking at the solution.

---

### **Exercise 1: Install MySQL and access the command-line client**

Install MySQL on your operating system and try to access the MySQL client as the root user.

<details><summary>Show solution</summary>

```sh
mysql -u root -p
```

Then enter the password you set during installation.

</details>

---

### **Exercise 2: Create a database called `library`**

Using the MySQL client, create a database called `library` and check that it exists by listing the existing databases.

<details><summary>Show solution</summary>

```sql
CREATE DATABASE library;
SHOW DATABASES;
```

</details>

---

### **Exercise 3: Create a `books` table inside `library`**

Create a table called `books` with the following fields:

- `id`: integer, primary key, auto-increment
- `title`: text of up to 100 characters
- `author`: text of up to 100 characters

<details><summary>Show solution</summary>

```sql
USE library;

CREATE TABLE books (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  author VARCHAR(100)
);
```

</details>

---

### **Exercise 4: Insert data into the `books` table**

Insert three books into the `books` table with whatever titles and authors you like.

<details><summary>Show solution</summary>

```sql
INSERT INTO books (title, author)
VALUES ('1984', 'George Orwell'),
       ('Cien años de soledad', 'Gabriel García Márquez'),
       ('El Principito', 'Antoine de Saint-Exupéry');
```

</details>

---

### **Exercise 5: Query all the stored books**

Write a query that displays all the books in the `books` table.

<details><summary>Show solution</summary>

```sql
SELECT * FROM books;
```

</details>
