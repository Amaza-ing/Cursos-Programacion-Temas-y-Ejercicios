# **Exercises - Topic 3: Primary and Foreign Keys**

Below you will find 6 practical exercises to create relationships between tables and apply integrity constraints with primary and foreign keys in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: Create a table with a simple primary key**

Create a table called `categories` with these fields:

- `id`: integer, primary key.
- `name`: text of up to 40 characters.

<details><summary>Show solution</summary>

```sql
CREATE TABLE categories (
  id INT PRIMARY KEY,
  name VARCHAR(40)
);
```

</details>

---

### **Exercise 2: Create a table with a foreign key**

Create a `products` table with the following fields:

- `id`: integer, primary key.
- `name`: text of up to 100 characters.
- `category_id`: integer, foreign key to `categories(id)`.

<details><summary>Show solution</summary>

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

</details>

---

### **Exercise 3: Create a composite primary key**

Create a `student_courses` table that stores the relationship between students and courses, with the following fields:

- `student_id`: integer.
- `course_id`: integer.
- A composite primary key made up of `student_id` and `course_id`.

<details><summary>Show solution</summary>

```sql
CREATE TABLE student_courses (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id)
);
```

</details>

---

### **Exercise 4: Define multiple foreign keys**

Add foreign keys to the `student_courses` table created in the previous exercise, pointing to `students(id)` and `courses(id)`.

<details><summary>Show solution</summary>

```sql
ALTER TABLE student_courses
ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id),
ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(id);
```

</details>

---

### **Exercise 5: Apply an ON DELETE SET NULL constraint**

Create a `posts` table with these fields:

- `id`: integer, primary key.
- `author_id`: integer, foreign key to `users(id)`, so that if the user is deleted, `author_id` is set to `NULL`.

<details><summary>Show solution</summary>

```sql
CREATE TABLE posts (
  id INT PRIMARY KEY,
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);
```

</details>

---

### **Exercise 6: View the keys of a table**

Look up the keys and constraints defined in the `products` table.

<details><summary>Show solution</summary>

```sql
SHOW CREATE TABLE products;
```

</details>
