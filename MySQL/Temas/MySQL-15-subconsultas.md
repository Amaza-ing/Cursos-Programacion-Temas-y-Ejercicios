# **Tema 15: Subconsultas y Consultas con WITH en MySQL**

En este tema aprenderemos a:

- Utilizar subconsultas para construir consultas más complejas.
- Comprender las subconsultas en cláusulas `SELECT`, `FROM` y `WHERE`.
- Emplear expresiones comunes de tabla (`WITH`) para organizar consultas temporales reutilizables.

---

## **1. ¿Qué es una subconsulta?**

Una **subconsulta** es una consulta dentro de otra consulta. Permite obtener datos intermedios que se usan como entrada en la consulta principal.

### **Ejemplo básico:**

```sql
SELECT *
FROM customers
WHERE id IN (
  SELECT customer_id FROM orders WHERE total_amount > 100
);
```

---

## **2. Subconsultas en la cláusula WHERE**

Usadas para filtrar resultados según una condición que depende de otra tabla.

```sql
SELECT name
FROM products
WHERE id IN (
  SELECT product_id FROM order_details WHERE quantity >= 5
);
```

---

## **3. Subconsultas en la cláusula FROM**

Permiten crear tablas temporales que luego pueden ser consultadas.

```sql
SELECT customer_id, total
FROM (
  SELECT customer_id, SUM(total_amount) AS total
  FROM orders
  GROUP BY customer_id
) AS resumen
WHERE total > 200;
```

---

## **4. Subconsultas en la cláusula SELECT**

Permiten mostrar valores adicionales calculados para cada fila.

```sql
SELECT c.first_name,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) AS total_pedidos
FROM customers c;
```

---

## **5. Consultas con WITH (Common Table Expressions)**

La cláusula `WITH` permite definir subconsultas temporales con nombre, facilitando la lectura y reutilización de código.

### **Ejemplo:**

```sql
WITH ventas_por_cliente AS (
  SELECT customer_id, SUM(total_amount) AS total
  FROM orders
  GROUP BY customer_id
)
SELECT * FROM ventas_por_cliente
WHERE total > 150;
```

---

## **6. Múltiples subconsultas con WITH**

Puedes definir varias subconsultas separadas por comas.

```sql
WITH clientes_activos AS (
  SELECT id, first_name FROM customers WHERE newsletter_subscribed = TRUE
),
pedidos_totales AS (
  SELECT customer_id, COUNT(*) AS pedidos FROM orders GROUP BY customer_id
)
SELECT ca.first_name, pt.pedidos
FROM clientes_activos ca
JOIN pedidos_totales pt ON ca.id = pt.customer_id;
```

---

## **7. Ventajas de usar WITH**

- Mejora la legibilidad.
- Permite evitar repetir subconsultas.
- Ideal para consultas complejas divididas en pasos.

---

[![Subconsultas con WITH](https://img.youtube.com/vi/q4xodEiY8B8/0.jpg)](https://www.youtube.com/watch?v=q4xodEiY8B8&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **8. Conclusión**

- Las subconsultas permiten incorporar resultados intermedios.
- Pueden usarse en `WHERE`, `FROM`, `SELECT`.
- `WITH` (CTE) ofrece una forma clara de definir consultas auxiliares reutilizables.

---

En el siguiente tema aprenderemos a **utilizar PARTITION BY**.
