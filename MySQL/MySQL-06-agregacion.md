# **Tema 6: Funciones de Agregación y Agrupaciones en MySQL**

En este tema aprenderemos a:

- Utilizar funciones de agregación (`SUM`, `COUNT`, `AVG`, `MAX`, `MIN`).
- Agrupar datos con `GROUP BY`.
- Filtrar agrupaciones con `HAVING`.

---

## **1. ¿Qué son las funciones de agregación?**

Son funciones que operan sobre un conjunto de valores y devuelven un único resultado.

| Función   | Descripción               |
| --------- | ------------------------- |
| `SUM()`   | Suma de valores numéricos |
| `COUNT()` | Cuenta de registros       |
| `AVG()`   | Promedio                  |
| `MAX()`   | Valor máximo              |
| `MIN()`   | Valor mínimo              |

---

## **2. Ejemplos de funciones de agregación**

Supongamos que tenemos la tabla `orders`:

| order_id | customer_id | total_amount |
| -------- | ----------- | ------------ |
| 1        | 1           | 50.00        |
| 2        | 2           | 120.00       |
| 3        | 1           | 80.00        |

### **SUM**

```sql
SELECT SUM(total_amount) AS total_ventas FROM orders;
```

### **COUNT**

```sql
SELECT COUNT(*) AS total_pedidos FROM orders;
```

### **AVG**

```sql
SELECT AVG(total_amount) AS promedio FROM orders;
```

### **MAX / MIN**

```sql
SELECT MAX(total_amount) AS venta_maxima FROM orders;
SELECT MIN(total_amount) AS venta_minima FROM orders;
```

---

## **3. Agrupar datos con `GROUP BY`**

El `GROUP BY` permite aplicar funciones de agregación por grupos de una columna específica.

### **Ejemplo: total gastado por cliente**

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id;
```

### **Ejemplo: número de pedidos por cliente**

```sql
SELECT customer_id, COUNT(*) AS cantidad_pedidos
FROM orders
GROUP BY customer_id;
```

---

## **4. Filtrar grupos con `HAVING`**

La cláusula `HAVING` se utiliza para aplicar condiciones después de agrupar los datos (a diferencia de `WHERE`, que se usa antes del agrupamiento).

### **Ejemplo: clientes que gastaron más de 100€**

```sql
SELECT customer_id, SUM(total_amount) AS total_gastado
FROM orders
GROUP BY customer_id
HAVING total_gastado > 100;
```

---

## **5. Agrupar por varias columnas**

También es posible agrupar por más de una columna:

### **Ejemplo: número de pedidos por cliente y por fecha**

```sql
SELECT customer_id, DATE(created_at) AS fecha, COUNT(*) AS pedidos
FROM orders
GROUP BY customer_id, fecha;
```

---

## **6. Conclusión**

- Las funciones de agregación permiten resumir datos.
- `GROUP BY` agrupa los registros para aplicar funciones como `SUM` o `COUNT`.
- `HAVING` permite filtrar agrupaciones según condiciones.
- Estas herramientas son muy útiles para generar reportes, estadísticas y resúmenes.

---

En el siguiente tema aprenderemos a **unir varias tablas con `JOIN` para consultar datos relacionados.**
