# **Tema 2: Creación y Modificación de Tablas en MySQL**

En este tema aprenderemos a:

- Crear tablas con distintos tipos de datos.
- Modificar tablas ya existentes.
- Comprender las claves primarias y foráneas.
- Utilizar los tipos de datos más comunes en MySQL.

---

## **1. Crear tablas en MySQL**

Para crear una tabla, se usa la instrucción `CREATE TABLE`. Por ejemplo, vamos a crear una tabla `users` con varios campos:

```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100),
  birth_date DATE,
  is_active BOOLEAN
);
```

### **Explicación de los campos:**

- `id`: número entero que se incrementa automáticamente. Es la clave primaria (`PRIMARY KEY`).
- `name`: texto corto de hasta 50 caracteres.
- `email`: texto más largo de hasta 100 caracteres.
- `birth_date`: una fecha (`YYYY-MM-DD`).
- `is_active`: valor verdadero/falso.

---

## **2. Tipos de datos en MySQL**

### **Numéricos**

| Tipo      | Descripción                     |
| --------- | ------------------------------- |
| `INT`     | Entero (4 bytes)                |
| `TINYINT` | Entero pequeño (1 byte)         |
| `BIGINT`  | Entero grande (8 bytes)         |
| `DECIMAL` | Números con decimales exactos   |
| `FLOAT`   | Números con decimales inexactos |

### **Cadenas de texto**

| Tipo         | Descripción                             |
| ------------ | --------------------------------------- |
| `CHAR(n)`    | Cadena fija de longitud `n`             |
| `VARCHAR(n)` | Cadena variable de hasta `n` caracteres |
| `TEXT`       | Texto largo (hasta 65,535 caracteres)   |

### **Fechas y tiempos**

| Tipo       | Descripción                          |
| ---------- | ------------------------------------ |
| `DATE`     | Fecha (`YYYY-MM-DD`)                 |
| `TIME`     | Hora (`HH:MM:SS`)                    |
| `DATETIME` | Fecha y hora (`YYYY-MM-DD HH:MM:SS`) |

### **Otros**

| Tipo      | Descripción               |
| --------- | ------------------------- |
| `BOOLEAN` | `TRUE` o `FALSE`          |
| `ENUM`    | Lista de valores posibles |

Ejemplo de uso de `ENUM`:

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  category ENUM('books', 'games', 'electronics')
);
```

---

[![Cómo crear una base de datos y tablas](https://img.youtube.com/vi/kZ42WlV-Ufs/0.jpg)](https://www.youtube.com/watch?v=kZ42WlV-Ufs&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **3. Claves primarias y foráneas**

### **Clave primaria**

Identifica de forma única cada fila de una tabla.

```sql
CREATE TABLE categories (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);
```

### **Clave foránea**

Relaciona datos entre dos tablas.

```sql
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

---

[![Claves primarias y foraneas](https://img.youtube.com/vi/2FF8n4hXcSs/0.jpg)](https://www.youtube.com/watch?v=2FF8n4hXcSs&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **4. Modificar tablas con `ALTER TABLE`**

Puedes modificar una tabla existente con el comando `ALTER TABLE`.

### **Agregar una columna**

```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(20);
```

### **Eliminar una columna**

```sql
ALTER TABLE users DROP COLUMN phone;
```

### **Modificar una columna**

```sql
ALTER TABLE users MODIFY COLUMN name VARCHAR(100);
```

---

## **5. Eliminar una tabla**

Para eliminar una tabla completamente:

```sql
DROP TABLE users;
```

> ⚠️ Precaución: esta acción es irreversible y elimina todos los datos de la tabla.

---

## **6. Conclusión**

- Hemos aprendido a crear tablas usando tipos de datos apropiados.
- Sabemos cómo modificar su estructura con `ALTER TABLE`.
- Entendemos la importancia de las claves primarias y foráneas.

---

En el siguiente tema aprenderemos a **crear relaciones entre tablas y aplicar restricciones de integridad con claves primarias y foráneas.**
