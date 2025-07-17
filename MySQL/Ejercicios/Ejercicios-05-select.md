# **Ejercicios - Tema 5: Consultas Avanzadas con SELECT y Condiciones**

A continuación, encontrarás 10 ejercicios prácticos para practicar el uso de `SELECT`, `WHERE`, `ORDER BY`, `LIMIT` y operadores lógicos en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Consultar nombres y correos de los clientes**

Obtén solo los campos `first_name` y `email` de todos los registros en la tabla `customers`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT first_name, email FROM customers;
```

</details>

---

### **Ejercicio 2: Filtrar clientes por ciudad**

Muestra todos los datos de los clientes cuya ciudad sea 'Valencia'.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM customers
WHERE city = 'Valencia';
```

</details>

---

### **Ejercicio 3: Buscar por coincidencia parcial**

Busca los clientes cuyo apellido comience por 'Lo'.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM customers
WHERE last_name LIKE 'Lo%';
```

</details>

---

### **Ejercicio 4: Filtrar por valores múltiples**

Consulta los pedidos donde el `customer_id` sea 1, 3 o 5.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM orders
WHERE customer_id IN (1, 3, 5);
```

</details>

---

### **Ejercicio 5: Filtrar por rango de valores**

Muestra los pedidos cuyo `total_amount` esté entre 50 y 200 euros.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM orders
WHERE total_amount BETWEEN 50 AND 200;
```

</details>

---

### **Ejercicio 6: Usar operadores lógicos**

Obtén los clientes que están suscritos al boletín **y** se registraron después del 1 de abril de 2025.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM customers
WHERE newsletter_subscribed = TRUE
AND signup_date > '2025-04-01';
```

</details>

---

### **Ejercicio 7: Ordenar resultados**

Lista todos los pedidos ordenados por `total_amount` de mayor a menor.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM orders
ORDER BY total_amount DESC;
```

</details>

---

### **Ejercicio 8: Ordenar con múltiples criterios**

Muestra los clientes ordenados primero por ciudad (ascendente) y luego por apellido (descendente).

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM customers
ORDER BY city ASC, last_name DESC;
```

</details>

---

### **Ejercicio 9: Limitar el número de resultados**

Obtén los 4 primeros registros de la tabla `customers`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM customers
LIMIT 4;
```

</details>

---

### **Ejercicio 10: Combinar filtros, orden y límite**

Consulta los 2 pedidos más antiguos cuyo monto supere los 100 euros.

<details><summary>Mostrar Solución</summary>

```sql
SELECT * FROM orders
WHERE total_amount > 100
ORDER BY created_at ASC
LIMIT 2;
```

</details>
