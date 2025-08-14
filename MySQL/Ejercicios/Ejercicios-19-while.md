# **Ejercicios - Tema 19: Uso de WHILE en MySQL**

A continuación, encontrarás 6 ejercicios prácticos para trabajar con **bucles WHILE** en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: Insertar múltiplos de 3**

Crea un procedimiento `insertar_multiplos_tres` que inserte en la tabla `numbers(value)` los números múltiplos de 3 desde 3 hasta 30.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_multiplos_tres()
BEGIN
  DECLARE v_num INT DEFAULT 3;

  WHILE v_num <= 30 DO
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num + 3;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 2: Rellenar tabla de fechas**

Crea un procedimiento `rellenar_fechas` que inserte en la tabla `dates_list(fecha)` las fechas desde `'2025-01-01'` hasta `'2025-01-10'`.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE rellenar_fechas()
BEGIN
  DECLARE v_fecha DATE DEFAULT '2025-01-01';

  WHILE v_fecha <= '2025-01-10' DO
    INSERT INTO dates_list(fecha) VALUES (v_fecha);
    SET v_fecha = DATE_ADD(v_fecha, INTERVAL 1 DAY);
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 3: Reducir inventario paso a paso**

Crea un procedimiento `vender_producto` que reciba `p_id INT` y `p_cantidad INT`. Reste 1 del inventario de `products_stock(product_id, quantity)` hasta vender `p_cantidad` unidades.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE vender_producto(IN p_id INT, IN p_cantidad INT)
BEGIN
  DECLARE v_contador INT DEFAULT 0;

  WHILE v_contador < p_cantidad DO
    UPDATE products_stock
    SET quantity = quantity - 1
    WHERE product_id = p_id AND quantity > 0;
    SET v_contador = v_contador + 1;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 4: Insertar potencias de 2**

Crea un procedimiento `insertar_potencias_dos` que inserte en `numbers(value)` las potencias de 2 desde 1 hasta 1024.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_potencias_dos()
BEGIN
  DECLARE v_valor INT DEFAULT 1;

  WHILE v_valor <= 1024 DO
    INSERT INTO numbers(value) VALUES (v_valor);
    SET v_valor = v_valor * 2;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 5: Aumentar sueldos hasta un tope**

Crea un procedimiento `incrementar_sueldos` que incremente en 50 el sueldo (`salary`) de todos los empleados en `employees` cuyo salario sea menor de 1000, repitiendo el aumento hasta que todos tengan al menos 1000.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE incrementar_sueldos()
BEGIN
  DECLARE v_min_salary DECIMAL(10,2);

  SELECT MIN(salary) INTO v_min_salary FROM employees;

  WHILE v_min_salary < 1000 DO
    UPDATE employees
    SET salary = salary + 50
    WHERE salary < 1000;

    SELECT MIN(salary) INTO v_min_salary FROM employees;
  END WHILE;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 6: Contador regresivo**

Crea un procedimiento `contador_regresivo` que empiece en `p_inicio INT` y vaya insertando valores decrecientes en la tabla `numbers(value)` hasta llegar a 1.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE contador_regresivo(IN p_inicio INT)
BEGIN
  DECLARE v_num INT;
  SET v_num = p_inicio;

  WHILE v_num >= 1 DO
    INSERT INTO numbers(value) VALUES (v_num);
    SET v_num = v_num - 1;
  END WHILE;
END $$
DELIMITER ;
```

</details>
