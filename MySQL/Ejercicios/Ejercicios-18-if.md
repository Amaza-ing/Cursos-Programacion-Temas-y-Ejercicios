# **Ejercicios - Tema 18: Uso de IF en Consultas y Procedimientos Almacenados en MySQL**

A continuación, encontrarás 6 ejercicios prácticos para trabajar con **IF** en MySQL, tanto como función en consultas como estructura de control en procedimientos.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: IF en consulta para clasificación de precios**

En la tabla `products(id, name, price)`, muestra el nombre y una columna calculada `categoria_precio` que indique `'Caro'` si `price > 50`, en caso contrario `'Económico'`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT name,
       IF(price > 50, 'Caro', 'Económico') AS categoria_precio
FROM products;
```

</details>

---

### **Ejercicio 2: IF en consulta con comparación de fechas**

En la tabla `events(id, name, event_date)`, muestra el nombre y un campo `estado_evento` que indique `'Pasado'` si `event_date` es anterior a la fecha actual, o `'Próximo'` en caso contrario.

<details><summary>Mostrar Solución</summary>

```sql
SELECT name,
       IF(event_date < CURDATE(), 'Pasado', 'Próximo') AS estado_evento
FROM events;
```

</details>

---

### **Ejercicio 3: Procedimiento con IF y ELSEIF**

Crea un procedimiento `evaluar_producto` que reciba `p_id INT` y muestre:

- `'Muy caro'` si `price > 100`
- `'Caro'` si `price > 50`
- `'Económico'` en otro caso.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE evaluar_producto(IN p_id INT)
BEGIN
  DECLARE v_precio DECIMAL(10,2);
  SELECT price INTO v_precio FROM products WHERE id = p_id;

  IF v_precio > 100 THEN
    SELECT 'Muy caro' AS resultado;
  ELSEIF v_precio > 50 THEN
    SELECT 'Caro' AS resultado;
  ELSE
    SELECT 'Económico' AS resultado;
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 4: IF en SELECT con cálculo adicional**

En la tabla `orders(id, total_amount)`, muestra el `id`, el `total_amount` y una columna `total_con_envio` que sume 5 si `total_amount` es menor de 50, en caso contrario deje el mismo valor.

<details><summary>Mostrar Solución</summary>

```sql
SELECT id,
       total_amount,
       IF(total_amount < 50, total_amount + 5, total_amount) AS total_con_envio
FROM orders;
```

</details>

---

### **Ejercicio 5: Procedimiento con IF anidado**

Crea un procedimiento `clasificar_cliente_por_pedidos` que reciba `p_id INT` y clasifique así:

- `'Sin pedidos'` si no tiene registros en `orders`.
- `'Cliente nuevo'` si tiene 1 o 2 pedidos.
- `'Cliente recurrente'` si tiene más de 2 pedidos.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE clasificar_cliente_por_pedidos(IN p_id INT)
BEGIN
  DECLARE v_total_pedidos INT;
  SELECT COUNT(*) INTO v_total_pedidos FROM orders WHERE customer_id = p_id;

  IF v_total_pedidos = 0 THEN
    SELECT 'Sin pedidos' AS categoria;
  ELSEIF v_total_pedidos <= 2 THEN
    SELECT 'Cliente nuevo' AS categoria;
  ELSE
    SELECT 'Cliente recurrente' AS categoria;
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 6: IF en combinación con otras funciones**

En la tabla `employees(id, hire_date)`, muestra el `id`, la `hire_date` y una columna `antiguedad_categoria` que indique `'Antiguo'` si lleva más de 5 años en la empresa, en caso contrario `'Reciente'`.

<details><summary>Mostrar Solución</summary>

```sql
SELECT id,
       hire_date,
       IF(TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5, 'Antiguo', 'Reciente') AS antiguedad_categoria
FROM employees;
```

</details>
