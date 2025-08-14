# **Ejercicios - Tema 20: Uso de REPEAT y LOOP en MySQL**

A continuación, encontrarás 6 ejercicios prácticos para trabajar con los bucles **REPEAT** y **LOOP** en MySQL.

Intenta resolverlos antes de consultar la solución.

---

### **Ejercicio 1: REPEAT para insertar números impares**

Crea un procedimiento `insertar_impares_repeat` que inserte en `numbers(value)` los **impares** desde 1 hasta nine (1, 3, 5, 7, 9) usando `REPEAT`.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_impares_repeat()
BEGIN
  DECLARE v INT DEFAULT 1;
  REPEAT
    INSERT INTO numbers(value) VALUES (v);
    SET v = v + 2;
  UNTIL v > 9
  END REPEAT;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 2: REPEAT con suma acumulada**

Crea un procedimiento `sumar_de_siete_en_siete` que vaya acumulando en `v_total` de 7 en 7 y registre cada valor en `accumulated(total)` **hasta que** `v_total` sea **mayor o igual a 70**.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE sumar_de_siete_en_siete()
BEGIN
  DECLARE v_total INT DEFAULT 0;
  REPEAT
    SET v_total = v_total + 7;
    INSERT INTO accumulated(total) VALUES (v_total);
  UNTIL v_total >= 70
  END REPEAT;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 3: LOOP con `LEAVE` e `ITERATE`**

Crea un procedimiento `insertar_multiplos_de_cinco` que recorra números desde 1 hasta 50 usando `LOOP`. Inserta en `numbers(value)` **solo los múltiplos de 5**. Usa `ITERATE` para **saltar** los que no lo sean y `LEAVE` para salir al superar 50.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE insertar_multiplos_de_cinco()
BEGIN
  DECLARE v INT DEFAULT 1;
  bucle: LOOP
    IF v > 50 THEN
      LEAVE bucle;
    END IF;

    IF v % 5 <> 0 THEN
      SET v = v + 1;
      ITERATE bucle;
    END IF;

    INSERT INTO numbers(value) VALUES (v);
    SET v = v + 1;
  END LOOP bucle;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 4: LOOP anidado para tabla de combinaciones**

Crea un procedimiento `generar_combinaciones_3x3` que llene `pairs(a, b)` con todas las combinaciones **(a, b)** donde `a` y `b` van de **1 a 3** usando dos `LOOP` anidados y `LEAVE` en cada uno.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE generar_combinaciones_3x3()
BEGIN
  DECLARE a INT DEFAULT 1;
  DECLARE b INT;

  ext: LOOP
    IF a > 3 THEN LEAVE ext; END IF;

    SET b = 1;
    int: LOOP
      IF b > 3 THEN LEAVE int; END IF;
      INSERT INTO pairs(a, b) VALUES (a, b);
      SET b = b + 1;
    END LOOP int;

    SET a = a + 1;
  END LOOP ext;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 5: Procesar cola con LOOP hasta que no queden elementos**

Dada una tabla `task_queue(id, processed TINYINT(1))`, crea un procedimiento `procesar_cola` que, usando `LOOP`, marque como `processed = 1` de **uno en uno** las tareas **no procesadas**. Detén el bucle cuando **no existan más**.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE procesar_cola()
BEGIN
  DECLARE v_id INT;
  bucle: LOOP
    SELECT id INTO v_id FROM task_queue WHERE processed = 0 LIMIT 1;
    IF v_id IS NULL THEN
      LEAVE bucle;
    END IF;

    UPDATE task_queue SET processed = 1 WHERE id = v_id;
  END LOOP bucle;
END $$
DELIMITER ;
```

</details>

---

### **Ejercicio 6: REPEAT para generar fechas hacia atrás**

Crea un procedimiento `generar_ultimos_dias` que reciba `p_dias INT` y llene `dates_list(fecha)` con las fechas **desde hoy hacia atrás** `p_dias` días (incluyendo hoy) usando `REPEAT`.

<details><summary>Mostrar Solución</summary>

```sql
DELIMITER $$
CREATE PROCEDURE generar_ultimos_dias(IN p_dias INT)
BEGIN
  DECLARE v INT DEFAULT 0;
  REPEAT
    INSERT INTO dates_list(fecha) VALUES (DATE_SUB(CURDATE(), INTERVAL v DAY));
    SET v = v + 1;
  UNTIL v > p_dias
  END REPEAT;
END $$
DELIMITER ;
```

</details>
