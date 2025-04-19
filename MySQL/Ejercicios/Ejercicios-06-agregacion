# **Ejercicios - Tema 6: Funciones de Agregación y Agrupaciones**

A continuación, encontrarás 10 ejercicios prácticos para practicar funciones de agregación (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`), agrupaciones con `GROUP BY` y filtros con `HAVING` en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Calcular el total de pedidos registrados**

Consulta el número total de pedidos en la tabla `orders`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT COUNT(*) AS total_pedidos FROM orders;
```

</details>

---

### **Ejercicio 2: Calcular la suma total de ventas**

Calcula la suma de todos los montos (`total_amount`) en la tabla `orders`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT SUM(total_amount) AS total_ventas FROM orders;
```

</details>

---

### **Ejercicio 3: Calcular el importe promedio de los pedidos**

Muestra el importe medio (`AVG`) de los pedidos.

<details><summary>Mostrar Solución</summary>

```sql
SELECT AVG(total_amount) AS promedio_pedidos FROM orders;
```

</details>

---

### **Ejercicio 4: Buscar el pedido de mayor importe**

Consulta cuál fue el pedido más caro registrado.

<details><summary>Mostrar Solución</summary>

```sql
SELECT MAX(total_amount) AS pedido_mas_caro FROM orders;
```

</details>

---

### **Ejercicio 5: Obtener el pedido más barato**

Consulta el valor mínimo del campo `total_amount`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT MIN(total_amount) AS pedido_mas_barato FROM orders;
```

</details>

---

### **Ejercicio 6: Agrupar pedidos por cliente**

Muestra cuántos pedidos ha hecho cada cliente.

<details><summary>Mostrar Solución</summary>

```sql
SELECT customer_id, COUNT(*) AS cantidad_pedidos
FROM orders
GROUP BY customer_id;
```

</details>

---

### **Ejercicio 7: Total gastado por cliente**

Consulta cuánto ha gastado cada cliente sumando el campo `total_amount`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id;
```

</details>

---

### **Ejercicio 8: Clientes con más de 2 pedidos**

Filtra solo los clientes que tengan más de dos pedidos registrados.

<details><summary>Mostrar Solución</summary>

```sql
SELECT customer_id, COUNT(*) AS total_pedidos
FROM orders
GROUP BY customer_id
HAVING total_pedidos > 2;
```

</details>

---

### **Ejercicio 9: Media de gasto por cliente con más de 100€ gastados**

Obtén el promedio de gasto por cliente y filtra aquellos que hayan gastado más de 100€.

<details><summary>Mostrar Solución</summary>

```sql
SELECT customer_id, AVG(total_amount) AS media_gasto
FROM orders
GROUP BY customer_id
HAVING media_gasto > 100;
```

</details>

---

### **Ejercicio 10: Agrupar por cliente y día**

Muestra cuántos pedidos ha hecho cada cliente por día.

<details><summary>Mostrar Solución</summary>

```sql
SELECT customer_id, DATE(created_at) AS fecha, COUNT(*) AS pedidos_dia
FROM orders
GROUP BY customer_id, fecha;
```

</details>
