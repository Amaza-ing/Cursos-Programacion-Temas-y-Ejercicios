# **Tema 16: Uso de PARTITION BY en MySQL**

En este tema aprenderemos a:

- Comprender qué es `PARTITION BY` y cuándo usarlo.
- Aplicarlo con funciones de ventana (`window functions`).
- Diferenciar `PARTITION BY` de `GROUP BY`.

---

## **1. ¿Qué es PARTITION BY?**

`PARTITION BY` es una cláusula utilizada junto con **funciones de ventana** para dividir un conjunto de resultados en grupos (particiones) y aplicar una función sobre cada grupo **sin colapsar las filas** como haría `GROUP BY`.

Se ejecuta después de la cláusula `FROM` y `WHERE`, pero antes de `ORDER BY`.

---

## **2. Sintaxis básica**

```sql
funcion_ventana(...) OVER (PARTITION BY columna)
```

Puedes combinarlo con `ORDER BY` dentro del mismo `OVER`:

```sql
funcion_ventana(...) OVER (PARTITION BY columna ORDER BY otra_columna)
```

---

## **3. Ejemplo básico**

Supongamos la tabla `orders(id, customer_id, total_amount, created_at)`.

Queremos saber el **total de pedidos** por cliente, mostrando todas las filas:

```sql
SELECT id,
       customer_id,
       total_amount,
       COUNT(*) OVER (PARTITION BY customer_id) AS pedidos_por_cliente
FROM orders;
```

> A diferencia de `GROUP BY`, este resultado muestra todas las filas originales junto con la información agregada.

---

## **4. Usar PARTITION BY con funciones de ventana comunes**

- `ROW_NUMBER()`: Numera filas en cada partición.
- `RANK()` y `DENSE_RANK()`: Asignan rangos por partición.
- `SUM()`, `AVG()`, `COUNT()`: Agregan datos dentro de cada partición.

**Ejemplo:** Ranking de pedidos por importe dentro de cada cliente.

```sql
SELECT customer_id,
       id AS order_id,
       total_amount,
       RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) AS rank_cliente
FROM orders;
```

---

## **5. Diferencias entre PARTITION BY y GROUP BY**

| Característica                      | PARTITION BY | GROUP BY                            |
| ----------------------------------- | ------------ | ----------------------------------- |
| Mantiene todas las filas originales | Sí           | No (colapsa en una por grupo)       |
| Se usa con funciones de ventana     | Sí           | No                                  |
| Devuelve columnas no agrupadas      | Sí           | Solo columnas agregadas o agrupadas |

---

## **6. Combinar PARTITION BY y ORDER BY**

Podemos obtener acumulados ordenados dentro de cada partición:

```sql
SELECT customer_id,
       id AS order_id,
       total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY created_at) AS acumulado
FROM orders;
```

---

[![PARTITION BY](https://img.youtube.com/vi/uGM8a25TKNU/0.jpg)](https://www.youtube.com/watch?v=uGM8a25TKNU&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Buenas prácticas**

- Usar `PARTITION BY` cuando necesites cálculos por grupo sin perder el detalle de las filas.
- Combinarlo con `ORDER BY` para obtener resultados acumulativos o rankings.
- No abusar de funciones de ventana en tablas muy grandes sin índices apropiados.

---

## **8. Conclusión**

- `PARTITION BY` divide los resultados en grupos para aplicar funciones de ventana.
- A diferencia de `GROUP BY`, mantiene todas las filas originales.
- Es útil para obtener métricas por grupo conservando el detalle de cada fila.

---

En el próximo tema veremos **Qué son y cómo usar las transacciones**.
