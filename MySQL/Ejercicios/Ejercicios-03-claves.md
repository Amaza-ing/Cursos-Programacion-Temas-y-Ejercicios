# **Exercises - Topic 3: Primary and Foreign Keys**

Below you will find 6 practical exercises to create relationships between tables and apply integrity constraints with primary and foreign keys in MySQL.

Try to solve them before consulting the solution.

---

### **Exercise 1: Create a table with a simple primary key**

Create a table called `categories` with the fields:

- `id`: integer, primary key.
- `name`: text of up to 40 characters.

<details><summary>Show Solution</summary>

```sql
CREATE TABLE categories (
  id INT PRIMARY KEY,
  name VARCHAR(40)
);
```

</details>

---

### **Exercise 2: Create a table with foreign key**

Create a table `products` with the following fields:

- `id`: integer, primary key.
- `name`: text up to 100 characters.
- `category_id`: integer, foreign key to `categories(id)`.

<details><summary>Show Solution</summary>

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

### **Exercise 3: Create composite primary key**

Create a table `student_courses` that stores the relationship between students and courses, with the following fields:

- `student_id`: integer.
- `course_id`: integer.
- Primary key composed between `student_id` and `course_id`.

<details><summary>Show Solution</summary>

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

<details><summary>Show Solution</summary>

```sql
ALTER TABLE student_courses
ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id),
ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(id);
```

</details>

---

### **Exercise 5: Apply ON DELETE SET NULL constraint**

Create a table `posts` with the fields:

- `id`: integer, primary key.
- `author_id`: integer, foreign key to `users(id)` with the condition that if the user is deleted, `author_id` remains in `NULL`.

<details><summary>Show Solution</summary>

```sql
CREATE TABLE posts (
  id INT PRIMARY KEY,
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);
```

</details>

---

### **Exercise 6: View keys of a table**

Queries the keys and restrictions defined in the `products` table.

<details><summary>Show Solution</summary>

```sql
SHOW CREATE TABLE products;
```

</details>
