# **Ejercicios - Tema 1: Introducción a MySQL**

A continuación, encontrarás 5 ejercicios prácticos para afianzar los conceptos del Tema 1.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Instalar MySQL y acceder al cliente de línea de comandos**

Instala MySQL en tu sistema operativo e intenta acceder al cliente de MySQL como usuario root.

<details><summary>Mostrar Solución</summary>

```sh
mysql -u root -p
```

Luego introduce la contraseña establecida durante la instalación.

</details>

---

### **Ejercicio 2: Crear una base de datos llamada `library`**

Usando el cliente MySQL, crea una base de datos llamada `library` y confírmalo listando las bases existentes.

<details><summary>Mostrar Solución</summary>

```sql
CREATE DATABASE library;
SHOW DATABASES;
```

</details>

---

### **Ejercicio 3: Crear una tabla `books` dentro de `library`**

Crea una tabla llamada `books` con los siguientes campos:

- `id`: número entero, clave primaria, auto incremental
- `title`: texto de hasta 100 caracteres
- `author`: texto de hasta 100 caracteres

<details><summary>Mostrar Solución</summary>

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

### **Ejercicio 4: Insertar datos en la tabla `books`**

Inserta tres libros en la tabla `books` con los títulos y autores que prefieras.

<details><summary>Mostrar Solución</summary>

```sql
INSERT INTO books (title, author)
VALUES ('1984', 'George Orwell'),
       ('Cien años de soledad', 'Gabriel García Márquez'),
       ('El Principito', 'Antoine de Saint-Exupéry');
```

</details>

---

### **Ejercicio 5: Consultar todos los libros registrados**

Haz una consulta para mostrar todos los libros de la tabla `books`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM books;
```

</details>
