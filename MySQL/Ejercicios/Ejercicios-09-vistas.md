# **Ejercicios - Tema 9: Crear y Gestionar Vistas (VIEW)**

A continuación, encontrarás 5 ejercicios prácticos para trabajar con vistas en MySQL. Estos ejercicios te ayudarán a simplificar consultas complejas y reutilizarlas de forma eficiente.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Crear una vista con datos filtrados**

Crea una vista llamada `clientes_suscritos` que muestre únicamente los clientes que están suscritos al boletín (`newsletter_subscribed = TRUE`), incluyendo sus nombres y fechas de registro.

<details><summary>Mostrar Solución</summary>

```sql
CREATE VIEW clientes_suscritos AS
SELECT first_name, last_name, signup_date
FROM customers
WHERE newsletter_subscribed = TRUE;
```

</details>

---

### **Ejercicio 2: Crear una vista con datos combinados**

Crea una vista llamada `resumen_pedidos` que muestre para cada pedido el ID del pedido, el nombre del cliente y la fecha del pedido.

<details><summary>Mostrar Solución</summary>

```sql
CREATE VIEW resumen_pedidos AS
SELECT o.id AS order_id, c.first_name, c.last_name, o.created_at
FROM orders o
JOIN customers c ON o.customer_id = c.id;
```

</details>

---

### **Ejercicio 3: Consultar una vista con condiciones adicionales**

Utiliza la vista `resumen_pedidos` para obtener los pedidos realizados a partir del 1 de abril de 2025.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM resumen_pedidos
WHERE created_at >= '2025-04-01';
```

</details>

---

### **Ejercicio 4: Modificar una vista existente**

Actualiza la vista `clientes_suscritos` para que además muestre la ciudad del cliente (campo `city`).

<details><summary>Mostrar Solución</summary>

```sql
CREATE OR REPLACE VIEW clientes_suscritos AS
SELECT first_name, last_name, city, signup_date
FROM customers
WHERE newsletter_subscribed = TRUE;
```

</details>

---

### **Ejercicio 5: Eliminar una vista**

Elimina la vista `resumen_pedidos` de la base de datos.

<details><summary>Mostrar Solución</summary>

```sql
DROP VIEW resumen_pedidos;
```

</details>
