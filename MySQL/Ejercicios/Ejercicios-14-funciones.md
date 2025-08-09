# **Ejercicios - Tema 14: Booleanos y Fechas en MySQL**

A continuación, encontrarás 5 ejercicios prácticos para trabajar con columnas y variables **booleanas** y de **fecha** en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Actualizar un booleano según una condición de fecha**

En la tabla `subscriptions(user_id, expires_at DATE, is_active BOOLEAN)`, marca como inactivos (`is_active = FALSE`) los registros cuya fecha `expires_at` sea **anterior a hoy**.

<details><summary>Mostrar Solución</summary>

```sql
UPDATE subscriptions
SET is_active = FALSE
WHERE expires_at < CURDATE();
```

</details>

---

### **Ejercicio 2: Calcular días restantes para un evento**

En la tabla `events(id, name, event_date DATE)`, muestra `name` y los **días que faltan** para cada evento (pueden salir valores negativos si ya pasó).

<details><summary>Mostrar Solución</summary>

```sql
SELECT name,
       DATEDIFF(event_date, CURDATE()) AS days_to_event
FROM events;
```

</details>

---

### **Ejercicio 3: Filtrar por rango de fechas y ordenar**

Obtén los registros de `orders(id, created_at DATETIME, total_amount)` realizados **entre el 1 y el 15 de mayo de 2025** (inclusive) y ordénalos del más reciente al más antiguo.

<details><summary>Mostrar Solución</summary>

```sql
SELECT id, created_at, total_amount
FROM orders
WHERE created_at BETWEEN '2025-05-01 00:00:00' AND '2025-05-15 23:59:59'
ORDER BY created_at DESC;
```

</details>

---

### **Ejercicio 4: Formatear fecha y mostrar estado booleano**

Muestra de `customers(id, first_name, signup_date DATE, is_active BOOLEAN)` el `first_name`, la `signup_date` con formato `DD/MM/YYYY` y un campo calculado `status` con valor `'ACTIVE'` cuando `is_active = 1` y `'INACTIVE'` en caso contrario.

<details><summary>Mostrar Solución</summary>

```sql
SELECT first_name,
       DATE_FORMAT(signup_date, '%d/%m/%Y') AS signup_date_formatted,
       CASE WHEN is_active = 1 THEN 'ACTIVE' ELSE 'INACTIVE' END AS status
FROM customers;
```

</details>

---

### **Ejercicio 5: Procedimiento con variables booleanas y de fecha**

Crea un procedimiento `deactivate_old_posts(days_back INT)` que desactive (`is_published = 0`) en `posts(id, published_at DATETIME, is_published TINYINT(1))` las entradas **publicadas hace más de** `days_back` días.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE deactivate_old_posts(IN days_back INT)
BEGIN
  DECLARE v_cutoff DATETIME;
  SET v_cutoff = DATE_SUB(NOW(), INTERVAL days_back DAY);

  UPDATE posts
  SET is_published = 0
  WHERE published_at < v_cutoff;
END $$
DELIMITER ;

CALL deactivate_old_posts(30);
```

</details>
