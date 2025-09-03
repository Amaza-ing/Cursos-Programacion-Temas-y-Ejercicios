# **Tema 5: Insertar, Actualizar y Eliminar Datos en MySQL**

En este tema aprenderemos a:

- Insertar registros en una tabla con `INSERT`.
- Modificar registros existentes con `UPDATE`.
- Eliminar registros con `DELETE`.
- Usar condiciones para modificar o eliminar registros específicos.

---

## **1. Insertar datos con `INSERT`**

La sentencia `INSERT` se utiliza para añadir nuevas filas a una tabla.

### **Sintaxis básica**

```sql
INSERT INTO nombre_tabla (columna1, columna2, ...)
VALUES (valor1, valor2, ...);
```

### **Ejemplo**

Insertar un nuevo cliente en la tabla `customers`:

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES ('Laura', 'Gómez', '2025-04-01', TRUE);
```

También es posible insertar múltiples registros a la vez:

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES
('Luis', 'Martínez', '2025-04-10', FALSE),
('Ana', 'Pérez', '2025-04-12', TRUE);
```

Para realizar una consulta y observar todos los datos de una tabla, por ejemplo de `customers` puedes hacer:

```sql
SELECT * FROM customers;
```

---

[![Cómo Insertar Datos en una Tabla](https://img.youtube.com/vi/qJQqFKdLYyg/0.jpg)](https://www.youtube.com/watch?v=qJQqFKdLYyg&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **2. Actualizar datos con `UPDATE`**

La sentencia `UPDATE` se utiliza para modificar uno o varios registros existentes.

### **Sintaxis básica**

```sql
UPDATE nombre_tabla
SET columna1 = nuevo_valor1, columna2 = nuevo_valor2, ...
WHERE condición;
```

> ⚠️ Hay que usar siempre `WHERE` para evitar actualizar todos los registros por error.

### **Ejemplo**

Actualizar el estado de subscripción a la newsletter de un cliente específico:

```sql
UPDATE customers
SET newsletter_subscribed = FALSE
WHERE customer_id = 3;
```

Actualizar varios campos a la vez:

```sql
UPDATE customers
SET first_name = 'Carlos', last_name = 'Ramírez'
WHERE customer_id = 4;
```

---

## **3. Eliminar datos con `DELETE`**

La sentencia `DELETE` permite eliminar registros de una tabla.

### **Sintaxis básica**

```sql
DELETE FROM nombre_tabla
WHERE condición;
```

> ⚠️ Si no incluyes `WHERE`, se eliminarán **todos los registros**.

### **Ejemplo**

Eliminar un cliente por su ID:

```sql
DELETE FROM customers
WHERE customer_id = 2;
```

Eliminar todos los registros de una tabla (con cuidado):

```sql
DELETE FROM customers;
```

---

## **4. Insertar datos con claves foráneas**

Al insertar datos en tablas que contienen claves foráneas, asegúrate de que el valor referenciado exista en la tabla padre.

Ejemplo: insertar un nuevo pedido en la tabla `orders`:

```sql
INSERT INTO orders (order_id, customer_id, total_amount, created_at)
VALUES (1, 1, 150.00, '2025-04-14 12:30:00');
```

> El valor `customer_id = 1` debe existir en la tabla `customers`.

---

[![Modificación de tablas](https://img.youtube.com/vi/mYsI8AwooG4/0.jpg)](https://www.youtube.com/watch?v=mYsI8AwooG4&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **5. Consideraciones importantes**

- Las operaciones de modificación y eliminación pueden afectar muchos datos si no se usan condiciones específicas.
- Asegúrate de hacer copias de seguridad antes de ejecutar sentencias destructivas.
- Usa `SELECT` con la misma condición que piensas usar en `UPDATE` o `DELETE` para revisar los datos antes:

```sql
SELECT * FROM customers WHERE customer_id = 5;
```

---

## **6. Conclusión**

- `INSERT` se usa para añadir registros nuevos.
- `UPDATE` modifica campos existentes en registros específicos.
- `DELETE` elimina registros según una condición.
- Las operaciones sin condiciones (`WHERE`) afectan a todos los registros.

---

En el próximo tema aprenderemos a realizar **consultas avanzadas con SELECT y condiciones usando WHERE, ORDER BY, LIMIT y operadores lógicos.**
