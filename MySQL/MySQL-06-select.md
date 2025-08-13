# **Tema 6: Consultas Avanzadas con SELECT y Condiciones**

En este tema aprenderemos a:

- Usar `SELECT` para extraer información específica de una tabla.
- Aplicar filtros con `WHERE` y operadores lógicos.
- Ordenar resultados con `ORDER BY`.
- Limitar la cantidad de filas con `LIMIT`.

---

## **1. SELECT: Consultas básicas**

La sentencia `SELECT` permite consultar datos de una o varias columnas.

### **Ejemplos:**

```sql
SELECT * FROM customers; -- Todas las columnas
SELECT first_name, last_name FROM customers; -- Sólo algunas columnas
```

---

## **2. WHERE: Filtrar resultados**

La cláusula `WHERE` permite mostrar sólo las filas que cumplan una condición.

### **Ejemplos:**

```sql
SELECT * FROM customers
WHERE newsletter_subscribed = TRUE;

SELECT * FROM orders
WHERE total_amount > 100;
```

### **Operadores comunes:**

- `=`: igual a
- `!=` o `<>`: distinto de
- `>` / `<`: mayor / menor que
- `>=` / `<=`: mayor o igual / menor o igual
- `BETWEEN`: entre dos valores
- `IN`: en una lista
- `LIKE`: coincidencia parcial con comodines

```sql
SELECT * FROM customers WHERE first_name = 'Ana';
SELECT * FROM orders WHERE total_amount BETWEEN 50 AND 150;
SELECT * FROM customers WHERE city IN ('Madrid', 'Sevilla');
SELECT * FROM customers WHERE email LIKE '%@gmail.com';
```

---

## **3. Operadores lógicos**

### **AND**: ambas condiciones deben cumplirse

```sql
SELECT * FROM orders
WHERE total_amount > 100 AND customer_id = 2;
```

### **OR**: al menos una condición debe cumplirse

```sql
SELECT * FROM customers
WHERE city = 'Madrid' OR city = 'Barcelona';
```

### **NOT**: niega la condición

```sql
SELECT * FROM customers
WHERE NOT newsletter_subscribed;
```

---

## **4. ORDER BY: Ordenar resultados**

Ordena las filas según una o varias columnas.

```sql
SELECT * FROM customers
ORDER BY signup_date ASC; -- Orden ascendente

SELECT * FROM orders
ORDER BY total_amount DESC; -- Orden descendente
```

Se puede ordenar por múltiples columnas:

```sql
SELECT * FROM customers
ORDER BY city ASC, last_name ASC;
```

---

## **5. LIMIT: Limitar resultados**

Muestra sólo una cantidad específica de filas.

```sql
SELECT * FROM customers
LIMIT 5; -- Solo las primeras 5 filas
```

También puedes especificar un **desplazamiento**:

```sql
SELECT * FROM customers
LIMIT 5 OFFSET 10; -- Desde la fila 11 hasta la 15
```

---

## **6. Combinando WHERE, ORDER BY y LIMIT**

```sql
SELECT * FROM orders
WHERE total_amount > 50
ORDER BY created_at DESC
LIMIT 3;
```

Esta consulta muestra los 3 pedidos más recientes con total mayor a 50.

---

## **7. Conclusión**

- `SELECT` permite consultar datos específicos.
- `WHERE` filtra resultados según condiciones.
- `ORDER BY` organiza los resultados.
- `LIMIT` restringe la cantidad de filas mostradas.
- Combinando estas herramientas puedes obtener consultas muy potentes y específicas.

---

En el siguiente tema aprenderemos a trabajar con **funciones de agregación (SUM, COUNT, AVG, MAX, MIN) y agrupaciones con `GROUP BY`.**
