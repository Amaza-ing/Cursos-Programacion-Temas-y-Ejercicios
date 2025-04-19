# **Ejercicios - Tema 8: Consultas con JOIN en MySQL**

A continuación, encontrarás 6 ejercicios prácticos para aplicar distintos tipos de `JOIN` y consultar datos relacionados entre varias tablas.

Todos los ejercicios utilizan las siguientes tablas:

- `customers(id, first_name, last_name)`
- `orders(id, customer_id, created_at)`
- `order_details(order_id, product_id, quantity)`
- `products(id, name, price)`

---

### **Ejercicio 1: Mostrar el nombre completo de los clientes junto con sus IDs de pedido**

Muestra el `first_name`, `last_name` y el `id` del pedido para cada cliente que haya realizado un pedido.

<details><summary>Mostrar Solución</summary>

```sql
SELECT c.first_name, c.last_name, o.id AS order_id
FROM customers c
JOIN orders o ON c.id = o.customer_id;
```

</details>

---

### **Ejercicio 2: Obtener todos los pedidos (aunque no tengan detalles)**

Muestra el ID del pedido y la cantidad total de productos comprados. Incluye también los pedidos sin detalles.

<details><summary>Mostrar Solución</summary>

```sql
SELECT o.id AS order_id, SUM(od.quantity) AS total_items
FROM orders o
LEFT JOIN order_details od ON o.id = od.order_id
GROUP BY o.id;
```

</details>

---

### **Ejercicio 3: Ver productos que aparecen en algún pedido**

Lista el nombre de todos los productos que han sido incluidos al menos en un pedido.

<details><summary>Mostrar Solución</summary>

```sql
SELECT DISTINCT p.name
FROM products p
JOIN order_details od ON p.id = od.product_id;
```

</details>

---

### **Ejercicio 4: Mostrar el historial de pedidos de un cliente específico**

Muestra los pedidos del cliente con `id = 2`, indicando la fecha del pedido y el nombre de cada producto incluido.

<details><summary>Mostrar Solución</summary>

```sql
SELECT o.created_at, p.name AS product_name
FROM orders o
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id
WHERE o.customer_id = 2;
```

</details>

---

### **Ejercicio 5: Ver todos los productos, incluso los que nunca se han vendido**

Muestra todos los productos junto con la cantidad total vendida. Si un producto no se ha vendido, debe aparecer con cantidad nula o 0.

<details><summary>Mostrar Solución</summary>

```sql
SELECT p.name, SUM(od.quantity) AS total_vendida
FROM products p
LEFT JOIN order_details od ON p.id = od.product_id
GROUP BY p.id;
```

</details>

---

### **Ejercicio 6: Obtener el gasto total por cliente**

Muestra el nombre de cada cliente y la suma total gastada, multiplicando cantidad por precio de cada producto.

<details><summary>Mostrar Solución</summary>

```sql
SELECT c.first_name, c.last_name, SUM(od.quantity * p.price) AS total_gastado
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
JOIN products p ON od.product_id = p.id
GROUP BY c.id;
```

</details>
