# **Ejercicios - Tema 17: Transacciones en MySQL**

A continuación, encontrarás 5 ejercicios prácticos para trabajar con **transacciones** en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Transferencia entre cuentas con control de errores**

En la tabla `accounts(id, balance)`, realiza una transacción para transferir 250 de la cuenta `id = 3` a la cuenta `id = 4`. Si alguna actualización falla, revierte todos los cambios.

<details><summary>Mostrar Solución</summary>

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 250 WHERE id = 3;
UPDATE accounts SET balance = balance + 250 WHERE id = 4;
COMMIT;
-- Si algo falla:
-- ROLLBACK;
```

</details>

---

### **Ejercicio 2: Uso de SAVEPOINT para revertir parcialmente**

En la tabla `orders(id, status)`, actualiza primero el pedido `id = 10` a `status = 'SHIPPED'` y guarda un punto de control llamado `sp1`. Después actualiza el pedido `id = 11` a `status = 'SHIPPED'`, pero revierte solo esta última actualización usando `SAVEPOINT`.

<details><summary>Mostrar Solución</summary>

```sql
START TRANSACTION;
UPDATE orders SET status = 'SHIPPED' WHERE id = 10;
SAVEPOINT sp1;
UPDATE orders SET status = 'SHIPPED' WHERE id = 11;
ROLLBACK TO sp1;
COMMIT;
```

</details>

---

### **Ejercicio 3: Ajuste de inventario con validación**

En `inventory(product_id, quantity)`, resta 5 unidades del producto con `product_id = 7` solo si la cantidad disponible es mayor o igual a 5. Si no, revierte la transacción.

<details><summary>Mostrar Solución</summary>

```sql
START TRANSACTION;
UPDATE inventory
SET quantity = quantity - 5
WHERE product_id = 7 AND quantity >= 5;

-- Validar si se actualizó alguna fila
IF ROW_COUNT() = 0 THEN
  ROLLBACK;
ELSE
  COMMIT;
END IF;
```

</details>

---

### **Ejercicio 4: Cambio de nivel de aislamiento**

Configura el nivel de aislamiento a `READ COMMITTED` y luego inserta un nuevo cliente en `customers`. Asegúrate de confirmar la transacción.

<details><summary>Mostrar Solución</summary>

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
INSERT INTO customers(first_name, last_name, email)
VALUES ('Laura', 'Martínez', 'laura.martinez@example.com');
COMMIT;
```

</details>

---

### **Ejercicio 5: Múltiples operaciones con confirmación final**

En `products(id, price)` y `suppliers(id, city)`, actualiza el precio del producto `id = 5` a 19.99 y cambia la ciudad del proveedor `id = 2` a `'Barcelona'` en una misma transacción. Confirma solo si ambas operaciones se ejecutan correctamente.

<details><summary>Mostrar Solución</summary>

```sql
START TRANSACTION;
UPDATE products SET price = 19.99 WHERE id = 5;
UPDATE suppliers SET city = 'Barcelona' WHERE id = 2;
COMMIT;
-- Si alguna falla:
-- ROLLBACK;
```

</details>
