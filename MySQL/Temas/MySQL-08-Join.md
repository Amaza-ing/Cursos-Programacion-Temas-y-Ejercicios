# **Tema 8: Consultas con JOIN en MySQL**

En este tema aprenderemos a:

- Entender qué es un `JOIN` y para qué se usa.
- Utilizar distintos tipos de `JOIN` para combinar información de múltiples tablas.
- Consultar datos relacionados entre tablas.

---

## **1. ¿Qué es un JOIN?**

`JOIN` permite combinar filas de dos o más tablas según una relación lógica entre ellas, normalmente a través de claves foráneas.

### **Ejemplo básico:**

Supongamos las siguientes tablas:

**Tabla `customers`**
| id | first_name |
|----|-------------|
| 1 | Laura |

**Tabla `orders`**
| id | customer_id | total_amount |
|----|-------------|---------------|
| 1 | 1 | 89.99 |

Queremos saber qué cliente hizo qué pedido. Usamos un `JOIN`:

```sql
SELECT customers.first_name, orders.total_amount
FROM customers
JOIN orders ON customers.id = orders.customer_id;
```

---

## **2. Tipos de JOIN**

### **INNER JOIN**

Devuelve solo las filas que tienen coincidencia en ambas tablas.

```sql
SELECT *
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id;
```

### **LEFT JOIN**

Devuelve todas las filas de la tabla izquierda, y las coincidentes de la tabla derecha (si hay).

```sql
SELECT *
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;
```

### **RIGHT JOIN**

Devuelve todas las filas de la tabla derecha, y las coincidentes de la izquierda.

```sql
SELECT *
FROM orders
RIGHT JOIN customers ON customers.id = orders.customer_id;
```

---

## **3. JOIN con alias**

Usar alias hace más legibles las consultas:

```sql
SELECT c.first_name, o.total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id;
```

---

## **4. JOIN con más de dos tablas**

También podemos unir más de dos tablas en una misma consulta:

```sql
SELECT c.first_name, o.id AS order_id, p.name AS product_name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details d ON o.id = d.order_id
JOIN products p ON d.product_id = p.id;
```

---

## **5. Consultas comunes con JOIN**

- Pedidos de cada cliente
- Productos incluidos en cada pedido
- Total gastado por cliente
- Historial de compras con nombres de productos

---

[![JOIN](https://img.youtube.com/vi/y9-JFPGvEsI/0.jpg)](https://www.youtube.com/watch?v=y9-JFPGvEsI&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **6. Conclusión**

- `JOIN` permite unir tablas relacionadas a través de claves.
- `INNER`, `LEFT`, `RIGHT` ofrecen diferentes formas de obtener los datos.
- Alias (`AS`) facilitan la lectura.
- Las consultas complejas a menudo implican múltiples `JOIN`.

---

En el siguiente tema aprenderemos a **crear y gestionar vistas (`VIEW`) para simplificar y reutilizar consultas complejas.**
