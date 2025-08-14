# **Tema 18: Uso de IF en Consultas y Procedimientos Almacenados en MySQL**

En este tema aprenderemos a:

- Usar `IF()` en consultas para tomar decisiones condicionales.
- Utilizar estructuras `IF ... THEN ... ELSE` dentro de procedimientos almacenados.
- Diferenciar entre `IF()` como función y `IF` como estructura de control.

---

## **1. IF() en consultas**

En MySQL, `IF()` es una **función** que permite evaluar una condición y devolver un valor si es verdadera y otro si es falsa.

### **Sintaxis:**

```sql
IF(condición, valor_si_verdadero, valor_si_falso)
```

### **Ejemplo:**

Mostrar el estado de un cliente según el campo `is_active`:

```sql
SELECT first_name,
       IF(is_active = 1, 'ACTIVO', 'INACTIVO') AS estado
FROM customers;
```

---

## **2. Uso de CASE como alternativa**

Aunque no es parte del tema principal, es útil saber que `CASE` también permite condicionales y es más flexible:

```sql
SELECT first_name,
       CASE
         WHEN is_active = 1 THEN 'ACTIVO'
         ELSE 'INACTIVO'
       END AS estado
FROM customers;
```

---

## **3. IF en procedimientos almacenados**

Dentro de procedimientos almacenados, `IF` se usa como **estructura de control**.

### **Sintaxis:**

```sql
IF condición THEN
   -- instrucciones
ELSEIF otra_condición THEN
   -- instrucciones
ELSE
   -- instrucciones
END IF;
```

### **Ejemplo:**

```sql
DELIMITER $$
CREATE PROCEDURE evaluar_cliente(IN p_id INT)
BEGIN
  DECLARE v_total DECIMAL(10,2);
  SELECT SUM(total_amount) INTO v_total
  FROM orders
  WHERE customer_id = p_id;

  IF v_total >= 1000 THEN
    SELECT 'Cliente Premium' AS categoria;
  ELSEIF v_total >= 500 THEN
    SELECT 'Cliente Frecuente' AS categoria;
  ELSE
    SELECT 'Cliente Ocasional' AS categoria;
  END IF;
END $$
DELIMITER ;
```

---

## **4. IF dentro de SET o SELECT en procedimientos**

Podemos usar `IF()` como función en procedimientos:

```sql
DELIMITER $$
CREATE PROCEDURE estado_cliente(IN p_id INT)
BEGIN
  DECLARE v_estado VARCHAR(20);
  SELECT IF(is_active = 1, 'ACTIVO', 'INACTIVO') INTO v_estado
  FROM customers
  WHERE id = p_id;
  SELECT v_estado AS estado;
END $$
DELIMITER ;
```

---

## **5. Buenas prácticas**

- Usar `IF()` para condiciones simples en consultas.
- Usar `IF ... THEN ... END IF` en procedimientos para lógica más compleja.
- Cuando hay múltiples condiciones, `CASE` suele ser más legible.

---

## **6. Conclusión**

- `IF()` en consultas devuelve valores condicionales sin modificar la estructura de las filas.
- `IF ... THEN` en procedimientos permite ejecutar distintas instrucciones según condiciones.
- Son herramientas clave para aplicar lógica condicional en SQL.

---

En el próximo tema veremos **cómo crear iteraciones usando `while`**.
