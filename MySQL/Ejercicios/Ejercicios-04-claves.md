# **Ejercicios - Tema 4: Claves Primarias y Foráneas**

A continuación, encontrarás 6 ejercicios prácticos para crear relaciones entre tablas y aplicar restricciones de integridad con claves primarias y foráneas en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una tabla con clave primaria simple**

Crea una tabla llamada `categories` con los campos:

- `id`: entero, clave primaria.
- `name`: texto de hasta 40 caracteres.

<details><summary>Mostrar Solución</summary>

```sql
CREATE TABLE categories (
  id INT PRIMARY KEY,
  name VARCHAR(40)
);
```

</details>

---

### **Ejercicio 2: Crear una tabla con clave foránea**

Crea una tabla `products` con los siguientes campos:

- `id`: entero, clave primaria.
- `name`: texto de hasta 100 caracteres.
- `category_id`: entero, clave foránea hacia `categories(id)`.

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 3: Crear clave primaria compuesta**

Crea una tabla `student_courses` que almacene la relación entre estudiantes y cursos, con los siguientes campos:

- `student_id`: entero.
- `course_id`: entero.
- Clave primaria compuesta entre `student_id` y `course_id`.

<details><summary>Mostrar Solución</summary>

```sql
CREATE TABLE student_courses (
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id)
);
```

</details>

---

### **Ejercicio 4: Definir múltiples claves foráneas**

Añade claves foráneas a la tabla `student_courses` creada en el ejercicio anterior, apuntando a `students(id)` y `courses(id)`.

<details><summary>Mostrar Solución</summary>

```sql
ALTER TABLE student_courses
ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(id),
ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses(id);
```

</details>

---

### **Ejercicio 5: Aplicar restricción ON DELETE SET NULL**

Crea una tabla `posts` con los campos:

- `id`: entero, clave primaria.
- `author_id`: entero, clave foránea hacia `users(id)` con la condición de que si el usuario se elimina, `author_id` quede en `NULL`.

<details><summary>Mostrar Solución</summary>

```sql
CREATE TABLE posts (
  id INT PRIMARY KEY,
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);
```

</details>

---

### **Ejercicio 6: Ver claves de una tabla**

Consulta las claves y restricciones definidas en la tabla `products`.

<details><summary>Mostrar Solución</summary>

```sql
SHOW CREATE TABLE products;
```

</details>
