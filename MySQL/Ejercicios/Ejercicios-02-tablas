# **Ejercicios - Tema 2: Creación y Modificación de Tablas en MySQL**

A continuación, encontrarás 5 ejercicios prácticos sobre la creación y modificación de tablas, y el uso de tipos de datos en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una tabla `customers`**

Crea una tabla llamada `customers` con los siguientes campos:

- `customer_id`: número entero, clave primaria, auto incremental.
- `first_name`: texto de hasta 50 caracteres.
- `last_name`: texto de hasta 50 caracteres.
- `signup_date`: fecha.
- `newsletter_subscribed`: booleano.

<details><summary>Mostrar Solución</summary>

```sql
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  signup_date DATE,
  newsletter_subscribed BOOLEAN
);
```

</details>

---

### **Ejercicio 2: Crear una tabla `orders` con clave foránea**

Crea una tabla `orders` con los siguientes campos:

- `order_id`: clave primaria.
- `customer_id`: clave foránea que referencia `customers(customer_id)`.
- `total_amount`: número decimal con 2 decimales.
- `created_at`: fecha y hora.

<details><summary>Mostrar Solución</summary>

```sql
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10,2),
  created_at DATETIME,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

</details>

---

### **Ejercicio 3: Agregar una columna a la tabla `customers`**

Añade una columna llamada `phone_number` del tipo `VARCHAR(20)` a la tabla `customers`.

<details><summary>Mostrar Solución</summary>

```sql
ALTER TABLE customers ADD COLUMN phone_number VARCHAR(20);
```

</details>

---

### **Ejercicio 4: Modificar un tipo de dato**

Modifica el campo `phone_number` para que pueda almacenar hasta 30 caracteres.

<details><summary>Mostrar Solución</summary>

```sql
ALTER TABLE customers MODIFY COLUMN phone_number VARCHAR(30);
```

</details>

---

### **Ejercicio 5: Crear una tabla con un campo `ENUM`**

Crea una tabla `feedback` con los siguientes campos:

- `id`: clave primaria.
- `customer_id`: clave foránea hacia `customers`.
- `rating`: valor enumerado que puede ser `'excellent'`, `'good'`, `'average'`, `'poor'`.

<details><summary>Mostrar Solución</summary>

```sql
CREATE TABLE feedback (
  id INT PRIMARY KEY,
  customer_id INT,
  rating ENUM('excellent', 'good', 'average', 'poor'),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

</details>
