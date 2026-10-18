# **Exercises - Topic 20: Using REPEAT and LOOP in MySQL**

Below you will find 6 practical exercises to work with **REPEAT** and **LOOP** loops in MySQL.

Try to solve them before looking at the solution.

---

### **Exercise 1: REPEAT to insert odd numbers**

Create an `insertar_impares_repeat` procedure that inserts the **odd** numbers from 1 to 9 (1, 3, 5, 7, 9) into `numbers(value)` using `REPEAT`.

<details><summary>Show solution</summary>

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

### **Exercise 2: REPEAT with a running sum**

Create a `sumar_de_siete_en_siete` procedure that adds 7 at a time to `v_total` and records each value in `accumulated(total)` **until** `v_total` is **greater than or equal to 70**.

<details><summary>Show solution</summary>

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

### **Exercise 3: LOOP with `LEAVE` and `ITERATE`**

Create an `insertar_multiplos_de_cinco` procedure that goes through the numbers from 1 to 50 using `LOOP`. Insert **only the multiples of 5** into `numbers(value)`. Use `ITERATE` to **skip** the ones that aren't and `LEAVE` to exit once the number goes past 50.

<details><summary>Show solution</summary>

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

### **Exercise 4: Nested LOOP for a combinations table**

Create a `generar_combinaciones_3x3` procedure that fills `pairs(a, b)` with all the combinations **(a, b)** where `a` and `b` range from **1 to 3**, using two nested `LOOP`s with a `LEAVE` in each one.

<details><summary>Show solution</summary>

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

### **Exercise 5: Process a queue with LOOP until no items are left**

Given a `task_queue(id, processed TINYINT(1))` table, create a `procesar_cola` procedure that, using `LOOP`, marks the **unprocessed** tasks as `processed = 1`, **one at a time**. Stop the loop when **there are none left**.

<details><summary>Show solution</summary>

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

### **Exercise 6: REPEAT to generate dates going backwards**

Create a `generar_ultimos_dias` procedure that takes `p_dias INT` and fills `dates_list(fecha)` with the dates **going back from today** `p_dias` days (including today), using `REPEAT`.

<details><summary>Show solution</summary>

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
