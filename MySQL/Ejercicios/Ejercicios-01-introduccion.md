# **Exercises - Topic 1: Introduction to MySQL**

Below, you will find 5 practical exercises to strengthen the concepts of Topic 1.

Try to solve them before consulting the solution.

---

### **Exercise 1: Install MySQL and access the command line client**

Install MySQL on your operating system and try to access the MySQL client as root.

<details><summary>Show Solution</summary>

```sh
mysql -u root -p
```

Then enter the password set during installation.

</details>

---

### **Exercise 2: Create a database called `library`**

Using the MySQL client, create a database called `library` and confirm it by listing the existing databases.

<details><summary>Show Solution</summary>

```sql
CREATE DATABASE library;
SHOW DATABASES;
```

</details>

---

### **Exercise 3: Create a table `books` inside `library`**

Create a table called `books` with the following fields:

- `id`: integer, primary key, auto incremental
- `title`: text up to 100 characters
- `author`: text up to 100 characters

<details><summary>Show Solution</summary>

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

### **Exercise 4: Insert data into table `books`**

Insert three books into the `books` table with the titles and authors you prefer.

<details><summary>Show Solution</summary>

```sql
INSERT INTO books (title, author)
VALUES ('1984', 'George Orwell'),
       ('Cien años de soledad', 'Gabriel García Márquez'),
       ('El Principito', 'Antoine de Saint-Exupéry');
```

</details>

---

### **Exercise 5: Consult all registered books**

Make a query to display all books in the `books` table.

<details><summary>Show Solution</summary>

```sql
SELECT * FROM books;
```

</details>
