# **Tema 12: Triggers (Disparadores) en MySQL**

En este tema aprenderemos a:

- Entender qué es un trigger y cuándo usarlo.
- Crear triggers para automatizar acciones.
- Conocer los diferentes momentos de ejecución (`BEFORE` y `AFTER`).
- Gestionar y eliminar triggers.

---

## **1. ¿Qué es un trigger?**

Un **trigger** (o disparador) es un objeto de base de datos que se ejecuta automáticamente cuando ocurre un evento específico (`INSERT`, `UPDATE`, `DELETE`) sobre una tabla.

### **Ventajas:**

- Automatiza tareas como auditoría, validaciones o cálculos.
- Garantiza integridad de datos a nivel de base de datos.

### **Desventajas:**

- Puede dificultar el seguimiento del flujo de datos.
- Un mal diseño puede afectar al rendimiento.

---

## **2. Tipos de triggers según el momento de ejecución**

- **`BEFORE`**: Se ejecuta antes de que se realice la operación.
- **`AFTER`**: Se ejecuta después de que se realice la operación.

---

## **3. Crear un trigger básico**

Ejemplo: Auditar inserciones en la tabla `orders` guardando datos en una tabla `orders_log`.

```sql
DELIMITER $$
CREATE TRIGGER log_new_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  INSERT INTO orders_log(order_id, log_date)
  VALUES (NEW.id, NOW());
END $$
DELIMITER ;
```

- `NEW.columna` hace referencia al valor nuevo de la columna.
- En triggers `BEFORE`, también se puede modificar `NEW.columna` para cambiar el valor antes de insertarlo.

---

## **4. Trigger BEFORE con validación**

Ejemplo: Evitar insertar un precio negativo en `products`.

```sql
DELIMITER $$
CREATE TRIGGER validate_product_price
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.price < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El precio no puede ser negativo';
  END IF;
END $$
DELIMITER ;
```

---

## **5. Eliminar un trigger**

```sql
DROP TRIGGER IF EXISTS log_new_order;
```

---

## **6. Ver triggers existentes**

```sql
SHOW TRIGGERS;
```

---

[![Triggers](https://img.youtube.com/vi/Z_IzfkrJDDg/0.jpg)](https://www.youtube.com/watch?v=Z_IzfkrJDDg&list=PLzA2VyZwsq__lL586xdEFPJtV-gmYhP4N)

---

## **7. Buenas prácticas**

- Usar triggers solo cuando la lógica debe ejecutarse **siempre** junto con la operación.
- Evitar lógica muy compleja para no afectar el rendimiento.
- Documentar cada trigger y su propósito.

---

## **8. Conclusión**

- Los triggers permiten automatizar acciones ante cambios en una tabla.
- Pueden ejecutarse antes o después de la operación.
- Son útiles para auditoría, validaciones y mantenimiento automático de datos.

---

En el próximo tema aprenderemos a **crear y usar funciones** y veremos la diferencia con los procedimientos almacenados.
