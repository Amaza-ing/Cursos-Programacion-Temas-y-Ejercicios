# **Ejercicios - Tema 12: Triggers (Disparadores) en MySQL**

A continuación, encontrarás 5 ejercicios prácticos para trabajar con **triggers** en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Auditoría de actualizaciones de precios**

Crea un trigger `audit_price_update` que registre en una tabla `price_changes_log` el `product_id`, el precio antiguo y el precio nuevo cada vez que se actualice el precio de un producto.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE TRIGGER audit_price_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.price <> OLD.price THEN
    INSERT INTO price_changes_log(product_id, old_price, new_price, change_date)
    VALUES (OLD.id, OLD.price, NEW.price, NOW());
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 2: Validar stock mínimo antes de insertar**

Crea un trigger `validate_stock_before_insert` que impida insertar un producto en `inventory` si la cantidad (`quantity`) es menor que 0.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE TRIGGER validate_stock_before_insert
BEFORE INSERT ON inventory
FOR EACH ROW
BEGIN
  IF NEW.quantity < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La cantidad no puede ser negativa';
  END IF;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 3: Actualizar fecha de última modificación**

Crea un trigger `update_last_modified` que, cada vez que se actualice un registro en `customers`, cambie automáticamente el campo `last_modified` a la fecha y hora actual.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE TRIGGER update_last_modified
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
  SET NEW.last_modified = NOW();
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 4: Registrar eliminaciones de pedidos**

Crea un trigger `log_order_deletion` que, al eliminar un pedido de `orders`, inserte un registro en `deleted_orders_log` con el `order_id` y la fecha de eliminación.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE TRIGGER log_order_deletion
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
  INSERT INTO deleted_orders_log(order_id, deleted_at)
  VALUES (OLD.id, NOW());
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 5: Evitar cambios en el rol de administrador**

Crea un trigger `prevent_admin_role_change` que impida modificar el campo `role` de un usuario en `users` si el valor antiguo era `'admin'`.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE TRIGGER prevent_admin_role_change
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
  IF OLD.role = 'admin' AND NEW.role <> 'admin' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se permite cambiar el rol de administrador';
  END IF;
END $$
DELIMITER ;
```

</details>
