# **Ejercicios - Tema 5: Insertar, Actualizar y Eliminar Datos en MySQL**

A continuación, encontrarás 7 ejercicios prácticos para practicar la inserción, actualización y eliminación de datos con SQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Insertar un nuevo cliente**

Añade un cliente con los siguientes datos en la tabla `customers`:

- Nombre: Marcos
- Apellido: Díaz
- Fecha de registro: 2025-04-15
- Suscripción al boletín: TRUE

<details><summary>Mostrar Solución</summary>

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES ('Marcos', 'Díaz', '2025-04-15', TRUE);
```

</details>

---

### **Ejercicio 2: Insertar múltiples clientes**

Agrega los siguientes dos clientes:

1. Julia Romero, 2025-04-16, FALSE
2. Sergio López, 2025-04-17, TRUE

<details><summary>Mostrar Solución</summary>

```sql
INSERT INTO customers (first_name, last_name, signup_date, newsletter_subscribed)
VALUES
('Julia', 'Romero', '2025-04-16', FALSE),
('Sergio', 'López', '2025-04-17', TRUE);
```

</details>

---

### **Ejercicio 3: Insertar un pedido vinculado**

Crea un pedido en la tabla `orders` para el `customer_id = 1` con:

- `order_id`: 101
- `total_amount`: 89.99
- `created_at`: 2025-04-15 09:45:00

<details><summary>Mostrar Solución</summary>

```sql
INSERT INTO orders (order_id, customer_id, total_amount, created_at)
VALUES (101, 1, 89.99, '2025-04-15 09:45:00');
```

</details>

---

### **Ejercicio 4: Actualizar un registro existente**

Cambia el estado de suscripción al boletín del cliente con `customer_id = 3` a `TRUE`.

<details><summary>Mostrar Solución</summary>

```sql
UPDATE customers
SET newsletter_subscribed = TRUE
WHERE customer_id = 3;
```

</details>

---

### **Ejercicio 5: Actualizar múltiples campos**

Actualiza el nombre y apellido del cliente con `customer_id = 2` a:

- `first_name`: Carla
- `last_name`: Navarro

<details><summary>Mostrar Solución</summary>

```sql
UPDATE customers
SET first_name = 'Carla', last_name = 'Navarro'
WHERE customer_id = 2;
```

</details>

---

### **Ejercicio 6: Eliminar un pedido**

Elimina el pedido con `order_id = 101`.

<details><summary>Mostrar Solución</summary>

```sql
DELETE FROM orders
WHERE order_id = 101;
```

</details>

---

### **Ejercicio 7: Borrar todos los registros de prueba**

Elimina todos los registros de la tabla `feedback` si existe.

<details><summary>Mostrar Solución</summary>

```sql
DELETE FROM feedback;
```

</details>
